// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/widgets/folder/open_strip_bar.dart
// O QUÊ:     A PASTA no rodapé da pasta aberta: faixa sólida na cor pastel do
//            hero com nome + contagem + botão de adicionar. A sombra p/ cima é
//            FUNCIONAL (oclusão dos papéis) — exceção deliberada documentada
//            na spec (FolderScreen.layout.bottom).
// USA:       core/theme (AppColors.shadow, pit, AppSpacing, AppType, AppIcons),
//            core/widgets/controls/pitada_button (PitadaIconButton).
// USADO POR: folder_screen (rodapé fixo da cena animada).
// SPEC:      specs/features/recipes.yaml (FolderScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';

/// Faixa da pasta aberta: ponto fixo da cena — são os papéis que saem/entram
/// por trás dela. Sempre sólida (nunca translúcida). Usada por: FolderScreen.
class OpenStripBar extends StatelessWidget {
  const OpenStripBar({
    super.key,
    required this.name,
    required this.hero,
    required this.count,
    required this.onAdd,
  });

  final String name;
  final String hero;
  final int count;
  final VoidCallback onAdd;

  /// Monta a faixa (cor do hero + sombra funcional) com nome, contagem e botão
  /// de adicionar. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final label = '$count receita${count == 1 ? '' : 's'}';
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: pit.card(hero),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: AppSpacing.screenH
              .copyWith(top: AppSpacing.lg, bottom: AppSpacing.lg),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppType.on(AppType.title, pit.text),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      label,
                      style: AppType.on(AppType.caption, pit.text2),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              PitadaIconButton(icon: AppIcons.add, onPressed: onAdd),
            ],
          ),
        ),
      ),
    );
  }
}
