import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Recent Books Logic', () {
    test('should encode book data to JSON string', () {
      var book = <String, String>{};
      book['clas'] = '10th';
      book['subject'] = 'Mathematics';
      book['type'] = 'Chapters';
      book['name'] = 'Chapter 1';
      book['url'] = 'https://example.com/ch1.pdf';

      String str = json.encode(book);
      var decoded = json.decode(str);

      expect(decoded['clas'], '10th');
      expect(decoded['subject'], 'Mathematics');
      expect(decoded['type'], 'Chapters');
      expect(decoded['name'], 'Chapter 1');
      expect(decoded['url'], 'https://example.com/ch1.pdf');
    });

    test('should maintain max 5 recent books', () {
      var list = <String>[];

      for (int i = 0; i < 7; i++) {
        var book = <String, String>{
          'name': 'Chapter $i',
          'url': 'https://example.com/ch$i.pdf',
        };
        String str = json.encode(book);
        if (list.contains(str)) list.remove(str);
        list.add(str);
        if (list.length > 5) list.removeAt(0);
      }

      expect(list.length, 5);
      // Oldest entries (0, 1) should be removed
      expect(list.first, contains('Chapter 2'));
      expect(list.last, contains('Chapter 6'));
    });

    test('should move duplicate to end of list', () {
      var list = <String>[];

      // Add 3 books
      for (int i = 0; i < 3; i++) {
        var book = {'name': 'Ch $i', 'url': 'url$i'};
        list.add(json.encode(book));
      }

      // Re-add the first book
      var duplicate = {'name': 'Ch 0', 'url': 'url0'};
      String str = json.encode(duplicate);
      if (list.contains(str)) list.remove(str);
      list.add(str);

      expect(list.length, 3);
      expect(list.last, contains('Ch 0'));
    });

    test('should handle empty recent list', () {
      List<String>? list;
      list ??= [];
      expect(list, isEmpty);
    });
  });

  group('Recent Questions Logic', () {
    test('should encode question data to JSON string', () {
      var question = <String, String>{};
      question['name'] = 'Math 2023';
      question['url'] = 'https://example.com/math2023.pdf';

      String str = json.encode(question);
      var decoded = json.decode(str);

      expect(decoded['name'], 'Math 2023');
      expect(decoded['url'], 'https://example.com/math2023.pdf');
    });

    test('should maintain max 5 recent questions', () {
      var list = <String>[];

      for (int i = 0; i < 8; i++) {
        var question = <String, String>{
          'name': 'Question $i',
          'url': 'https://example.com/q$i.pdf',
        };
        String str = json.encode(question);
        if (list.contains(str)) list.remove(str);
        list.add(str);
        if (list.length > 5) list.removeAt(0);
      }

      expect(list.length, 5);
      expect(list.first, contains('Question 3'));
      expect(list.last, contains('Question 7'));
    });
  });
}
