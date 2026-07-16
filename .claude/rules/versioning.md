# Versioning

**Principle:** every working deliverable becomes a local commit, authored solely by the owner; never push.

- Finished creating or changing something (feature, file, fix, refactor) and it passes `flutter analyze`? Commit it right away.
- One commit per logical unit. Short message in pt-BR, imperative, stating WHAT (e.g. `adiciona sheet de registro de peso`).
- **Sole author: the owner.** No co-author trailer, no "Generated with…", no mention of AI.
- Never commit a secret (`.env`, keys) or broken code. Pushing is the owner's job.

## Checklist
1. Code passes `flutter analyze`.
2. One logical unit per commit; message in pt-BR imperative.
3. Author is the owner only; no co-author trailer.
4. No secrets, no broken code, no push.