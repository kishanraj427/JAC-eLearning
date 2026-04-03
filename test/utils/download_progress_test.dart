import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Download Progress Calculation', () {
    test('should calculate correct percentage', () {
      int dataSize = 1000;
      int bytesReceived = 500;
      double progress = (bytesReceived * 100 / dataSize);
      expect(progress, 50.0);
    });

    test('should show 100% when download completes', () {
      int dataSize = 2048;
      int bytesReceived = 2048;
      double progress = (bytesReceived * 100 / dataSize);
      expect(progress, 100.0);
    });

    test('should show 0% at start', () {
      int dataSize = 1000;
      int bytesReceived = 0;
      double progress = (bytesReceived * 100 / dataSize);
      expect(progress, 0.0);
    });

    test('should handle negative contentLength gracefully', () {
      int dataSize = -1;
      int bytesReceived = 500;

      // Guard: only calculate if dataSize > 0
      double progress = 0.0;
      if (dataSize > 0) {
        progress = (bytesReceived * 100 / dataSize);
      }
      expect(progress, 0.0);
    });

    test('should format progress string correctly', () {
      double progress = 75.456;
      String formatted = progress.toStringAsFixed(0);
      expect(formatted, '75');
    });

    test('should accumulate bytes from chunks', () {
      final bytes = <int>[];
      final chunk1 = [1, 2, 3, 4, 5];
      final chunk2 = [6, 7, 8, 9, 10];

      bytes.addAll(chunk1);
      expect(bytes.length, 5);

      bytes.addAll(chunk2);
      expect(bytes.length, 10);
    });
  });
}
