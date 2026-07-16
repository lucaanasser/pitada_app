// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/repertoire.dart
// O QUÊ:     Repertório para cozinhar sem receita: rácios, substituições e harmonizações.
// USA:       nada (modelos imutáveis puros).
// USADO POR: seed, repository, providers, RepertoireScreen, PairingDetailScreen,
//            PairingLegend.
// SPEC:      specs/features/notebook.yaml (data.models.Ratio/Substitution/Pairing)
// ─────────────────────────────────────────────────────────────────────────────

/// Um rácio de confiança: proporção que dispensa receita (ex.: vinagrete 3:1).
/// Usada por: RepertoireScreen (kind ratio).
class Ratio {
  final String name;
  final String ratio;
  final String note;

  const Ratio({
    required this.name,
    required this.ratio,
    this.note = '',
  });
}

/// Uma substituição testada: o que usar quando falta um ingrediente.
/// Usada por: RepertoireScreen (kind substitution).
class Substitution {
  final String missing;
  final String use;
  final String note;

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
  final List<String> recipeIds;

  const Pairing({
    required this.id,
    required this.ingredient,
    this.items = const [],
    this.recipeIds = const [],
  });
}
