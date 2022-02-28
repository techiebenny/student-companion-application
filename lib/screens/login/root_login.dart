import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_app/screens/login/localwidgets/loginform.dart';


class RootLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/LoginBG.jpg'), fit: BoxFit.fill)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth > 1260) {
            return desktopView(size);
          } else
            return mobileView(size);
        }),
      ),
    ));
  }
}

Widget desktopView(Size size) {
  return Container(
    margin: EdgeInsets.only(right: size.width * 0.65),
    child: Column(
      children: [
        //Image.asset('assets/logo.png'),
        RootLoginForm()

      ],
    ),
  );
}

Widget mobileView(Size size) {
  return Center(
    child: Container(
      margin: EdgeInsets.only(
          left: size.width * 0.1,
          top: size.height * 0.1,
          right: size.width * 0.1),
      child: Column(
        children: [
          //Image.asset('assets/logo.png'),
          RootLoginForm(),
        ],
      ),
    ),
  );
}
