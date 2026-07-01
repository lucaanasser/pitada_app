# Fontes do Pitada

O design system usa duas famílias (ver `lib/core/theme/typography.dart`):

- **Cormorant Garamond** — títulos, números, citações (`--disp` no protótipo)
- **Inter** — corpo, botões, rótulos (`--ui`)

## Como habilitar (uma vez)

1. Baixe os `.ttf` (grátis, licença SIL Open Font):
   - Cormorant Garamond: https://fonts.google.com/specimen/Cormorant+Garamond
   - Inter: https://fonts.google.com/specimen/Inter
2. Coloque nesta pasta com estes nomes exatos:
   ```
   assets/fonts/CormorantGaramond-Medium.ttf
   assets/fonts/CormorantGaramond-SemiBold.ttf
   assets/fonts/CormorantGaramond-Bold.ttf
   assets/fonts/Inter-Regular.ttf
   assets/fonts/Inter-Medium.ttf
   assets/fonts/Inter-SemiBold.ttf
   ```
3. Descomente o bloco `fonts:` no `pubspec.yaml` e rode `flutter pub get`.

Sem esse passo o app ainda roda — apenas cai na fonte do sistema. Os nomes de
família em `typography.dart` (`'Cormorant Garamond'` e `'Inter'`) já batem com o
`pubspec.yaml`, então basta adicionar os arquivos.
