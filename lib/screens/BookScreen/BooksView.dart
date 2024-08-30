import 'package:flutter/material.dart';
import 'ChapterList.dart';
import 'SolutionList.dart';

// ignore: must_be_immutable
class BooksView extends StatelessWidget {
  String clas, subject;
  BooksView({super.key, required this.clas, required this.subject});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(subject,
              style: const TextStyle(
                color: Colors.red,
              )),
          bottom: const TabBar(
            physics: BouncingScrollPhysics(),
            labelColor: Colors.red,
            labelStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
            tabs: [
              Tab(
                text: "Chapters",
              ),
              Tab(
                text: "Solutions",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            BookList(
              clas: clas,
              subject: subject,
            ),
            SolutionList(
              clas: clas,
              subject: subject,
            )
          ],
        ),
      ),
    );
  }
}
