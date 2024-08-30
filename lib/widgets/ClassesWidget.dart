import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jac_elearning/controller/SubjectController.dart';
import 'package:jac_elearning/screens/BookScreen/SubjectScreen.dart';

import '../AppColor.dart';
import 'SubjectWidget.dart';

// ignore: must_be_immutable
class ClassesWidget extends StatefulWidget {
  String title;
  ClassesWidget({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => ClassesWidget2State();
}

class ClassesWidget2State extends State<ClassesWidget> {
  late SubjectController controller;
  late String title;
  @override
  void initState() {
    title = widget.title;
    controller = Get.put(SubjectController(clas: widget.title));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(SubjectController(clas: widget.title),
        permanent: true, tag: widget.title);
    //Get.create(() => SubjectController(clas: title));
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SubjectScreen(
                            clas: title,
                          )));
                },
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.mPlusRounded1c(
                      fontSize: 20,
                      wordSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => SubjectScreen(
                            clas: title,
                          )));
                },
                child: Text(
                  "See All",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.mPlusRounded1c(
                      fontSize: 20,
                      wordSpacing: 0,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
        ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: Obx(() => controller.subjectList.isEmpty
                ? CircularProgressIndicator(
                    color: AppColor.mainColor,
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    // shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: controller.subjectList.length,
                    itemBuilder: (context, index) {
                      return SubjectWidget(
                        clas: controller.subjectList[index].clas,
                        subject: controller.subjectList[index].subjectName,
                      );
                    },
                  ))),
      ],
    );
  }
}
