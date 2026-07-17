// ─────────────────────────────────────────────────────────────────────────────
// lib/main.dart
// O QUÊ:     Ponto de entrada. Inicializa Supabase (se houver chaves), escolhe as
//            implementações (Supabase x mock/seed) e sobe o app. Em debug + web,
//            embrulha com DevicePreview (moldura de celular).
// USA:       core/supabase (init), core/utils/app_log, app.dart (PitadaApp), riverpod,
//            features/auth + recipes + plans (overrides online), device_preview (debug/web).
// USADO POR: o runtime do Flutter (função main).
// ─────────────────────────────────────────────────────────────────────────────
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/supabase/supabase.dart';
import 'core/utils/app_log.dart';
import 'features/auth/application/auth_providers.dart';
import 'features/auth/data/auth_repository.dart';
import 'features/plans/application/food_estimate_service.dart';
import 'features/plans/application/gemini_food_estimate_service.dart';
import 'features/recipes/application/import/gemini_recipe_import_service.dart';
import 'features/recipes/application/import/recipe_import_service.dart';
import 'features/recipes/application/recipes_providers.dart';
import 'features/recipes/data/repositories/supabase_recipe_repository.dart';

/// Sobe o Pitada. Inicializa o backend quando configurado e injeta os providers:
/// online -> implementações Supabase; offline (preview PC) -> mocks/seed padrão.
/// Usada por: o runtime do Flutter.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final online = await SupabaseService.initIfConfigured();
  AppLog.i('core', 'app iniciando (online=$online)');

  runApp(
    DevicePreview(
      enabled: kDebugMode && kIsWeb,
      builder: (_) => ProviderScope(
        overrides: [
          if (online) ...[
            authRepositoryProvider
                .overrideWithValue(const SupabaseAuthRepository()),
            recipesRepositoryProvider
                .overrideWithValue(const SupabaseRecipesRepository()),
            foodEstimateServiceProvider
                .overrideWithValue(const GeminiFoodEstimateService()),
            recipeImportServiceProvider
                .overrideWithValue(const GeminiRecipeImportService()),
          ],
        ],
        child: const PitadaApp(),
      ),
    ),
  );
}
