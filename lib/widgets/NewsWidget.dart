// ignore_for_file: unnecessary_null_comparison

import 'package:any_link_preview/any_link_preview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jac_elearning/controller/NewsController.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../AppColor.dart';

// ignore: must_be_immutable
class NewsWidget extends StatelessWidget {
  String url, type, id, text;
  NewsWidget(
      {super.key, required this.id,
      required this.type,
      required this.text,
      required this.url});

  getUID() async {
    Get.find<NewsController>()
        .rootRef
        .value
        .child(id)
        .child('view')
        .child(Get.find<NewsController>().deviceId)
        .set(0);
  }

  launchUrl() async {
    launch(
      url,
      enableJavaScript: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return InkWell(
        onTap: () async {
          getUID();
          if (type == "PDF") {
            Get.generalDialog(
              barrierDismissible: false,
              barrierColor: AppColor.background,
              pageBuilder: (context, animation, secondaryAnimation) {
                return Scaffold(
                    appBar: AppBar(
                        title: Text(
                      text,
                      style: const TextStyle(color: Colors.redAccent),
                    )),
                    body: SizedBox.expand(child: SfPdfViewer.network(url)));
              },
            );
          } else if (type == "IMAGE") {
            Get.generalDialog(
              barrierDismissible: false,
              barrierColor: AppColor.background,
              pageBuilder: (context, animation, secondaryAnimation) {
                return SizedBox.expand(
                  child: PhotoView(
                    imageProvider: NetworkImage(url),
                  ),
                );
              },
            );
          } else {
            launchUrl();
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(1.5, 1.5)),
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: widget(context),
          ),
        ));
  }

  Widget widget(BuildContext context) {
    if (type == "URL") return urlWidget();
    if (type == "IMAGE") return imageWidget(context);
    if (type == "PDF") return tile(Icons.picture_as_pdf_rounded);
    return Container();
  }

  Widget urlWidget() {
    return (text == null || text.isEmpty)
        ? AnyLinkPreview(
            link: url,
            backgroundColor: Colors.white,
            previewHeight: 140,
            titleStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
            bodyStyle: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.w400),
            onTap: () {
              getUID();
              launchUrl();
            },
          )
        : Container();
  }

  Widget imageWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0.8, 0.8)),
          ]),
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.fitWidth,
            height: 150,
            width: MediaQuery.of(context).size.width - 20,
            imageBuilder: (context, imageProvider) =>
                Image(image: imageProvider),
            progressIndicatorBuilder: (context, url, progress) => SizedBox(
              height: 15,
              width: 15,
              child: LinearProgressIndicator(
                color: AppColor.mainColor,
              ),
            ),
          ),
          text != null
              ? Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      text,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.mPlusRounded1c(
                          fontSize: 18,
                          wordSpacing: 0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget tile(IconData icon) {
    return ListTile(
      dense: true,
      hoverColor: Colors.redAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      leading: Icon(
        icon,
        color: Colors.redAccent,
        size: 30,
      ),
      tileColor: Colors.white,
      title: Text(
        text,
        textAlign: TextAlign.start,
        style: GoogleFonts.mPlusRounded1c(
            fontSize: 18,
            wordSpacing: 0,
            color: Colors.black87,
            fontWeight: FontWeight.w600),
      ),
    );
  }
}
