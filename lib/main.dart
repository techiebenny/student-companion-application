import 'package:flutter/material.dart';
import 'package:college_dept_portals/DepartmentDashboard/DepartmentDashboard.dart';
import 'package:college_dept_portals/CollegeDashboard/CollegeDashboard.dart';
import 'package:college_dept_portals/ColDeptSelectionScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

bool loggedinclg = false;
bool loggedindept = false;
bool result=false;
Widget control = ColDeptSelectionScreen();


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


//ignore: must_be_immutable
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Student App',
//       home: ColDeptSelectionScreen(),
//       builder: EasyLoading.init(),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  State<MyApp> createState() => _MyApp();
}


class _MyApp extends State<MyApp> {
  Future isUserSignedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? collegesignin = prefs.getBool("collegesignedin");
    bool? deptsignin = prefs.getBool("deptsignedin");
    // print(logdata);
    if (collegesignin != null) {
      loggedinclg = collegesignin;
    }
    if (deptsignin != null) {
      loggedindept = deptsignin;
    }
    result = loggedinclg || loggedindept;
    return result;
  }

  @override
  void initState() {
    isUserSignedin().whenComplete(() async {
      if (result == false) {
        setState(() {
          control = ColDeptSelectionScreen();
        });
      } else if (loggedinclg == true) {
        control = CollegeDashboard();
      }
      else {
        control = DepartmentDashboard();
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student App',
      home:control ,
      builder: EasyLoading.init(),
    );
  }
}


