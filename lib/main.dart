import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/DB/college_db.dart';
import 'package:student_app/screens/rootadmin/build_college_tile.dart';
import 'package:student_app/screens/rootadmin/new_college.dart';
import 'package:student_app/screens/rootadmin/update_college.dart';
import 'package:student_app/screens/login/root_login.dart';
import 'package:student_app/screens/rootadmin/root_dashboard.dart';
import 'package:student_app/utils/newtheme.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  runApp(MyApp());
  configLoading();
}

bool loggedin = false;

Widget control = new MaterialApp();

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
  //..customAnimation = CustomAnimation();
}

// class MyApp extends StatelessWidget {
//   // College c = College(
//   //     id: 1,
//   //     name: 'Name',
//   //     logo: 'Logo',
//   //     bigpicture: 'BigPic',
//   //     userid: '1YEh',
//   //     password: 'Password');
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     isUserSignedin();
//     // print(loggedin);
//     if (loggedin == true) {
//       return MaterialApp(
//         // theme: NewTheme().buildTheme(),
//         theme: NewTheme().buildTheme(),
//         home: //NewCollege(),
//         // UpdateCollege(c),
//         // RootLogin(),
//         RootDashboard(),
//         // BuildCollegeTile(),
//         builder: EasyLoading.init(),
//       );
//     }
//   else{
//     return MaterialApp(
//       // theme: NewTheme().buildTheme(),
//       theme: NewTheme().buildTheme(),
//       home: //NewCollege(),
//       // UpdateCollege(c),
//       RootLogin(),
//       // RootDashboard(),
//       // BuildCollegeTile(),
//       builder: EasyLoading.init(),
//     );
//   }
//   }
// }

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  Future isUserSignedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? logdata = prefs.getBool("signedin");
    print(logdata);
    if (logdata != null) {
      loggedin = logdata;
    }
    print(loggedin);
    return loggedin;
  }

  @override
  void initState() {
    isUserSignedin().whenComplete(() async {
      if (loggedin == false) {
        setState(() {
          control = RootLogin();
        });
      } else {
        control = RootDashboard();
      }
    });

    // TODO: implement initState
    super.initState();
  }

  // @override
  // Widget build(BuildContext context) {
  //     return MaterialApp(
  //       // theme: NewTheme().buildTheme(),
  //       theme: NewTheme().buildTheme(),
  //       home: //NewCollege(),
  //       // UpdateCollege(c),
  //       // RootLogin(),
  //       // RootDashboard(),
  //       control,
  //       // BuildCollegeTile(),
  //       builder: EasyLoading.init(),
  //     );
  //
  // }
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  String imgUrl = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something Went wrong,Please try again later"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            // theme: NewTheme().buildTheme(),
            theme: NewTheme().buildTheme(),
            home: //NewCollege(),
                // UpdateCollege(c),
                // RootLogin(),
                // RootDashboard(),
                control,
            // BuildCollegeTile(),
            builder: EasyLoading.init(),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  uploadToStorage() {
    FileUploadInputElement input = FileUploadInputElement()..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref().child('imgfile').putBlob(file);
        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imgUrl = downloadUrl;
        });
      });
    });
  }
}
