import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'AppColor.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'MyHomePage.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'jac', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    enableVibration: true,
    ledColor: Colors.redAccent,
    showBadge: true,
    enableLights: true,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'JAC eLearning',
        theme: ThemeData(
            primarySwatch: Colors.red,
            primaryColor: AppColor.mainColor,
            // accentColor: Colors.redAccent,
            // backgroundColor: AppColor.background,
            appBarTheme: AppBarTheme(
              color: AppColor.background,
              iconTheme: const IconThemeData(color: Colors.redAccent),
            )),
        home: const MySplash(
          title: 'JAC eLearning',
        )
        //MyHomePage(title: 'JAC eLearning'),
        );
  }
}

class MySplash extends StatefulWidget {
  const MySplash({super.key, required this.title});

  final String title;

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MySplash> {
  @override
  void initState() {
    super.initState();
    var initializationSettingAndroid =
        const AndroidInitializationSettings('@drawable/ic_noti');
    var initializationSetting =
        InitializationSettings(android: initializationSettingAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSetting);
    FirebaseMessaging.instance.subscribeToTopic("jac");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: '@drawable/ic_noti',
              priority: Priority.high,
              importance: Importance.high,
              color: Colors.redAccent,
              playSound: true,
              enableLights: true,
              enableVibration: true,
              vibrationPattern: Int64List.fromList([0, 100, 1000, 200, 2000]),
            )));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});

    loadPage();
  }

  loadPage() {
    Timer(
        const Duration(seconds: 4),
        () => Get.off(
            const MyHomePage(
              title: "JAC eLearning",
            ),
            curve: Curves.elasticInOut));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/animi.json',
          alignment: Alignment.center,
          repeat: false,
          width: 300,
          height: 350,
        ),
      ),
    );
  }
}
