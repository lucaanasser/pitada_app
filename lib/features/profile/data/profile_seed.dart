// ─────────────────────────────────────────────────────────────────────────────
// lib/features/profile/data/profile_seed.dart
// O QUÊ:     Dados de exemplo do Perfil — só a identidade (a atividade agora
//            deriva do fio real do Caderno via activity_builder).
// USA:       profile.dart.
// USADO POR: profile_repository (fonte em memória enquanto não há Supabase).
// SPEC:      specs/features/profile.yaml (seed: profile_seed.dart)
// ─────────────────────────────────────────────────────────────────────────────
import 'profile.dart';

/// Identidade de exemplo (Luca Naasser). Usada por: profile_repository.fetchProfile.
const Profile kSeedProfile = Profile(name: 'Luca Naasser', initial: 'L');
