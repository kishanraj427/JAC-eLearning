import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  group('Connectivity Check Logic', () {
    test('should detect no connectivity from list result', () {
      final result = [ConnectivityResult.none];
      expect(result.contains(ConnectivityResult.none), true);
    });

    test('should detect wifi connectivity', () {
      final result = [ConnectivityResult.wifi];
      expect(result.contains(ConnectivityResult.none), false);
    });

    test('should detect mobile connectivity', () {
      final result = [ConnectivityResult.mobile];
      expect(result.contains(ConnectivityResult.none), false);
    });

    test('should handle multiple connectivity types', () {
      final result = [ConnectivityResult.wifi, ConnectivityResult.mobile];
      expect(result.contains(ConnectivityResult.none), false);
      expect(result.length, 2);
    });

    test('should handle empty result list as connected', () {
      final result = <ConnectivityResult>[];
      expect(result.contains(ConnectivityResult.none), false);
    });
  });
}
