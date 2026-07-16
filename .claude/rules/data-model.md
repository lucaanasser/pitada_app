# Data Model

**Principle:** grams are the unit of truth; every other quantity is a reference derived from them.

These are domain rules, not storage rules. They hold regardless of table shape, and code that breaks them is wrong even when it compiles.

## Grams are the base
- Every ingredient quantity is stored in **grams**. Macros are computed in grams, always.
- The **human unit** ("2 eggs", "1 cup") is a *reference* for display and shopping — never the value macros are computed from.
- A conversion between human unit and grams belongs in `core/utils/`, never inlined at a call site.

## The shopping list sums by human unit
The list is what a human carries to a market, so it speaks in human units:
1. **Sum by human unit** across recipes — 2 recipes × 2 eggs = `4 un`.
2. **Subtract the pantry** from that sum.
3. What remains is the list.

Summing in grams and converting at the end is wrong: it produces "312 g de ovo" instead of "4 un".

## Folder vs sub-recipe — different things
| Concept | What it is | Macros |
|---|---|---|
| **Folder** | groups **independent** recipes (organization only) | do **not** add up — each recipe stands alone |
| **Sub-recipe** | a **component** of one dish (a sauce inside a pasta) | **add up** into the parent dish |

Never model one as the other. A folder is a shelf; a sub-recipe is an ingredient that happens to have its own steps.

## Checklist
1. Quantity stored in grams; the human unit is a display reference.
2. Macros computed from grams, never from the human unit.
3. Shopping list sums by human unit, then subtracts the pantry.
4. Folder groups independent recipes; sub-recipe macros roll up into the dish.
