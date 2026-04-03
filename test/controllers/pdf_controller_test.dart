import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:jac_elearning/controller/PDFController.dart';

void main() {
  group('PDFController', () {
    late PDFController controller;

    setUp(() {
      controller = PDFController(
        clas: '10th',
        type: 'Chapters',
        subject: 'Mathematics',
        name: 'Chapter 1',
        url: 'https://example.com/ch1.pdf',
      );
    });

    test('should initialize with correct values', () {
      expect(controller.clas, '10th');
      expect(controller.type, 'Chapters');
      expect(controller.subject, 'Mathematics');
      expect(controller.name, 'Chapter 1');
      expect(controller.url, 'https://example.com/ch1.pdf');
    });

    test('should have default observable values', () {
      expect(controller.hide.value, false);
      expect(controller.isLoaded.value, false);
      expect(controller.pageNo.value, 0);
      expect(controller.downData.value, 0.0);
    });

    test('hide should toggle correctly', () {
      expect(controller.hide.value, false);
      controller.hide.value = true;
      expect(controller.hide.value, true);
      controller.hide.value = false;
      expect(controller.hide.value, false);
    });

    test('pageNo should update correctly', () {
      controller.pageNo.value = 5;
      expect(controller.pageNo.value, 5);
      controller.pageNo.value = 10;
      expect(controller.pageNo.value, 10);
    });

    test('downData should track download progress', () {
      controller.downData.value = 50.0;
      expect(controller.downData.value, 50.0);
      controller.downData.value = 100.0;
      expect(controller.downData.value, 100.0);
    });

    test('isLoaded should change after loading', () {
      expect(controller.isLoaded.value, false);
      controller.isLoaded.value = true;
      expect(controller.isLoaded.value, true);
    });
  });
}
