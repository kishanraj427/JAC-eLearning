import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:jac_elearning/models/Subject.dart';

class QSubjectController extends GetxController {
  String clas;
  QSubjectController({required this.clas});
  RxList subjectList = [].obs;
  late DatabaseReference rootRef;

  @override
  void onInit() {
    rootRef =
        FirebaseDatabase.instance.ref().child("Question").child(clas);

    loadData();
    super.onInit();
  }

  loadData() async {
    try {
      print('load data Subject for $clas');
      rootRef.onChildAdded.listen((event) {
        var data = event.snapshot.value as Map?;
        if(data != null){var subject = Subject(clas: data["clas"], subjectName: data["subject"]);
        subjectList.add(subject);}
        //  debugPrint(subject.subjectName);
      });
    } catch (e) {
      print(e);
    }
  }
}
