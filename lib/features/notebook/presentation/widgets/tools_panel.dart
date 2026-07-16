// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/widgets/tools_panel.dart
// O QUÊ:     Painel "Ferramentas" do hub do Caderno: as 8 ferramentas agrupadas
//            pelos 3 pilares (Conhecimento/Prática/Repertório) numa tabela-mini
//            com divisórias internas grossas (desenho da NutritionCard).
// USA:       theme (pitada_colors, spacing, typography), providers
//            (contagens de cada ferramenta), go_router (navegação por célula).
// USADO POR: NotebookScreen (hub do Caderno).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/pitada_colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../../application/providers.dart';

/// Uma ferramenta do painel: rótulo, provider da contagem, rota e destaque.
/// Usada por: [ToolsPanel] para montar cada célula.
class _Tool {
  const _Tool(this.label, this.provider, this.route, {this.subtle = false});

  final String label;
  final ProviderListenable<AsyncValue<List<Object?>>> provider;
  final String route;
  final bool subtle;

  /// Contagem formatada da ferramenta ('–' enquanto carrega/erro).
  /// Usada por: [ToolsPanel]._cell.
  String countOf(WidgetRef ref) =>
      ref.watch(provider).valueOrNull?.length.toString() ?? '–';
}

/// Grupos do painel na ordem dos 3 pilares. Usado por: [ToolsPanel].
final _groups = <({String label, List<_Tool> tools})>[
  (
    label: 'Conhecimento',
    tools: [
      _Tool('Fichas', lessonsProvider, '/learning/cards'),
      _Tool('Notas', notesProvider, '/learning/notes'),
    ],
  ),
  (
    label: 'Prática',
    tools: [
      _Tool('Diário', diaryProvider, '/learning/diary'),
      _Tool('Versões', versionsProvider, '/learning/versions'),
      _Tool('Logs', logsProvider, '/learning/logs', subtle: true),
    ],
  ),
  (
    label: 'Repertório',
    tools: [
      _Tool('Rácios', ratiosProvider, '/learning/repertoire/ratios'),
      _Tool('Substituições', subsProvider, '/learning/repertoire/subs'),
      _Tool('Harmonizações', pairingsProvider, '/learning/repertoire/pairings'),
    ],
  ),
];

/// Painel das 8 ferramentas do Caderno em tabela-mini com borda e divisórias.
/// Usada por: NotebookScreen (hub do Caderno).
class ToolsPanel extends ConsumerWidget {
  const ToolsPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: pit.surf,
        borderRadius: AppSpacing.br(AppSpacing.radiusCard),
        border: Border.all(color: pit.border, width: AppSpacing.borderStrong),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var i = 0; i < _groups.length; i++) ...[
            if (i != 0)
              Container(height: AppSpacing.borderStrong, color: pit.border),
            _group(context, ref, pit, _groups[i]),
          ],
        ],
      ),
    );
  }

  /// Um pilar: rótulo em versalete + linha de células com divisórias verticais.
  /// Usada por: [build].
  Widget _group(
    BuildContext context,
    WidgetRef ref,
    PitadaColors pit,
    ({String label, List<_Tool> tools}) group,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.md,
            AppSpacing.lg,
            0,
          ),
          child: Text(
            group.label.toUpperCase(),
            style: AppType.on(AppType.label, pit.muted),
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < group.tools.length; i++) ...[
                if (i != 0)
                  Container(width: AppSpacing.borderStrong, color: pit.line2),
                _cell(context, ref, pit, group.tools[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// Uma célula: contagem em Space Grotesk + rótulo; a célula toda navega.
  /// Usada por: [_group].
  Widget _cell(
    BuildContext context,
    WidgetRef ref,
    PitadaColors pit,
    _Tool tool,
  ) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.push(tool.route),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tool.countOf(ref),
                style: AppType.on(
                  AppType.numeral,
                  tool.subtle ? pit.muted : pit.text,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                tool.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppType.on(
                  AppType.captionSm,
                  tool.subtle ? pit.faint : pit.muted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
