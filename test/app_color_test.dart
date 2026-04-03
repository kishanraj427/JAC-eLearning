import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jac_elearning/AppColor.dart';

void main() {
  group('AppColor', () {
    test('background color should be #EFEFEF', () {
      expect(AppColor.background, const Color(0xffefefef));
    });

    test('mainColor should be #FF5E5E', () {
      expect(AppColor.mainColor, const Color(0xffff5e5e));
    });

    test('title color should be #212121', () {
      expect(AppColor.title, const Color(0xff212121));
    });

    test('text color should be #3B3B3B', () {
      expect(AppColor.text, const Color(0xff3b3b3b));
    });

    test('white color should be #FFFFFF', () {
      expect(AppColor.white, const Color(0xffffffff));
    });

    test('all colors should be fully opaque', () {
      expect(AppColor.background.alpha, 255);
      expect(AppColor.mainColor.alpha, 255);
      expect(AppColor.title.alpha, 255);
      expect(AppColor.text.alpha, 255);
      expect(AppColor.white.alpha, 255);
    });
  });
}
