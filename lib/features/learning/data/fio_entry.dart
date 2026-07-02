// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/data/fio_entry.dart
// O QUÊ:     Item do "fio" do Caderno — visão unificada e cronológica de tudo
//            que foi capturado (diário, nota, versão, log) para o hub.
// USA:       nada (modelo imutável puro, derivado dos outros modelos).
// USADO POR: caderno_providers (montagem do fio), FioTile (render no hub).
// ─────────────────────────────────────────────────────────────────────────────

/// O tipo de captura que originou o item do fio (define cor e rótulo da tag).
enum FioKind { diary, note, version, log }

/// Um item do fio: quando, o quê, um excerto e a rota do detalhe.
/// [tag] é um selo extra opcional (ex.: veredito 'Refazer'/'Ajustar' do diário).
/// Usada por: FioTile no hub do Caderno.
class FioEntry {
  final String id;
  final FioKind kind;
  final DateTime date;
  final String title;
  final String excerpt;
  final String route; // detalhe a abrir no toque (ex.: '/diary/diario-x')
  final String? tag; // selo extra (veredito do diário, 'definitiva'…)

  const FioEntry({
    required this.id,
    required this.kind,
    required this.date,
    required this.title,
    required this.excerpt,
    required this.route,
    this.tag,
  });
}
