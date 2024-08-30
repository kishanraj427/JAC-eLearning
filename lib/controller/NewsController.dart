import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:jac_elearning/models/News.dart';

class NewsController extends GetxController {
  RxList newsList = [].obs;
  late String deviceId;
  Rx<DatabaseReference> rootRef =
      FirebaseDatabase.instance.ref().child('News').obs;
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  loadData() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceId = androidInfo.id;

    try {
      rootRef.value.onChildAdded.listen((event) {
        var data = event.snapshot.value as Map?;
        if (data != null) {
          var news = News(
              key: data['key'] ?? "",
              type: data['type'] ?? "",
              text: data['text'] ?? "",
              url: data['url'] ?? "");
          newsList.insert(0, news);
        }
      });
    } catch (e) {}
  }
}
