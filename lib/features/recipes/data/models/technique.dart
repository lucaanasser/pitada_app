// ─────────────────────────────────────────────────────────────────────────────
// lib/features/recipes/data/models/technique.dart
// O QUÊ:     Entidade canônica de técnica (slug único por usuário + noção).
//            Nunca string livre: quem agrupa/liga usa o slug ou o id.
// USA:       freezed + json_serializable (codegen).
// USADO POR: technique_repository, technique_providers, technique_detail_screen.
// SPEC:      specs/features/recipes.yaml (data.tecnica) +
//            specs/backend/database.yaml (0015_techniques.sql)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:freezed_annotation/freezed_annotation.dart';

part 'technique.freezed.dart';
part 'technique.g.dart';

/// Uma técnica de cozinha do usuário. [slug] é a forma canônica (unaccent+
/// lower); [name] é como a pessoa escreveu; [notion] é a noção ("o que é
/// selar") — a IA rascunha no import, a pessoa edita. Usada por: página de
/// técnica, autocomplete da edição, agrupamento de frameworks.
@freezed
abstract class Technique with _$Technique {
  const factory Technique({
    required String id,
    required String slug,
    required String name,
    String? notion,
  }) = _Technique;

  /// Monta a partir do JSON do banco (snake_case). Usada por: SupabaseTechniquesRepository.
  factory Technique.fromJson(Map<String, dynamic> json) =>
      _$TechniqueFromJson(json);
}
