import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:student_app/DB/services_college.dart';
import 'package:student_app/screens/rootadmin/root_dashboard.dart';
import 'package:student_app/widgets/RootContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootLoginForm extends StatefulWidget {
  @override
  _RootLoginFormState createState() => _RootLoginFormState();
}

class _RootLoginFormState extends State<RootLoginForm> {
  TextEditingController _signin_email = new TextEditingController();

  TextEditingController _signin_password = new TextEditingController();

  final snackbarIncorrectCredentials =
      new SnackBar(content: Text("enter valid credentials"));

  GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();

  bool validateSigninForm() {
    if (_signinFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  bool obscure = true;
  String fontFam = 'Inter';

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    Color inputFill = Color(0XFFffffff);
    print(s.width);
    return Expanded(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: RootContainer(
          child: SingleChildScrollView(
            child: Form(
              key: _signinFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(
                        vertical: s.height * 0.01, horizontal: 0.0),
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: s.height * 0.03,
                          fontWeight: FontWeight.w100,
                          fontFamily: fontFam),
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.005,
                  ),
                  SizedBox(
                    height: s.height * 0.02,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: s.height * 0.015,
                          fontWeight: FontWeight.normal,
                          fontFamily: fontFam),
                    ),
                  ),
                  SizedBox(height: s.height * 0.01),
                  Container(
                    child: TextFormField(
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
                      style: TextStyle(
                          fontSize: s.height * 0.015,
                          color: Colors.black,
                          fontFamily: fontFam),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: inputFill,
                        hintText: "Email Address",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0),
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      controller: _signin_email,
                    ),
                  ),
                  SizedBox(height: s.height * 0.03),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: s.height * 0.015,
                          fontWeight: FontWeight.normal,
                          fontFamily: fontFam),
                    ),
                  ),
                  SizedBox(
                    height: s.height * 0.01,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("This is a required field");
                      } else {
                        return null;
                      }
                    },
                    style: TextStyle(
                        fontSize: s.height * 0.015,
                        color: Colors.black,
                        fontFamily: fontFam),
                    obscureText: obscure,
                    controller: _signin_password,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: inputFill,
                      suffixIcon: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Icon(Icons.remove_red_eye_rounded),
                          onTap: () {
                            setState(() {
                              obscure = !obscure;
                              print(obscure);
                            });
                          },
                        ),
                      ),
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 0.0)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                  SizedBox(height: s.height * 0.025),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            child: MouseRegion(
                                cursor: SystemMouseCursors.text,
                                child: GestureDetector(
                                    onTap: () {
                                      print("Click on credentials");
                                    },
                                    child: Text("Testing Credentials \n Email : root@gmail.com \n Password : root",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: s.height * 0.015,
                                            fontWeight: FontWeight.normal,
                                            decoration:
                                                TextDecoration.underline,
                                            fontFamily: fontFam))))),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.08,
                          height: MediaQuery.of(context).size.width * 0.03,
                          child: ElevatedButton(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: s.height * 0.015,
                                  fontFamily: fontFam),
                            ),
                            style: ElevatedButton.styleFrom(primary: Colors.green[400]),
                            onPressed: ()async
                            //TODO: password check(done)
                            {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if(validateSigninForm())
                              {
                                Services.checkLogin(_signin_email.text,_signin_password.text).then((result){
                                  if(result=='success')
                                  {
                                    prefs.setString("email",_signin_email.text);
                                    prefs.setBool("signedin", true);
                                    Navigator.of(context).pop();

                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context)=>RootDashboard(),
                                      ),
                                    );
                                    //Navigator.of(context).pushNamed("/home");
                                  }
                                  else
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(snackbarIncorrectCredentials);
                                  }
                                });
                              }
                            },
                          ),
                        )
                      ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
