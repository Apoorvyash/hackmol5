import 'dart:async';
import 'package:android_physical_buttons/android_physical_buttons.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shake/shake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:saheli_hackmol/theme.dart';

import 'BottomNavBar.dart';
import 'FakeCaller/screens/caller_screen.dart';
import 'FakeCaller/screens/incoming_call.dart';


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
// List<Permission> statuses = [
//   Permission.audio,
//   Permission.location,
//   Permission.camera,
//   Permission.sms,
//   Permission.storage,
//   Permission.contacts
// ];
// Future<void> requestPermission() async {
//   try {
//     for (var element in statuses) {
//       if ((await element.status.isDenied ||
//           await element.status.isPermanentlyDenied)) {
//         await statuses.request();
//       }
//     }
//   } catch (e) {
//     debugPrint('$e');
//   } finally {
//     await requestPermission();
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await dotenv.load();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
      routes: {'/CallerScreen': (context) =>  CallerScreen()}
  ));

}


class _MyAppState extends State<MyApp> {
  final PageController _pageController = PageController(); // Moved it here

  bool isLogin = false;

  getLoggedinState() async {
    // await LocalDb.getEmail().then((value) {
    //   print(value);
    //   setState(() {
    //     if (value.toString() != "null") {
    //       isLogin = true;
    //     }
    //   });
    // });
  }
  void playRingtone() {
    FlutterRingtonePlayer.playRingtone(asAlarm: true);
  }

  @override
  void initState() {
    getLoggedinState();
    AndroidPhysicalButtons.listen((key) {
      print(key);
    });
    AndroidVolumeButtons.listenForVolumeButtons((volume) {
      Fluttertoast.showToast(msg: "Volume changed: $volume");
    });
    ShakeDetector.autoStart(
        onPhoneShake: () {
          // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('shaked')));
          playRingtone();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => IncomingCall(
                name: "Unknown",
                number: "(410) 0679 890",
              ),
            ),
          );
          // playRingtone();
        },
        minimumShakeCount: 2,
        shakeSlopTimeMS: 500,
        shakeCountResetTime: 3000,
        shakeThresholdGravity: 5.0
    );
    print(isLogin);

    // Add a delay to simulate a splash screen effect
    Timer(Duration(seconds: 2), () {
      getLoggedinState();

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the controller here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(context),
          home: FutureBuilder(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return BottomNavBar() ;
              } else {
                return SplashScreen();
              }
            },
          ),
          routes: {
            '/CallerScreen': (context) => CallerScreen(),
          });
  }

  // _calling() async {
  //   const url = 'tel:+12345678';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 30, 128),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Center(
                  child: Container(
                    height: 250,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img.png'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'S A H E L I',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Towards A Safe \'YOU\'',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )
              ]),
        ),
      );
  }

}


class AndroidVolumeButtons {
  static const MethodChannel _channel =
  MethodChannel('android_volume_buttons');

  static void listenForVolumeButtons(void Function(dynamic) callback) {
    EventChannel('android_volume_buttons_events').receiveBroadcastStream().listen((dynamic event) {
      callback(event);
    });
  }
}