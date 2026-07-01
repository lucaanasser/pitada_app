# Marca do Pitada

Coloque aqui os arquivos da marca que acompanham o guia:

- `pitada-mark.svg` — o símbolo (os três pontos "pinch")
- `pitada-logo.svg` — a marca completa (símbolo + palavra)

Hoje o `Masthead` (`lib/core/widgets/masthead.dart`) desenha a marca em código
(pontos + palavra em Cormorant), então o app roda sem os SVGs. Quando adicioná-los,
dá para trocar o desenho por `SvgPicture.asset('assets/brand/pitada-mark.svg')`
usando o pacote `flutter_svg` (já no `pubspec.yaml`).

Esta pasta está declarada em `pubspec.yaml` (`assets:`); mantenha ao menos um
arquivo aqui para o Flutter não reclamar de asset vazio.
