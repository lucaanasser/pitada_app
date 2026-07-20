// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/folder/folder_screen.dart
// O QUÊ:     Pasta aberta (estilo iOS Notes): grade de receitas que deslizam PARA
//            FORA da pasta ao abrir e voltam PARA DENTRO ao fechar, dirigidas
//            pela ANIMAÇÃO DA ROTA (não-opaca): a aba Pastas fica visível por
//            baixo e some/volta junto com o voo dos papéis — uma transição só.
//            A faixa da pasta DESLIZA (nunca fica translúcida): é ela, sólida,
//            que oclui os papéis entrando/saindo.
// USA:       recipe_providers, RecipeCard, folder_edit_sheet (+ abre o editor),
//            PaperFly/FolderMotion/BottomOpenClipper, OpenStripBar (faixa da
//            pasta), EmptyState, core/theme (pit/AppType/AppSpacing/AppIcons),
//            go_router.
// USADO POR: core/router/routes.dart (/folder/:id via CustomTransitionPage).
// SPEC:      specs/features/recipes.yaml (FolderScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/theme/typography.dart';
import '../../../../../core/widgets/layout/empty_state.dart';
import '../../../application/recipe_providers.dart';
import '../../../data/models/folder.dart';
import '../../../data/models/recipe/recipe.dart';
import '../../sheets/folder_edit_sheet.dart';
import '../../widgets/folder/open_strip_bar.dart';
import '../../widgets/folder/paper_fly.dart';
import '../../widgets/list/recipe_card.dart';

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

  /// Abre o editor desta pasta (nome, cor e receitas). Usada por: OpenStripBar (+).
  void _openEditor(BuildContext context, String name, String hero) =>
      showFolderEditSheet(
        context,
        folder: Folder(id: folderId, name: name, heroColor: hero),
      );

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
                  child: OpenStripBar(
                    name: name,
                    hero: hero,
                    count: inFolder.length,
                    onAdd: () => _openEditor(context, name, hero),
                  ),
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
      BuildContext context, List<Recipe> inFolder, Animation<double> route,) {
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
}
