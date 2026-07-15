// ─────────────────────────────────────────────────────────────────────────────
// lib/core/router/routes.dart
// O QUÊ:     Lista das rotas full-screen (cobrem a barra de abas) do go_router.
// USA:       go_router + as telas de detalhe/edição de cada feature (presentation).
// USADO POR: core/router/router.dart (compõe estas rotas com o shell das abas).
// SPEC:      specs/features/*.yaml (bloco `routes` de cada feature)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/learning/presentation/diary_entry_screen.dart';
import '../../features/learning/presentation/diary_screen.dart';
import '../../features/learning/presentation/lesson_cards_screen.dart';
import '../../features/learning/presentation/lesson_detail_screen.dart';
import '../../features/learning/presentation/lesson_edit_screen.dart';
import '../../features/learning/presentation/note_detail_screen.dart';
import '../../features/learning/presentation/notes_screen.dart';
import '../../features/learning/presentation/pairing_detail_screen.dart';
import '../../features/learning/presentation/process_log_screen.dart';
import '../../features/learning/presentation/process_logs_screen.dart';
import '../../features/learning/presentation/repertoire_screen.dart';
import '../../features/learning/presentation/version_history_screen.dart';
import '../../features/learning/presentation/versions_screen.dart';
import '../../features/profile/presentation/settings_screen.dart';
import '../../features/recipes/presentation/cook_mode_screen.dart';
import '../../features/recipes/presentation/folder_screen.dart';
import '../../features/recipes/presentation/recipe_detail_screen.dart';
import '../../features/recipes/presentation/recipe_edit_screen.dart';

/// Constrói as rotas full-screen (pushadas sobre o shell, escondendo a barra).
/// [rootKey] é o Navigator raiz — garante que estas telas cubram as abas.
/// Usada por: router.dart.
List<RouteBase> buildFullscreenRoutes(GlobalKey<NavigatorState> rootKey) {
  // Atalho: rota full-screen ancorada no Navigator raiz.
  GoRoute fs(String path, Widget Function(BuildContext, GoRouterState) build) =>
      GoRoute(path: path, parentNavigatorKey: rootKey, builder: build);

  String p(GoRouterState s, String k) => s.pathParameters[k]!;

  return [
    // —— Auth ——
    // Entrar (e-mail + código). O gate em router.dart decide quando mostrar.
    fs('/entrar', (c, s) => const SignInScreen()),

    // —— Receitas ——
    fs('/recipe/:id', (c, s) => RecipeDetailScreen(recipeId: p(s, 'id'))),
    fs('/recipe/:id/edit', (c, s) => RecipeEditScreen(recipeId: p(s, 'id'))),
    fs('/recipe/:id/cook', (c, s) => CookModeScreen(recipeId: p(s, 'id'))),

    // Pasta aberta: página NÃO-opaca sem transição própria — a FolderScreen lê
    // a animação desta rota e dirige papéis + dissolve por cima da aba Pastas,
    // que permanece visível por baixo durante abrir/fechar (uma transição só).
    GoRoute(
      path: '/folder/:id',
      parentNavigatorKey: rootKey,
      pageBuilder: (c, s) => CustomTransitionPage(
        key: s.pageKey,
        opaque: false,
        transitionDuration: FolderScreen.openDuration,
        reverseTransitionDuration: FolderScreen.closeDuration,
        transitionsBuilder: (_, __, ___, child) => child,
        child: FolderScreen(folderId: p(s, 'id')),
      ),
    ),

    // —— Caderno: listas ——
    fs('/learning/cards', (c, s) => const LessonCardsScreen()),
    fs('/learning/notes', (c, s) => const NotesScreen()),
    fs('/learning/diary', (c, s) => const DiaryScreen()),
    fs('/learning/versions', (c, s) => const VersionsScreen()),
    fs('/learning/logs', (c, s) => const ProcessLogsScreen()),
    fs(
      '/learning/repertoire/:kind',
      (c, s) => RepertoireScreen(kind: p(s, 'kind')),
    ),
    fs('/lesson-edit', (c, s) => const LessonEditScreen()),

    // —— Caderno: detalhes ——
    fs('/lesson/:id', (c, s) => LessonDetailScreen(lessonId: p(s, 'id'))),
    fs('/note/:id', (c, s) => NoteDetailScreen(noteId: p(s, 'id'))),
    fs('/diary/:id', (c, s) => DiaryEntryScreen(entryId: p(s, 'id'))),
    fs('/versions/:id', (c, s) => VersionHistoryScreen(versionId: p(s, 'id'))),
    fs('/log/:id', (c, s) => ProcessLogScreen(logId: p(s, 'id'))),
    fs('/pairing/:id', (c, s) => PairingDetailScreen(pairingId: p(s, 'id'))),

    // —— Perfil ——
    fs('/profile/settings', (c, s) => const SettingsScreen()),
  ];
}
