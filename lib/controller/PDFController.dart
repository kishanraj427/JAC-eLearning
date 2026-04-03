import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jac_elearning/AppColor.dart';
import 'package:jac_elearning/controller/ClassController.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter_google_ad_manager/flutter_google_ad_manager.dart';

class PDFController extends GetxController {
  String url, name, clas, subject, type;
  RxBool hide = false.obs;
  RxBool isLoaded = false.obs;
  RxInt pageNo = 0.obs;
  RxDouble downData = 0.0.obs;
  late File file;
  late Directory directory, dir;

  // Rx<DFPBanner> banner = DFPBanner(
  //   isDevelop: false,
  //   adUnitId: 'ca-app-pub-7992530201347666/6612650124',
  //   adSize: DFPAdSize.BANNER,
  //   onAdLoaded: () {
  //     print('Banner onAdLoaded');
  //   },
  //   onAdFailedToLoad: (errorCode) {
  //     print('Banner onAdFailedToLoad: errorCode:$errorCode');
  //   },
  //   onAdOpened: () {
  //     print('Banner onAdOpened');
  //   },
  //   onAdClosed: () {
  //     print('Banner onAdClosed');
  //   },
  //   onAdLeftApplication: () {
  //     print('Banner onAdLeftApplication');
  //   },
  // ).obs;

  // Rx<DFPInterstitialAd> interstitialAd = DFPInterstitialAd(
  //   isDevelop: false,
  //   adUnitId: "ca-app-pub-7992530201347666/9442186968",
  //   onAdLoaded: () {
  //     print('interstitialAd onAdLoaded');
  //   },
  //   onAdFailedToLoad: (errorCode) {
  //     print('interstitialAd onAdFailedToLoad: errorCode:$errorCode');
  //   },
  //   onAdOpened: () {
  //     print('interstitialAd onAdOpened');
  //   },
  //   onAdClosed: () {
  //     print('interstitialAd onAdClosed');
  //   },
  //   onAdLeftApplication: () {
  //     print('interstitialAd onAdLeftApplication');
  //   },
  // ).obs;

  PDFController({required this.clas, required this.type, required this.subject, required this.name, required this.url});

  @override
  void onInit() {
    super.onInit();
    addToRecent();
    load();
    // interstitialAd.value.load();
  }

  load() async {
    dir = (await getExternalStorageDirectory())!;
    directory = Directory('${dir.path}/$clas/$subject/$type');
    if (await directory.exists() &&
        await File('${directory.path}/$name.pdf').exists()) {
      file = File('${directory.path}/$name.pdf');
      isLoaded.value = true;
      loadPDFPage();
    } else {
      var cc = await checkDirectory('${dir.path}/$clas');
      if (cc) {
        var cs = await checkDirectory('${dir.path}/$clas/$subject');
        if (cs) {
          var ct = await checkDirectory('${dir.path}/$clas/$subject/$type');
          if (ct) {
            var result = await Connectivity().checkConnectivity();
            if (!result.contains(ConnectivityResult.none)) {
              loadPDF(url);
            } else {
              Get.snackbar('Connection Error', 'Please Turn on your Internet!',
                  snackPosition: SnackPosition.TOP,
                  borderColor: AppColor.mainColor,
                  borderWidth: 2,
                  backgroundColor: AppColor.white);
            }
          }
        }
      }
    }
  }

  loadPDF(String url) async {
    try {
      HttpClient client = HttpClient();
      var request = await client.getUrl(Uri.parse(url));
      var response = await request.close();
      int dataSize = response.contentLength;
      final bytes = <int>[];
      await for (var chunk in response) {
        bytes.addAll(chunk);
        if (dataSize > 0) {
          downData.value = (bytes.length * 100 / dataSize);
        }
      }
      if (bytes.isNotEmpty) {
        file = File('${directory.path}/$name.pdf');
        await file.writeAsBytes(bytes, flush: true);
        isLoaded.value = true;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  loadPDFPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? data = preferences.getInt(name);
    pageNo.value = data ?? 0;
  }

  expand() {
    hide.value
        ? SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [])
        : SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
    Fluttertoast.showToast(
        msg: hide.value ? "FullScreen Enable" : "FullScreen Disable");
  }

  setData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(name, pageNo.value);
  }

  addToRecent() async {
    //var recentBookList = <RecentBook>[];
    var book = <String, String>{};
    book['clas'] = clas;
    book['subject'] = subject;
    book['type'] = type;
    book['name'] = name;
    book['url'] = url;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    var list = preferences.getStringList('recentBookList');
    list ??= [];
    String str = json.encode(book);
    if (list.contains(str)) list.remove(str);
    list.add(str);
    if (list.length > 5) list.removeAt(0);
    preferences.setStringList('recentBookList', list);
    Get.find<ClassController>().loadRecent();
  }

  Future<bool> checkDirectory(String path) async {
    if (!await Directory(path).exists()) {
      await Directory(path).create();
    }
    return true;
  }
}
