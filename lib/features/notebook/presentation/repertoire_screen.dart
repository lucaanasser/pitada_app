// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/presentation/repertoire_screen.dart
// O QUÊ:     Lista do Repertório parametrizada por kind: rácios, substituições ou
//            harmonizações. Harmonização navega para o detalhe (/pairing/:id).
// USA:       providers, core/widgets, widgets locais, go_router, theme/*.
// USADO POR: core/router/routes.dart (/learning/repertoire/:kind).
// SPEC:      specs/features/notebook.yaml (screens.RepertoireScreen — view-racios/subs/harm)
// ─────────────────────────────────────────────────────────────────────────────
import '../../../core/theme/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/widgets/cards/hairline_row.dart';
import '../../../core/widgets/layout/pitada_scaffold.dart';
import '../../../core/widgets/cards/recipe_thumb.dart';
import '../application/providers.dart';
import '../data/repertoire.dart';
import 'widgets/detail_header.dart';
import 'widgets/repertoire_row.dart';

/// Tela de repertório: mostra a lista adequada ao [kind] (ratios|subs|pairings).
/// Usada por: router (/learning/repertoire/:kind).
class RepertoireScreen extends ConsumerWidget {
  const RepertoireScreen({super.key, required this.kind});

  final String kind;

  /// Escolhe título/lead pelo [kind] e delega a lista correspondente. Usada por: router.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PitadaScaffold(
      child: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
        children: [
          DetailHeader(kicker: 'Repertório', title: _title, lead: _lead),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.md),
            child: _body(context, ref),
          ),
        ],
      ),
    );
  }

  /// Título da tela conforme o [kind]. Usada por: [build].
  String get _title => switch (kind) {
        'subs' => 'Substituições',
        'pairings' => 'Harmonizações',
        _ => 'Rácios',
      };

  /// Frase de apoio conforme o [kind]. Usada por: [build].
  String get _lead => switch (kind) {
        'subs' => 'Trocas que já funcionaram na prática.',
        'pairings' => 'O que combina com cada ingrediente.',
        _ => 'Proporções que dispensam receita.',
      };

  /// Seleciona a lista certa pelo [kind]. Usada por: [build].
  Widget _body(BuildContext context, WidgetRef ref) {
    return switch (kind) {
      'subs' => _subs(ref),
      'pairings' => _pairings(context, ref),
      _ => _ratios(ref),
    };
  }

  /// Lista de rácios (nome + detalhe / proporção). Usada por: [_body].
  Widget _ratios(WidgetRef ref) {
    final async = ref.watch(ratiosProvider);
    return _async(
      async,
      (items) => _column([
        for (var i = 0; i < items.length; i++)
          RepertoireRow(
            name: items[i].name,
            detail: items[i].note,
            value: items[i].ratio,
            showDivider: i != items.length - 1,
          ),
      ]),
    );
  }

  /// Lista de substituições ("Sem X" -> "use Y"). Usada por: [_body].
  Widget _subs(WidgetRef ref) {
    final async = ref.watch(subsProvider);
    return _async(
      async,
      (items) => _column([
        for (var i = 0; i < items.length; i++)
          RepertoireRow(
            name: items[i].missing,
            detail: items[i].note,
            value: items[i].use,
            showDivider: i != items.length - 1,
          ),
      ]),
    );
  }

  /// Lista de harmonizações (miniatura + "N combinações" -> /pairing/:id). Usada por: [_body].
  Widget _pairings(BuildContext context, WidgetRef ref) {
    final async = ref.watch(pairingsProvider);
    return _async(
      async,
      (items) => _column([
        for (var i = 0; i < items.length; i++)
          _pairingRow(context, items[i], showDivider: i != items.length - 1),
      ]),
    );
  }

  /// Uma linha de harmonização. Usada por: [_pairings].
  Widget _pairingRow(
    BuildContext context,
    Pairing p, {
    required bool showDivider,
  }) {
    final pit = context.pit;
    return HairlineRow(
      showDivider: showDivider,
      onTap: () => context.push('/pairing/${p.id}'),
      leading: RecipeThumb(color: AppColors.heroOf('teal'), icon: AppIcons.hub),
      title: Text(p.ingredient, style: AppType.on(AppType.titleSm, pit.text)),
      subtitle: Text(
        '${p.items.length} combinações',
        style: AppType.on(AppType.caption, pit.muted),
      ),
      trailing: Icon(AppIcons.chevron, size: 16, color: pit.faint),
    );
  }

  /// Envelopa a lista horizontalmente e adiciona o padding padrão. Usada pelas listas.
  Widget _column(List<Widget> children) {
    return Padding(
      padding: AppSpacing.screenH,
      child: Column(children: children),
    );
  }

  /// Resolve um AsyncValue de lista em loading/erro/dados. Usada pelas listas.
  Widget _async<T>(AsyncValue<List<T>> async, Widget Function(List<T>) data) {
    return async.when(
      loading: () => const Padding(
        padding: EdgeInsets.only(top: AppSpacing.xxxl),
        child:
            Center(child: CircularProgressIndicator(color: AppColors.accent)),
      ),
      error: (e, _) => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: Text(
            'Erro: $e',
            style: AppType.on(AppType.body, context.pit.text),
          ),
        ),
      ),
      data: data,
    );
  }
}
