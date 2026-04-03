// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jac_elearning/screens/BookScreen/Books.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'AppColor.dart';
import 'package:get/get.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'screens/HomeScreen/Home.dart';
import 'screens/QuestionScreen/Question.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart' as p;
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int appVersion = 11;
  int currentPage = 0;
  DatabaseReference rootRef = FirebaseDatabase.instance.ref();
  late PageController controller;
  List<String> title = ["Home", "Books", "Questions"];
  String androidAppURL =
      "https://play.google.com/store/apps/details?id=com.jac.jacboard.jacquestion.jac_elearning";

  @override
  void initState() {
    downloadImage();
    super.initState();
    controller = PageController(initialPage: currentPage);
  }

  downloadImage() async {
    var result = await Connectivity().checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      Get.snackbar('Connection Error', 'Please Turn on your Internet!',
          snackPosition: SnackPosition.TOP,
          borderColor: Colors.redAccent,
          borderWidth: 2,
          duration: const Duration(seconds: 6),
          backgroundColor: AppColor.white);
    }
    bool file =
        await File("${(await p.getExternalStorageDirectory())!.path}/image.png")
            .exists();
    if (!file) {
      final bytes = await rootBundle.load('assets/images/jacImage.png');
      File("${(await p.getExternalStorageDirectory())!.path}/image.png")
          .writeAsBytes(bytes.buffer.asUint8List());
    }
    rootRef.child('App Version').once().then((value) {
      if ((value.snapshot.value as int) > appVersion) showUpdate();
    });
  }

  showUpdate() {
    Get.defaultDialog(
        title: 'Update JAC eLearning',
        titleStyle: GoogleFonts.sen(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
        middleText: 'A new version of JAC eLearning is available! Update Now.',
        middleTextStyle: GoogleFonts.mPlusRounded1c(
            color: Colors.black87,
            fontSize: 18,
            wordSpacing: -0.7,
            fontWeight: FontWeight.w400),
        actions: [
          // ignore: deprecated_member_use
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              )),
          // ignore: deprecated_member_use
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.redAccent),
              onPressed: () {
                launch(androidAppURL);
              },
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.white),
              ))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppColor.background,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          title: Text(
            title[currentPage],
            style: GoogleFonts.sen(
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Colors.redAccent),
          ),
          leading: IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.redAccent,
              ),
              onPressed: () async {
                await bottomsheet(context);
              }),
          actions: [
            IconButton(
                icon: const Icon(
                  Icons.share_rounded,
                  color: Colors.redAccent,
                ),
                onPressed: () async {
                  File data = File(
                      "${(await p.getExternalStorageDirectory())!.path}/image.png");
                  await data.exists()
                      ? Share.shareXFiles([XFile(data.path)],
                          text:
                              "*Download JAC eLearning App :*\n$androidAppURL")
                      : Share.share(
                          "*Download JAC eLearning App :*\n$androidAppURL");
                })
          ],
          centerTitle: true,
          backgroundColor: AppColor.background,
          elevation: 0,
        ),
        body: PageView(
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              currentPage = value;
            });
          },
          children: const [Home(), Books(), Question()],
        ),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: AppColor.background,
          showElevation: true,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          animationDuration: const Duration(milliseconds: 300),
          itemCornerRadius: 15,
          onItemSelected: (value) {
            setState(() {
              currentPage = value;
              controller.jumpToPage(value);
            });
          },
          selectedIndex: currentPage,
          items: [
            navyBar(Icons.home_rounded, 'Home'),
            navyBar(Icons.dashboard, 'Books'),
            navyBar(Icons.article, 'Questions'),
          ],
        ));
  }

  BottomNavyBarItem navyBar(IconData icon, String str) {
    return BottomNavyBarItem(
        icon: Icon(icon),
        title: Text(str),
        inactiveColor: AppColor.text,
        activeColor: Colors.redAccent);
  }

  bottomsheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      enableDrag: true,
      elevation: 3,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              onTap: () {
                Get.back();
                result();
              },
              hoverColor: Colors.redAccent,
              leading: const Icon(
                Icons.article,
                color: Colors.black87,
              ),
              title: Text(
                'JAC Result',
                textAlign: TextAlign.start,
                style: GoogleFonts.mPlusRounded1c(
                    fontSize: 18,
                    wordSpacing: 0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              onTap: () {
                launch(
                  'https://jac.jharkhand.gov.in/jac/',
                  enableJavaScript: true,
                );
                Get.back();
              },
              hoverColor: Colors.redAccent,
              leading: const Icon(
                Icons.account_balance_rounded,
                color: Colors.black87,
              ),
              title: Text(
                'JAC Official Website',
                textAlign: TextAlign.start,
                style: GoogleFonts.mPlusRounded1c(
                    fontSize: 18,
                    wordSpacing: 0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              onTap: () {
                final uri = Uri(
                    scheme: 'mailto',
                    path: 'jacelearnig@gmail.com',
                    query:
                        'subject=JAC eLearning Feedback&body=App Version 1.0.5');
                launch(uri.toString());
                Get.back();
              },
              hoverColor: Colors.redAccent,
              leading: const Icon(
                Icons.email_rounded,
                color: Colors.black87,
              ),
              title: Text(
                'Feedback',
                textAlign: TextAlign.start,
                style: GoogleFonts.mPlusRounded1c(
                    fontSize: 18,
                    wordSpacing: 0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
            ),
            ListTile(
              onTap: () {
                launch(androidAppURL);
                Get.back();
              },
              hoverColor: Colors.redAccent,
              leading: const Icon(
                Icons.star_rate_outlined,
                color: Colors.black87,
              ),
              title: Text(
                'Rate',
                textAlign: TextAlign.start,
                style: GoogleFonts.mPlusRounded1c(
                    fontSize: 18,
                    wordSpacing: 0,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        );
      },
    );
  }

  result() {
    Get.defaultDialog(
        title: 'JAC Result',
        titleStyle: const TextStyle(color: Colors.black, fontSize: 20),
        content: Column(
          children: [
            tile('JAC 09th', 'Result/09th'),
            tile('JAC 10th', 'Result/10th'),
            tile('JAC 11th Science', 'Result/11th/Science'),
            tile('JAC 11th Commerce', 'Result/11th/Commerce'),
            tile('JAC 11th Arts', 'Result/11th/Arts'),
            tile('JAC 12th Science', 'Result/12th/Science'),
            tile('JAC 12th Commerce', 'Result/12th/Commerce'),
            tile('JAC 12th Arts', 'Result/12th/Arts'),
          ],
        ));
  }

  ListTile tile(String str, String url) {
    return ListTile(
      onTap: () async {
        var result = await Connectivity().checkConnectivity();
        if (!result.contains(ConnectivityResult.none)) {
          rootRef.child(url).once().then((value) {
            launchUrlString("${value.snapshot.value}");
          });
        } else {
          Get.back();
          Get.snackbar('Connection Error', 'Please Turn on your Internet!',
              snackPosition: SnackPosition.TOP,
              borderColor: Colors.redAccent,
              borderWidth: 2,
              backgroundColor: AppColor.white);
        }
      },
      hoverColor: Colors.redAccent,
      leading: const Icon(
        Icons.article,
        color: Colors.black87,
      ),
      title: Text(
        str,
        textAlign: TextAlign.start,
        style: GoogleFonts.mPlusRounded1c(
            fontSize: 18,
            wordSpacing: 0,
            color: Colors.black87,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
