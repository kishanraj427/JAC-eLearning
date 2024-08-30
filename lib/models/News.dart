import 'dart:io';

class News {
  String key, text, type, url;
  late File pdf, image;
  News({required this.key,required this.type, required this.text, required this.url});
  String toString() {
    return "Type: $type\nText: $text\nUrl: $url\nPdf: $pdf\nImage: $image";
  }
}
