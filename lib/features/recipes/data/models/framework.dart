// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/framework.dart
// O QUÊ:     Framework de cozinha: a estrutura genérica que sobra de várias
//            receitas quando se tiram as quantidades — esqueleto de passos,
//            slots (o que varia), regras aprendidas e receitas instância.
//            Criado e nomeado SEMPRE pelo usuário (a IA nunca rotula).
//            Não confundir com LessonKind.framework (ficha de leitura do
//            Caderno): este aqui é construído a partir das receitas da pessoa.
// USA:       freezed + json_serializable (codegen).
// USADO POR: framework_repository, framework_providers, tab Frameworks.
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

part 'framework.freezed.dart';
part 'framework.g.dart';

/// Um framework do usuário: nome próprio, esqueleto genérico (passos sem
/// quantidade), slots (o que varia), regras (invariantes aprendidos) e as
/// receitas que são instâncias dele. Técnicas são atributo, nunca eixo.
/// Usada por: tab Frameworks, FrameworkDetailScreen, ponte no detalhe da receita.
@freezed
abstract class Framework with _$Framework {
  const factory Framework({
    required String id,
    required String name,
    @Default([]) List<String> skeleton,
    @Default([]) List<String> slots,
    @Default([]) List<String> rules,
    @Default([]) List<String> recipeIds,
    @Default([]) List<String> techniques,
  }) = _Framework;

  /// Monta a partir do JSON do banco (snake_case). Usada por: repositório Supabase futuro.
  factory Framework.fromJson(Map<String, dynamic> json) =>
      _$FrameworkFromJson(json);
}
