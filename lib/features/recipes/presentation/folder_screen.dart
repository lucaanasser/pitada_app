// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/folder_screen.dart
// O QUÊ:     Pasta aberta (estilo iOS Notes): grade de receitas que deslizam PARA
//            FORA da pasta ao abrir e voltam PARA DENTRO ao fechar, dirigidas
//            pela ANIMAÇÃO DA ROTA (não-opaca): a aba Pastas fica visível por
//            baixo e some/volta junto com o voo dos papéis — uma transição só.
//            A faixa da pasta DESLIZA (nunca fica translúcida): é ela, sólida,
//            que oclui os papéis entrando/saindo.
// USA:       recipes_providers, RecipeCard, PaperFly/FolderMotion/
//            BottomOpenClipper, core/widgets (EmptyState, PitadaIconButton),
//            core/theme (pit/AppType/AppSpacing/AppIcons), AppLog, go_router.
// USADO POR: core/router/routes.dart (/folder/:id via CustomTransitionPage).
// SPEC:      specs/features/recipes.yaml (FolderScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/layout/empty_state.dart';
import '../../../core/widgets/controls/pitada_button.dart';
import '../application/recipes_providers.dart';
import '../data/recipe.dart';
import 'widgets/paper_fly.dart';
import 'widgets/recipe_card.dart';

/// Tela de uma pasta aberta, com papéis animados pela PRÓPRIA ROTA: o push
/// avança a animação (papéis saem) e o pop a reverte (papéis voltam) enquanto
/// a aba Pastas reaparece por baixo. Usada por: router (/folder/:id).
class FolderScreen extends ConsumerWidget {
  const FolderScreen({super.key, required this.folderId});

  final String folderId;

  /// Durações da transição da rota (abrir/fechar). Lidas por routes.dart ao
  /// montar a CustomTransitionPage — tela e rota compartilham a MESMA animação.
  static const openDuration = Duration(milliseconds: 460);
  static const closeDuration = Duration(milliseconds: 380);

  /// Mock do adicionar receita — o seletor real virá com o repositório de
  /// escrita. Usada por: [_folderStrip] (botão +).
  void _logAdd() => AppLog.i('recipes', 'adicionar receita à pasta: $folderId');

  /// Monta fundo que dissolve por cima da aba Pastas + topo + grade animada +
  /// faixa da pasta, tudo dirigido pela animação da rota. Usada por: framework.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pit = context.pit;
    final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];
    final matches = folders.where((f) => f.id == folderId).toList();
    final name = matches.isEmpty ? 'Pasta' : matches.first.name;
    final hero = matches.isEmpty ? 'clay' : matches.first.heroColor;
    final inFolder =
        recipes.where((r) => r.folderIds.contains(folderId)).toList();

    final route = ModalRoute.of(context)?.animation ?? kAlwaysCompleteAnimation;
    final bgFade = CurvedAnimation(
      parent: route,
      curve: const Interval(0, 0.45, curve: Curves.easeOut),
      reverseCurve: const Interval(0.55, 1, curve: Curves.easeOut),
    );
    final stripSlide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: route,
        curve: const Interval(0, 0.15, curve: Curves.easeOutCubic),
        reverseCurve: const Interval(0, 0.15, curve: Curves.easeOutCubic),
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        FadeTransition(opacity: bgFade, child: ColoredBox(color: pit.bg)),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            bottom: false,
            child: Column(
              children: [
                FadeTransition(opacity: bgFade, child: _topBar(context, pit)),
                Expanded(
                  child: inFolder.isEmpty
                      ? FadeTransition(
                          opacity: bgFade,
                          child: const EmptyState(
                            title: 'Pasta vazia',
                            message: 'Adicione receitas a esta pasta.',
                            icon: AppIcons.folder,
                          ),
                        )
                      : _grid(context, inFolder, route),
                ),
                SlideTransition(
                  position: stripSlide,
                  child:
                      _folderStrip(context, pit, name, hero, inFolder.length),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Linha mínima do topo: voltar (pop reverte a rota animada) + rótulo 'PASTA'.
  /// Usada por: [build].
  Widget _topBar(BuildContext context, PitadaColors pit) {
    return Padding(
      padding: AppSpacing.screenH.copyWith(top: AppSpacing.md),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Icon(AppIcons.back, size: 22, color: pit.text),
            ),
          ),
          Text('PASTA', style: AppType.on(AppType.label, pit.muted)),
        ],
      ),
    );
  }

  /// Grade 2 colunas dos "papéis" (RecipeCard compacto): cada um SAI da faixa
  /// da pasta (rodapé) e viaja até seu lugar na grade, desentortando no
  /// caminho — e volta para dentro no pop da rota, com a coreografia de ida e
  /// volta vinda de FolderMotion. Usada por: [build].
  Widget _grid(
      BuildContext context, List<Recipe> inFolder, Animation<double> route) {
    return LayoutBuilder(
      builder: (context, c) => ClipRect(
        clipper: const BottomOpenClipper(),
        child: GridView.builder(
          clipBehavior: Clip.none,
          padding: AppSpacing.screenH
              .copyWith(top: AppSpacing.md, bottom: AppSpacing.xl),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: FolderMotion.cardAspect,
          ),
          itemCount: inFolder.length,
          itemBuilder: (context, i) => PaperFly(
            animation: route,
            interval: FolderMotion.flyOut(i),
            reverseInterval: FolderMotion.flyBack(i),
            delta: FolderMotion.delta(i, c.biggest),
            angle: i.isEven ? -0.06 : 0.07,
            child: RecipeCard(
              recipe: inFolder[i],
              compact: true,
              onTap: () => context.push('/recipe/${inFolder[i].id}'),
            ),
          ),
        ),
      ),
    );
  }

  /// A PASTA no rodapé: faixa na cor pastel do hero, nome + contagem + botão
  /// de adicionar. É o ponto fixo da cena — são os papéis que saem/entram por
  /// trás dela. Usada por: [build].
  Widget _folderStrip(
    BuildContext context,
    PitadaColors pit,
    String name,
    String hero,
    int count,
  ) {
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
              PitadaIconButton(icon: AppIcons.add, onPressed: _logAdd),
            ],
          ),
        ),
      ),
    );
  }
}
