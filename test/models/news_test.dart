import 'package:flutter_test/flutter_test.dart';
import 'package:jac_elearning/models/News.dart';

void main() {
  group('News Model', () {
    test('should create a News with all required fields', () {
      final news = News(
        key: 'news_001',
        type: 'notification',
        text: 'JAC 10th Result 2024 Released',
        url: 'https://jac.jharkhand.gov.in/result',
      );

      expect(news.key, 'news_001');
      expect(news.type, 'notification');
      expect(news.text, 'JAC 10th Result 2024 Released');
      expect(news.url, 'https://jac.jharkhand.gov.in/result');
    });

    test('toString should throw if pdf/image not set (late fields)', () {
      final news = News(
        key: 'k1',
        type: 'update',
        text: 'Test news',
        url: 'https://example.com',
      );

      // toString accesses late File fields pdf and image, which throw if uninitialized
      expect(() => news.toString(), throwsA(isA<Error>()));
    });

    test('should handle empty fields', () {
      final news = News(key: '', type: '', text: '', url: '');

      expect(news.key, '');
      expect(news.type, '');
      expect(news.text, '');
      expect(news.url, '');
    });

    test('should allow updating fields', () {
      final news = News(
        key: 'k1',
        type: 'old',
        text: 'old text',
        url: 'old url',
      );

      news.type = 'new';
      news.text = 'new text';
      news.url = 'new url';

      expect(news.type, 'new');
      expect(news.text, 'new text');
      expect(news.url, 'new url');
    });
  });
}
