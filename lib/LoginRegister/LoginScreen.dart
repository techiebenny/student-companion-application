//import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:studentui/LoginRegister/LogInPage.dart';
import 'package:studentui/LoginRegister/BasicInfo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  bool obscure = true;
  bool validLogin = true;

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            //backgroundColor: Color(0XFFf8f8f8),
            body: Container(
              decoration: BoxDecoration(
                  //image: DecorationImage(
                  //    image: AssetImage("assets/BG1.gif"),
                  //    fit: BoxFit.contain,
                  //    alignment: Alignment.topCenter),
                  color: Colors.lightBlue[100]),
              child: SafeArea(
                top: false,
                child: Container(
                    height: 100.h,
                    width: 100.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            constraints:
                                BoxConstraints(maxHeight: 500, maxWidth: 500),
                            child: Image.asset("assets/BG1.gif")),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: Text(
                                "Hey There!",
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 6.h,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 6.h,
                          width: 90.w,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              //Push the Initial Page to gather basic information
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInPage()));
                            },
                            icon: Icon(
                              Icons.navigate_next_rounded,
                              size: 3.h,
                            ),
                            label: Text(
                              "Let's Go!",
                              style: TextStyle(fontSize: 2.5.h),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0XFF509537)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 2.5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Not a user of the app? ",
                                  style: TextStyle(fontSize: 1.9.h)),
                              GestureDetector(
                                child: Text("Sign Up",
                                    style: TextStyle(
                                        fontSize: 1.9.h,
                                        color: Theme.of(context).focusColor,
                                        decoration: TextDecoration.underline)),
                                onTap: () {
                                  setState(() {
                                    print('Navigate to SignUp');
                                    //Navigator.push(
                                    //    context,
                                    //    MaterialPageRoute(
                                    //        builder: (context) => BasicInfo()));
                                  });
                                },
                              ),
                              Text(" (work in progress)",
                                  style: TextStyle(
                                      fontSize: 1.5.h, color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        );
      },
    );
  }
}
