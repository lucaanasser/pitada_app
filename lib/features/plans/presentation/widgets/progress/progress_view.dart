// ─────────────────────────────────────────────────────────────────────────────
// lib/features/plans/presentation/widgets/progress/progress_view.dart
// O QUÊ:     Corpo da sub-aba "Progresso", com o registro do dia como destaque:
//            Hoje (card + sequência) -> aderência (2 semanas) -> Padrões
//            (insights, some sem dados) -> Peso (compacto, por último).
// USA:       core/widgets (SectionHeader, PitadaButton, PitadaScaffold), theme/*,
//            TodaySection, AdherenceSection, InsightsSection, WeightSection,
//            progress_insights e o sheet de peso.
// USADO POR: plans_screen (sub-aba 1).
// SPEC:      specs/features/plans_progress.yaml (screens_e_widgets: ProgressView)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../../../core/widgets/layout/pitada_scaffold.dart';
import '../../../../../core/widgets/layout/section_header.dart';
import '../../../application/progress_insights.dart';
import '../../sheets/log/log_weight_sheet.dart';
import 'adherence_section.dart';
import 'insights_section.dart';
import 'today_section.dart';
import '../weight/weight_section.dart';

/// Sub-aba "Progresso": registro do dia em destaque, padrões e peso.
/// Usada por: PlansScreen.
class ProgressView extends ConsumerWidget {
  const ProgressView({super.key});

  /// Monta as seções na ordem da spec; 'Padrões' só aparece com insights.
  /// Usada por: PlansScreen.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(progressInsightsProvider);
    return ListView(
      padding: tabListPadding(context),
      children: [
        _section('Hoje', const TodaySection()),
        const SizedBox(height: AppSpacing.xxxl),
        _section('Últimas 2 semanas', const AdherenceSection()),
        if (insights.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xxxl),
          _section('Padrões', InsightsSection(insights: insights)),
        ],
        const SizedBox(height: AppSpacing.xxxl),
        _section('Peso', const WeightSection()),
        Padding(
          padding: AppSpacing.screenH,
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.lg),
            child: PitadaButton(
              label: 'Registrar peso',
              icon: AppIcons.weight,
              variant: PitadaButtonVariant.outline,
              onPressed: () => showLogWeightSheet(context),
            ),
          ),
        ),
      ],
    );
  }

  /// Uma seção padrão da aba: SectionHeader + respiro + conteúdo. Usada por: [build].
  Widget _section(String label, Widget child) {
    return Padding(
      padding: AppSpacing.screenH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(label: label),
          const SizedBox(height: AppSpacing.sm),
          child,
        ],
      ),
    );
  }
}
