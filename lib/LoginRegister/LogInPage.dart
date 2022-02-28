//import 'dart:html';
//import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:demoji/demoji.dart';
import 'package:sizer/sizer.dart';
import 'package:studentui/LoginRegister/BasicInfo.dart';
import 'package:studentui/LoginRegister/ClassCode.dart';

import '../BottomNavBarScreen.dart';
import 'LoginServices/student_services.dart';
//import '../BottomNavBarScreen.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

bool obscure = true;

class _LogInPageState extends State<LogInPage> {
  TextEditingController _signin_username = new TextEditingController();
  TextEditingController _signin_password = new TextEditingController();
  final snackbarIncorrectCredentials = new SnackBar(content: Text("enter valid credentials"));

  GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();

  bool validateSignupForm() {
    if (_signinFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login_background.png"),
                  fit: BoxFit.cover)),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                //decoration: BoxDecoration(color: Colors.grey),
                margin: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  children: [
                    SizedBox(height: 5.h),
                    //Welcome Back Text
                    Container(
                      width: 100.w,
                      child: Text(
                        "Welcome Back " + Demoji.tada,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 4.h, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 1.0.h),
                    /*
                    Container(
                      width: 100.w,
                      child: Text(
                        "Great to see you again!\nEnter your details below to get back into the loop.\n",
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 1.9.h),
                      ),
                    ),

                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 10.0,
                        sigmaY: -10.0,
                      ),
                      child:


                       Container(
                      padding: EdgeInsets.fromLTRB(15.0, 30.0, 15.0, 30.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                       GestureDetector(
                            child: Container(
                              width: 72.w,
                              height: 5.h,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5)
                              ),

                            ),
                          ),
                    */
                    SizedBox(height: 1.h),
                    Form(
                      key: _signinFormKey,
                      child: Column(
                        children: [
                          Container(
                            width: 100.w,
                            child: Text(
                              "Email",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 2.1.h, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          TextFormField(
                            controller: _signin_username,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This is a Required Field";
                                } else {
                                  bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                      .hasMatch(value);
                                  if (!emailValid) {
                                    return "Enter a valid email";
                                  } else {
                                    return null;
                                  }
                                }
                              },
                              style: TextStyle(fontSize: 1.9.h),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                fillColor: Theme.of(context).primaryColor,
                                filled: true,
                                hintText: "yourid@example.com",
                                prefixIcon: Icon(Icons.email_rounded),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Colors.blue)),
                              )),
                          SizedBox(height: 3.h),
                          Container(
                            width: 100.w,
                            child: Text(
                              "Password",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 2.1.h, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 0.5.h),
                          TextFormField(
                            controller: _signin_password,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("This is a required field");
                              } else {
                                return null;
                              }
                            },
                            style: TextStyle(fontSize: 1.9.h),
                            obscureText: obscure,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: Icon(Icons.vpn_key),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    borderSide: BorderSide(color: Colors.blue)),
                                hintText: "Your password here",
                                suffixIcon: GestureDetector(
                                  child: Icon(Icons.remove_red_eye_outlined),
                                  onTap: () {
                                    setState(() {
                                      obscure = !obscure;
                                    });
                                  },
                                )),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 3.h),
                    //Log-in Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            width: 80.w,
                            height: 6.h,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.5),
                                primary: Colors.pinkAccent,
                              ),
                              onPressed: () {
                                {
                                  if (validateSignupForm()) {
                                    Services.checkLogin(_signin_username.text,_signin_password.text).then((result){
                                      print(result);

                                      if(result=="-1" || result=="-2" || result=="-3"){
                                        ScaffoldMessenger.of(context).showSnackBar(snackbarIncorrectCredentials);
                                      }
                                      else{
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MainScreen()));
                                      }
                                    });



                                  }

                                }
                              },
                              child: Center(
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontSize: 2.h,
                                    fontWeight: FontWeight.w800,
                                    //decoration: TextDecoration.overline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Forgot Password? ",
                            style: TextStyle(fontSize: 1.9.h)),
                        GestureDetector(
                          child: Text("Get help logging in",
                              style: TextStyle(
                                  fontSize: 1.9.h,
                                  color: Theme.of(context).focusColor,
                                  decoration: TextDecoration.underline)),
                          onTap: () {
                            print('Navigate to Forgot Password');
                            /*
                            setState(() {
                              Navigator.pop(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            });
                              */
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 25.h),
                    Container(
                      height: 5.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white60,
                          // temp placement for border and bgcolor
                          //top: BorderSide(height: 10.h, color: Colors.pinkAccent.withOpacity(0.5), width: 50.w),
                        ),
                        color: Colors.white30.withOpacity(0.2),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("New to the app? ",
                              style: TextStyle(fontSize: 1.9.h)),
                          GestureDetector(
                            child: Text("Sign up",
                                style: TextStyle(
                                    fontSize: 1.9.h,
                                    color: Theme.of(context).focusColor,
                                    decoration: TextDecoration.underline)),
                            onTap: () {
                              setState(() {
                                print('Navigate to Sign Up');
                                Navigator.pop(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BasicInfo()));
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    //Positioned(child: null,)
                    //SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
