// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/folder_screen.dart
// O QUÊ:     Pasta aberta (estilo iOS Notes): grade de receitas que deslizam PARA
//            FORA da pasta ao abrir e voltam PARA DENTRO ao fechar; a pasta vira
//            uma faixa colorida no rodapé com nome + contagem + adicionar.
// USA:       recipes_providers, RecipeCard, core/widgets (EmptyState,
//            PitadaIconButton), core/theme (pit/AppType/AppSpacing/AppIcons),
//            AppLog, go_router (push do detalhe / pop animado).
// USADO POR: core/router (/folder/:id).
// SPEC:      specs/features/recipes.yaml (FolderScreen)
// ─────────────────────────────────────────────────────────────────────────────
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_icons.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/pitada_colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../core/utils/app_log.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/pitada_button.dart';
import '../application/recipes_providers.dart';
import '../data/recipe.dart';
import 'widgets/recipe_card.dart';

/// Tela de uma pasta aberta, com papéis animados. Usada por: router (/folder/:id).
class FolderScreen extends ConsumerStatefulWidget {
  const FolderScreen({super.key, required this.folderId});

  final String folderId;

  /// Cria o estado com o controller da animação. Usada por: framework.
  @override
  ConsumerState<FolderScreen> createState() => _FolderScreenState();
}

