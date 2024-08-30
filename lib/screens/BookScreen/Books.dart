import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jac_elearning/controller/ClassController.dart';
import 'package:jac_elearning/widgets/ClassesWidget.dart';
import 'package:jac_elearning/widgets/Header.dart';
import 'package:jac_elearning/AppColor.dart';
import 'package:jac_elearning/widgets/RecentBookWidget.dart';

class Books extends StatefulWidget {
  const Books({super.key});

  @override
  BooksState createState() => BooksState();
}

class BooksState extends State<Books> {
  late Size screenSize;
  late TextEditingController controller = TextEditingController();
  late ClassController classController = Get.put(ClassController());

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Header(
              path: 'assets/lottie/study_stand.json',
              title: "JAC Books",
              description: "Get all books related JAC Board",
            ),
          ),
          Obx(() => SliverToBoxAdapter(
                child: classController.recentList.isEmpty
                    ? Container()
                    : recentDat(context),
              )),
          Obx(
            () => classController.classList.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 100),
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      color: AppColor.mainColor,
                    ),
                  ))
                : SliverList.builder(
                    itemCount: classController.classList.length,
                    itemBuilder: (context, index) {
                      return ClassesWidget(
                        title: classController.classList[index],
                      );
                    },
                  ),
          )
        ],
      ),
      backgroundColor: AppColor.background,
    );
  }

  Widget recentDat(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const[
                BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 0,
                    blurRadius: 2,
                    offset: Offset(0.8, 0.8)),
              ]),
          child: Text(
            "Recent",
            textAlign: TextAlign.start,
            style: GoogleFonts.mPlusRounded1c(
                fontSize: 20,
                wordSpacing: 0,
                color: Colors.black87,
                fontWeight: FontWeight.w600),
          ),
        ),
        ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: Obx(() => ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: classController.recentList.length,
                  itemBuilder: (context, index) {
                    return RecentBookWidget(
                        clas: classController.recentList[index]['clas'],
                        subject: classController.recentList[index]['subject'],
                        type: classController.recentList[index]['type'],
                        name: classController.recentList[index]['name'],
                        url: classController.recentList[index]['url']);
                  },
                ))),
      ],
    );
  }
}
