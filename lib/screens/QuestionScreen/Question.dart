import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jac_elearning/controller/QuestionController.dart';
import 'package:jac_elearning/widgets/Header.dart';
import 'package:jac_elearning/widgets/QClassesWidget.dart';
import 'package:jac_elearning/widgets/RecentQuestionWidget.dart';
import '../../AppColor.dart';

class Question extends StatefulWidget {
  const Question({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  final rootRef = FirebaseDatabase.instance.ref().child("Question");
  TextEditingController controller = TextEditingController();
  late QuestionController questionController;

  @override
  void initState() {
    questionController = Get.put(QuestionController());
    super.initState();
    // loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(physics: const BouncingScrollPhysics(), slivers: [
        SliverToBoxAdapter(
          child: Header(
            path: 'assets/lottie/test.json',
            title: "JAC Questions",
            description: "Get all previous year question",
          ),
        ),
        Obx(() => SliverToBoxAdapter(
              child: questionController.recentList.isEmpty
                  ? Container()
                  : recentDat(context),
            )),
        Obx(() => questionController.questionList.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 100),
                    child: CircularProgressIndicator(
                        strokeWidth: 4, color: AppColor.mainColor),
                  ))
                : SliverList.builder(
                    itemCount: questionController.questionList.length,
                    itemBuilder: (context, index) {
                      return QClassesWidget(
                        title: questionController.questionList[index],
                      );
                    },
                  )
            // : SliverStaggeredGrid.countBuilder(
            //     crossAxisCount: 1,
            //     itemCount: questionController.questionList.length,
            //     itemBuilder: (context, index) {
            //       return QClassesWidget(
            //         title: questionController.questionList[index],
            //       );
            //     },
            //     staggeredTileBuilder: (index) {
            //       return new StaggeredTile.fit(1);
            //     },
            //     mainAxisSpacing: 4,
            //     crossAxisSpacing: 4,
            //   ),
            )
      ]),
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
              boxShadow: const [
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
                  itemCount: questionController.recentList.length,
                  itemBuilder: (context, index) {
                    return RecentQuestionWidget(
                        name: questionController.recentList[index]['name'],
                        url: questionController.recentList[index]['url']);
                  },
                ))),
      ],
    );
  }
}
