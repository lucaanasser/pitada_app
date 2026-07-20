// ─────────────────────────────────────────────────────────────────────────────
// lib/features/notebook/data/models/hub/thread_entry.dart
// O QUÊ:     Item do "fio" do Caderno — visão unificada e cronológica de tudo
//            que foi capturado (diário, nota, versão, log) para o hub.
// USA:       nada (modelo imutável puro, derivado dos outros modelos).
// USADO POR: hub_providers (montagem do fio), ThreadTile (render no hub),
//            overview_providers (perfil).
// ─────────────────────────────────────────────────────────────────────────────

/// O tipo de captura que originou o item do fio (define cor e rótulo da tag).
enum ThreadKind { diary, note, version, log }

/// Um item do fio: quando, o quê, um excerto e a rota do detalhe.
/// [tag] é um selo extra opcional (ex.: veredito 'Refazer'/'Ajustar' do diário).
/// Usada por: ThreadTile no hub do Caderno.
class ThreadEntry {
  final String id;
  final ThreadKind kind;
  final DateTime date;
  final String title;
  final String excerpt;
  final String route;
  final String? tag;

  const ThreadEntry({
    required this.id,
    required this.kind,
    required this.date,
    required this.title,
    required this.excerpt,
    required this.route,
    this.tag,
  });
}
