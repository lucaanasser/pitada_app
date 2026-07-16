// ─────────────────────────────────────────────────────────────────────────────
// lib/features/groceries/application/scanner_service.dart
// O QUÊ:     Service abstrato de scanner (código de barras) + mock para desktop.
// USA:       core/utils/app_log (log do scan). Riverpod (Provider de injeção).
// USADO POR: add_pantry_sheet e shopping_providers (scannerProvider).
// SPEC:      specs/features/groceries.yaml (services.ScannerService)
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/app_log.dart';

/// Hardware de leitura de código de barras atrás de uma interface (real + mock).
/// Usada por: o fluxo "Adicionar à despensa". Destrava rodar sem câmera no PC.
abstract class ScannerService {
  /// Lê um código de barras e retorna o código lido (ou null se cancelado).
  /// Usada por: add_pantry_sheet ao escolher a origem "Código de barras".
  Future<String?> scanBarcode();
}

/// Implementação falsa para preview no desktop/Chrome (sem câmera real).
/// Retorna sempre um código de exemplo. Usada por: scannerProvider no preview.
class MockScannerService implements ScannerService {
  const MockScannerService();

  /// Simula uma leitura bem-sucedida e devolve um EAN de exemplo.
  /// Usada por: add_pantry_sheet enquanto não há scanner real.
  @override
  Future<String?> scanBarcode() async {
    const code = '7891000100103';
    AppLog.i('groceries', 'scan simulado: $code');
    return code;
  }
}

/// Injeta o scanner em uso. Override para trocar mock/real. Usada por: a UI de scan.
final scannerProvider =
    Provider<ScannerService>((ref) => const MockScannerService());
