// ─────────────────────────────────────────────────────────────────────────────
// lib/features/learning/data/process_log.dart
// O QUÊ:     Log de processo avançado (fermentação, sous-vide, cura…) e seus eventos.
// USA:       nada (modelos imutáveis puros).
// USADO POR: learning_seed, learning_repository, ProcessLogsScreen, ProcessLogScreen.
// SPEC:      specs/features/learning.yaml (data.models.ProcessLog)
// ─────────────────────────────────────────────────────────────────────────────

/// Um evento na linha do tempo de um log de processo: quando + o que aconteceu.
/// Usada por: ProcessLog (composição) e ProcessLogScreen.
class LogEvent {
  final String date; // rótulo de momento (ex.: 'Sáb · 08h')
  final String text; // o que aconteceu neste ponto

  const LogEvent({
    required this.date,
    required this.text,
  });
}

/// Um log de processo avançado: parâmetros fixos + linha do tempo de eventos.
/// `params` guarda medidas (ex.: {'Hidratação': '75%'}); `note` é a observação.
/// Usada por: lista de logs e a tela de detalhe do log.
class ProcessLog {
  final String id;
  final String type; // categoria livre (ex.: 'Fermentação')
  final String title; // nome do processo (ex.: 'Pão de fermentação natural')
  final DateTime date;
  final Map<String, String> params; // medidas do processo
  final List<LogEvent> timeline;
  final String note; // observação final

  const ProcessLog({
    required this.id,
    required this.type,
    required this.title,
    required this.date,
    this.params = const {},
    this.timeline = const [],
    this.note = '',
  });
}
