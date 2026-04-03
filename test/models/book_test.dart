import 'package:flutter_test/flutter_test.dart';
import 'package:jac_elearning/models/Book.dart';

void main() {
  group('Book Model', () {
    test('should create a Book with name and pdfUrl', () {
      final book = Book(name: 'Chapter 1', pdfUrl: 'https://example.com/ch1.pdf');

      expect(book.name, 'Chapter 1');
      expect(book.pdfUrl, 'https://example.com/ch1.pdf');
    });

    test('should allow updating name and pdfUrl', () {
      final book = Book(name: 'Old Name', pdfUrl: 'https://old.com/old.pdf');

      book.name = 'New Name';
      book.pdfUrl = 'https://new.com/new.pdf';

      expect(book.name, 'New Name');
      expect(book.pdfUrl, 'https://new.com/new.pdf');
    });

    test('should handle empty strings', () {
      final book = Book(name: '', pdfUrl: '');

      expect(book.name, '');
      expect(book.pdfUrl, '');
    });

    test('should handle special characters in name', () {
      final book = Book(
        name: 'Chapter 1: Introduction & Overview (Part-1)',
        pdfUrl: 'https://example.com/ch1.pdf',
      );

      expect(book.name, 'Chapter 1: Introduction & Overview (Part-1)');
    });
  });
}
