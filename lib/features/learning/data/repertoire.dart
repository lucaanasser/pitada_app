// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/data/repertoire.dart
// O QUÊ:     Repertório para cozinhar sem receita: rácios, substituições e harmonizações.
// USA:       nada (modelos imutáveis puros).
// USADO POR: learning_seed, learning_repository, RepertoireScreen, HarmScreen.
// SPEC:      specs/features/learning.yaml (data.models.Ratio/Substitution/Pairing)
// ─────────────────────────────────────────────────────────────────────────────

/// Um rácio de confiança: proporção que dispensa receita (ex.: vinagrete 3:1).
/// Usada por: RepertoireScreen (kind ratio).
class Ratio {
  final String name; // ex.: 'Vinagrete'
  final String ratio; // ex.: '3 : 1'
  final String note; // detalhe pequeno (ex.: 'óleo : ácido')

  const Ratio({
    required this.name,
    required this.ratio,
    this.note = '',
  });
}

/// Uma substituição testada: o que usar quando falta um ingrediente.
/// Usada por: RepertoireScreen (kind substitution).
class Substitution {
  final String missing; // o que faltou (ex.: 'Sem shoyu')
  final String use; // o que usar no lugar
  final String note; // contexto (ex.: 'marinadas')

  const Substitution({
    required this.missing,
    required this.use,
    this.note = '',
  });
}

/// Nível de confiança de uma combinação numa harmonização.
/// 'adoro' = favorita; 'testei' = já validada; 'classico' = combinação canônica.
/// Usada por: PairingItem para colorir o chip.
enum PairingRating { adoro, testei, classico }

/// Uma combinação dentro de uma harmonização: nome + o quanto se confia nela.
/// Usada por: Pairing (composição) e PairingDetailScreen.
class PairingItem {
  final String name;
  final PairingRating rating;

  const PairingItem({
    required this.name,
    required this.rating,
  });
}

/// A harmonização de um ingrediente: com o que ele combina, agrupado por nível.
/// Usada por: lista de harmonizações e a tela de detalhe.
class Pairing {
  final String id;
  final String ingredient;
  final List<PairingItem> items;
  final List<String> recipeIds; // receitas que usam a harmonização

  const Pairing({
    required this.id,
    required this.ingredient,
    this.items = const [],
    this.recipeIds = const [],
  });
}
