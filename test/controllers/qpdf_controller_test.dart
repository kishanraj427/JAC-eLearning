import 'package:flutter_test/flutter_test.dart';
import 'package:jac_elearning/controller/QPDFController.dart';

void main() {
  group('QPDFController', () {
    late QPDFController controller;

    setUp(() {
      controller = QPDFController(
        name: 'Math 2023',
        url: 'https://example.com/math2023.pdf',
      );
    });

    test('should initialize with correct values', () {
      expect(controller.name, 'Math 2023');
      expect(controller.url, 'https://example.com/math2023.pdf');
    });

    test('should have default observable values', () {
      expect(controller.hide.value, false);
      expect(controller.pageNo.value, 0);
    });

    test('hide should toggle correctly', () {
      controller.hide.value = true;
      expect(controller.hide.value, true);
      controller.hide.value = false;
      expect(controller.hide.value, false);
    });

    test('pageNo should update correctly', () {
      controller.pageNo.value = 3;
      expect(controller.pageNo.value, 3);
    });
  });
}
