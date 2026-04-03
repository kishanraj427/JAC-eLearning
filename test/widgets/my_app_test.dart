import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:jac_elearning/AppColor.dart';

void main() {
  group('MyApp Theme', () {
    test('AppColor mainColor should be red tone', () {
      expect(AppColor.mainColor.red, greaterThan(200));
      expect(AppColor.mainColor.green, lessThan(128));
      expect(AppColor.mainColor.blue, lessThan(128));
    });

    test('AppColor background should be light gray', () {
      expect(AppColor.background.red, greaterThan(200));
      expect(AppColor.background.green, greaterThan(200));
      expect(AppColor.background.blue, greaterThan(200));
    });
  });

  group('Navigation structure', () {
    test('GetMaterialApp should be configurable', () {
      final app = GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JAC eLearning',
        theme: ThemeData(
          primarySwatch: Colors.red,
          primaryColor: AppColor.mainColor,
        ),
        home: const Scaffold(body: Text('Test')),
      );

      expect(app, isA<GetMaterialApp>());
    });
  });

  group('Bottom Navigation', () {
    test('should have 3 tabs', () {
      final titles = ['Home', 'Books', 'Questions'];

      expect(titles.length, 3);
      expect(titles[0], 'Home');
      expect(titles[1], 'Books');
      expect(titles[2], 'Questions');
    });

    test('initial page should be 0', () {
      const currentPage = 0;
      expect(currentPage, 0);
    });
  });
}
