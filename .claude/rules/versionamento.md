# Regra: Versionamento

Toda entrega que funciona vira **commit local**. Nunca dar `push` — quem empurra é o dono.

- Terminou de criar/mudar algo (feature, arquivo, correção, refactor) e passa no
  `flutter analyze`? Commit na hora.
- Um commit por unidade lógica. Mensagem curta em pt-BR, no imperativo, dizendo o QUÊ
  (ex.: `adiciona sheet de registro de peso`).
- **Autor único: o dono.** Sem trailer de co-autor, sem "Generated with…", sem menção a IA.
- Nunca commite segredo (`.env`, chaves) nem código quebrado.
