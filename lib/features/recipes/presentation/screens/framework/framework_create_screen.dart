// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/presentation/screens/framework/framework_create_screen.dart
// O QUÊ:     Criação guiada de um framework: 4 perguntas socráticas em sequência
//            (o que se repete / o que varia / que regra aprendeu / que nome dá).
//            As respostas da pessoa VIRAM o esqueleto — a IA nunca preenche.
// USA:       framework_providers (controller), recipes_providers (receitas
//            ligadas), core/widgets (EditTextField, PitadaButton, StepProgress).
// USADO POR: core/router (/framework/new?recipes=a,b,c).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_icons.dart';
import '../../../../../core/utils/slug.dart';
import '../../../../../core/theme/pitada_colors.dart';
import '../../../../../core/theme/spacing.dart';
import '../../../../../core/widgets/cards/step_progress.dart';
import '../../../../../core/widgets/controls/pitada_button.dart';
import '../../../application/framework_providers.dart';
import '../../../application/recipes_providers.dart';
import '../../../data/models/framework.dart';
import '../../../data/models/recipe/recipe.dart';
import '../../widgets/framework/framework_question_view.dart';

/// Tela de criação guiada de framework. [recipeIds] chega da sugestão
/// socrática (ou vazio, criando do zero). Usada por: router (/framework/new).
class FrameworkCreateScreen extends ConsumerStatefulWidget {
  const FrameworkCreateScreen({super.key, this.recipeIds = const []});

  final List<String> recipeIds;

  @override
  ConsumerState<FrameworkCreateScreen> createState() =>
      _FrameworkCreateScreenState();
}

class _FrameworkCreateScreenState extends ConsumerState<FrameworkCreateScreen> {
  final _skeleton = TextEditingController();
  final _slots = TextEditingController();
  final _rules = TextEditingController();
  final _name = TextEditingController();
  int _step = 0;

  /// As 4 perguntas: (pergunta, ajuda, controller, dica, obrigatória).
  /// Usada por: [build] e a navegação entre passos.
  late final _questions = [
    (
      'O que sempre acontece, em ordem?',
      'O esqueleto: um passo por linha, sem quantidades.',
      _skeleton,
      'Ex.: sela a proteína\ndeglaceia a panela\nreduz o líquido',
      true,
    ),
    (
      'O que varia de uma receita para outra?',
      'Os slots: a proteína, o líquido, o tempero… um por linha.',
      _slots,
      'Ex.: proteína\nlíquido do molho',
      true,
    ),
    (
      'Que regra você aprendeu?',
      'Os invariantes: o que nunca pode faltar ou acontecer. Opcional.',
      _rules,
      'Ex.: nunca ferver depois do creme',
      false,
    ),
    (
      'Que nome você dá a esse padrão?',
      'O nome é seu, não do app — é ele que fixa o padrão na sua cabeça.',
      _name,
      'Ex.: molho de panela',
      true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    for (final c in [_skeleton, _slots, _rules, _name]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    for (final c in [_skeleton, _slots, _rules, _name]) {
      c.dispose();
    }
    super.dispose();
  }

  /// Quebra a resposta em linhas limpas e não vazias. Usada por: [_create].
  List<String> _lines(TextEditingController c) => [
        for (final l in c.text.split('\n'))
          if (l.trim().isNotEmpty) l.trim(),
      ];

  /// Cria o framework com as respostas e volta para a tab. Usada por: [build].
  Future<void> _create(List<Recipe> linked) async {
    final bySlug = <String, String>{};
    for (final r in linked) {
      for (final t in r.techniques) {
        bySlug.putIfAbsent(slugify(t), () => t);
      }
    }
    final id = await ref.read(frameworkEditControllerProvider).create(
          Framework(
            id: '',
            name: _name.text.trim(),
            skeleton: _lines(_skeleton),
            slots: _lines(_slots),
            rules: _lines(_rules),
            recipeIds: [for (final r in linked) r.id],
            techniques: bySlug.values.toList(),
          ),
        );
    if (!mounted) return;
    context.pushReplacement('/framework/$id');
  }

  @override
  Widget build(BuildContext context) {
    final pit = context.pit;
    final recipes = ref.watch(recipesProvider).valueOrNull ?? const <Recipe>[];
    final linked = [
      for (final r in recipes)
        if (widget.recipeIds.contains(r.id)) r,
    ];
    final (question, helper, ctrl, hint, required_) = _questions[_step];
    final isLast = _step == _questions.length - 1;
    final canGo = !required_ || ctrl.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: pit.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => context.pop(),
                  behavior: HitTestBehavior.opaque,
                  child: Icon(AppIcons.close, size: 22, color: pit.muted),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              StepProgress(
                steps: const ['Repete', 'Varia', 'Regras', 'Nome'],
                activeIndex: _step,
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: FrameworkQuestionView(
                  question: question,
                  helper: helper,
                  controller: ctrl,
                  hint: hint,
                  linked: linked,
                  singleLine: isLast,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: PitadaButton(
                      label: 'Voltar',
                      variant: PitadaButtonVariant.outline,
                      onPressed:
                          _step == 0 ? null : () => setState(() => _step--),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: PitadaButton(
                      label: isLast ? 'Criar framework' : 'Próximo',
                      onPressed: !canGo
                          ? null
                          : isLast
                              ? () => _create(linked)
                              : () => setState(() => _step++),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