/// Estado: controla a animação de "papéis saindo/entrando" da pasta.
class _FolderScreenState extends ConsumerState<FolderScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  /// Duração da abertura/fechamento da pasta (papéis saindo/entrando).
  static const _openDur = Duration(milliseconds: 700);

  /// Dispara a entrada dos papéis assim que a tela abre. Usada por: framework.
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: _openDur)..forward();
  }

  /// Libera o controller. Usada por: framework.
  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  /// Mock do adicionar receita — o seletor real virá com o repositório de
  /// escrita. Usada por: [_folderStrip] (botão +).
  void _logAdd() =>
      AppLog.i('recipes', 'adicionar receita à pasta: ${widget.folderId}');

  /// Fecha a pasta: os papéis voltam para dentro (reverse) e só então dá pop.
  /// Usada por: botão voltar do topo e PopScope (gesto/botão do sistema).
  Future<void> _close() async {
    if (_ctrl.isAnimating) return;
    await _ctrl.reverse();
    if (mounted) context.pop();
  }

  /// Monta topo mínimo + grade animada + faixa da pasta no rodapé. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final folders = ref.watch(foldersProvider).valueOrNull ?? const [];
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const [];
    final matches = folders.where((f) => f.id == widget.folderId).toList();
    final name = matches.isEmpty ? 'Pasta' : matches.first.name;
    final hero = matches.isEmpty ? 'clay' : matches.first.heroColor;
    final inFolder =
        recipes.where((r) => r.folderIds.contains(widget.folderId)).toList();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _close();
      },
      child: Scaffold(
        backgroundColor: pit.bg,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _topBar(pit),
              Expanded(
                child: inFolder.isEmpty
                    ? const EmptyState(
                        title: 'Pasta vazia',
                        message: 'Adicione receitas a esta pasta.',
                        icon: AppIcons.folder,
                      )
                    : _grid(inFolder),
              ),
              _folderStrip(pit, name, hero, inFolder.length),
            ],
          ),
        ),
      ),
    );
  }

  /// Linha mínima do topo: voltar (animado via [_close]) + rótulo 'PASTA'.
  /// Usada por: [build].
  Widget _topBar(PitadaColors pit) {
    return Padding(
      padding: AppSpacing.screenH.copyWith(top: AppSpacing.md),
      child: Row(
        children: [
          GestureDetector(
            onTap: _close,
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
  /// caminho — e volta para dentro no fechamento. Usada por: [build].
  Widget _grid(List<Recipe> inFolder) {
    return LayoutBuilder(
      // ClipRect aberto embaixo: o papel em voo pode passar POR TRÁS da faixa
      // da pasta (pintada depois na Column) — é o que faz parecer que ele sai
      // de dentro dela e volta para dentro no fechamento.
      builder: (context, c) => ClipRect(
        clipper: const _BottomOpenClipper(),
        child: GridView.builder(
          clipBehavior: Clip.none,
          padding: AppSpacing.screenH
              .copyWith(top: AppSpacing.md, bottom: AppSpacing.xl),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: AppSpacing.md,
            mainAxisSpacing: AppSpacing.md,
            childAspectRatio: 0.72,
          ),
          itemCount: inFolder.length,
          itemBuilder: (context, i) => _PaperFly(
            animation: _ctrl,
            interval: _intervalFor(i),
            delta: _fromFolderDelta(i, c.biggest),
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

  /// Vetor do slot do papel [i] até a boca da pasta (rodapé, centro) — é o
  /// trajeto que o papel percorre ao sair/entrar. Usada por: [_grid].
  Offset _fromFolderDelta(int i, Size area) {
    const gap = AppSpacing.md;
    final cw = (area.width - 2 * AppSpacing.gutter - gap) / 2;
    final ch = cw / 0.72;
    final col = i % 2, row = i ~/ 2;
    final slot = Offset(
      AppSpacing.gutter + cw / 2 + col * (cw + gap),
      AppSpacing.md + ch / 2 + row * (ch + gap),
    );
    // Fundo o bastante para o papel mergulhar atrás da faixa da pasta.
    final mouth = Offset(area.width / 2, area.height + ch * 0.55);
    return mouth - slot;
  }

  /// Trecho do controller que anima o papel [i] — quanto mais fundo na pasta,
  /// mais tarde ele sai. Usada por: [_grid].
  Interval _intervalFor(int i) {
    final start = math.min(i * 0.06, 0.4);
    final end = math.min(start + 0.55, 1.0);
    return Interval(start, end, curve: Curves.easeOutCubic);
  }

  /// A PASTA no rodapé: faixa na cor pastel do hero com borda de tinta no topo,
  /// nome + contagem + botão de adicionar. Fica PARADA durante a animação —
  /// a pasta é o ponto fixo; são os papéis que saem/entram por trás dela.
  /// Usada por: [build].
  Widget _folderStrip(PitadaColors pit, String name, String hero, int count) {
    final label = '$count receita${count == 1 ? '' : 's'}';
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: pit.card(hero),
        // Sem borda: a faixa descola do fundo por uma sombra curta p/ cima
        // (sombra funcional — mesma exceção do card de pasta).
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

/// Papel saindo da pasta: parte da boca da pasta ([delta]), levemente girado
/// ([angle]) e menor, e chega reto no seu slot da grade; o reverse o devolve
/// para dentro. Usada por: _FolderScreenState (grade).
class _PaperFly extends StatelessWidget {
  const _PaperFly({
    required this.animation,
    required this.interval,
    required this.delta,
    required this.angle,
    required this.child,
  });

  final Animation<double> animation;
  final Interval interval;
  final Offset delta; // slot → boca da pasta
  final double angle; // torto dentro da pasta, reto na grade
  final Widget child;

  /// Interpola posição/rotação/escala/opacidade pelo intervalo. Usada por: framework.
  @override
  Widget build(BuildContext context) {
    final curved = CurvedAnimation(parent: animation, curve: interval);
    return AnimatedBuilder(
      animation: curved,
      builder: (context, _) {
        final v = curved.value;
        return Opacity(
          // Só some quando já está mergulhado atrás da faixa (primeiros 20%).
          opacity: (v * 5).clamp(0, 1).toDouble(),
          child: Transform.translate(
            offset: delta * (1 - v),
            child: Transform.rotate(
              angle: angle * (1 - v),
              child: Transform.scale(scale: 0.72 + 0.28 * v, child: child),
            ),
          ),
        );
      },
    );
  }
}

/// Recorte aberto embaixo: corta o conteúdo no topo (scroll limpo) mas deixa
/// os papéis em voo aparecerem abaixo da grade, atrás da faixa da pasta.
/// Usada por: _FolderScreenState._grid.
class _BottomOpenClipper extends CustomClipper<Rect> {
  const _BottomOpenClipper();

  /// Estende o recorte bem além da base da grade. Usada por: framework.
  @override
  Rect getClip(Size size) => Rect.fromLTRB(0, 0, size.width, size.height + 600);

  /// O recorte é fixo. Usada por: framework.
  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => false;
}
