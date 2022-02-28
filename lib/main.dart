import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studentui/BottomNavBarScreen.dart';
import 'package:studentui/HomeScreen.dart';
import 'LoginRegister/LoginScreen.dart';

void main() {
  // To fix screen orientation as portrait only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor:
        Colors.black.withOpacity(0.2), //or set color with: Color(0xFF0000FF)
  ));

  runApp(MyApp());
}

//ignore: must_be_immutable
class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Init.instance.initialize(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(home: Splash());
          } else {
            return MaterialApp(
              title: 'Student App',
              theme: customTheme(),
              home: HomeScreen(),
            );
          }
        });
  }

  ThemeData customTheme() {
    return ThemeData(
        fontFamily: 'Roboto',
        primaryColor: Color(0XFFffffff),
        //0db2b2
        focusColor: Color(0XFF509537),
        bottomAppBarColor: Color(0XFFf2fffe),
        backgroundColor: Color(0XFFf2f2f6),
        disabledColor: Color(0XFF757a96),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Color(0XFF509537)))),
        primaryTextTheme: TextTheme(
          headline1: TextStyle(
            color: Color(0XFF193636),
            fontWeight: FontWeight.bold,
            fontSize: 44.0,
          ),
          bodyText1: TextStyle(
              color: Color(0XFF000000),
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
          subtitle1: TextStyle(
              color: Color(0XFF000000),
              fontWeight: FontWeight.w200,
              fontSize: 14.0),
        ));
  }
}

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool lightMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor:
          lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: lightMode
              ? Image.asset(
                  'assets/splashScreen.png',
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/splashScreen.png',
                  fit: BoxFit.cover,
                )),
    );
  }
}

class Init {
  Init._();
  static final instance = Init._();

  Future initialize() async {
    // This is where you can initialize the resources needed by your app while
    // the splash screen is displayed.  Remove the following example because
    // delaying the user experience is a bad design practice!
    await Future.delayed(const Duration(seconds: 0));
  }
}
