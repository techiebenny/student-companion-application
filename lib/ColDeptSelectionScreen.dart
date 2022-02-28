import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:college_dept_portals/CollegeDashboard/CollegeDashboard.dart';
import 'package:college_dept_portals/DbServices/services_college.dart'
    as clg_service;
import 'package:college_dept_portals/DbServices/services_db.dart'
    as dept_service;
import 'package:shared_preferences/shared_preferences.dart';

import 'DepartmentDashboard/DepartmentDashboard.dart';

class ColDeptSelectionScreen extends StatefulWidget {
  const ColDeptSelectionScreen({Key? key}) : super(key: key);

  @override
  _ColDeptSelectionScreenState createState() => _ColDeptSelectionScreenState();
}

class _ColDeptSelectionScreenState extends State<ColDeptSelectionScreen>
    with TickerProviderStateMixin {
  String fontFam = 'Inter';
  bool obscure = true;
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    Size size = MediaQuery.of(context).size;
    print(size.width);
    tabController.animateTo(tabIndex);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Container(
              //margin: EdgeInsets.symmetric(horizontal: size.width * 0.39),
              child: TabBar(
                onTap: (int index) {
                  setState(() {
                    tabIndex = index;
                  });
                },
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: (tabIndex == 0) ? Colors.white : Colors.black,
                tabs: [
                  Container(
                    child: Text(
                      "College Dashboard",
                      style: TextStyle(
                          fontSize: size.height * 0.02, fontFamily: fontFam),
                    ),
                  ),
                  Container(
                    child: Text(
                      "Department Dashboard",
                      style: TextStyle(
                          fontSize: size.height * 0.02, fontFamily: fontFam),
                    ),
                  )
                ],
                controller: tabController,
              ),
            ),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: TabBarView(
            children: [collegeLogin(size), departmentLogin(size)],
            controller: tabController,
          )),
    );
  }

  Widget collegeLogin(Size size) {
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

    return Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/collegeBG.jpg',
              alignment: Alignment.center,
              fit: BoxFit.fill,
            )),
        Positioned(
          top: size.height * 0.08,
          left: size.width * 0.02,
          right: (size.width <= 780) ? size.width * 0.02 : null,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              height: size.height * 0.9,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/collegeFormBG.png'),
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        spreadRadius: 0.0,
                        blurRadius: 1000)
                  ],
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(7.0)),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.25,
                    horizontal: MediaQuery.of(context).size.width * 0.04),
                alignment: Alignment.center,
                //color: Colors.black,
                child: Form(
                  key: _signinFormKey,
                  child: Column(
                    children: [
                      Container(
                          //height: MediaQuery.of(context).size.height * 0.1,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: fontFam,
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal,
                              fontFamily: fontFam),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Container(
                        child: TextFormField(
                          controller: _signin_email,
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
                              fontSize: size.height * 0.015,
                              color: Colors.black,
                              fontFamily: fontFam),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Email Address",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide:
                                    BorderSide(color: Colors.greenAccent)),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal,
                              fontFamily: fontFam),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      TextFormField(
                        controller: _signin_password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("This is a required field");
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                            fontSize: size.height * 0.015,
                            color: Colors.black,
                            fontFamily: fontFam),
                        obscureText: obscure,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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
                              borderSide:
                                  BorderSide(color: Colors.greenAccent)),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: MouseRegion(
                                    cursor: SystemMouseCursors.text,
                                    child: GestureDetector(
                                        onTap: () {
                                          print("Click on Forgot Password");
                                        },
                                        child: Text(
                                            "For Prototype Testing\nUsername : rit@gmail.com\nPassword : rit",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: size.height * 0.015,
                                                fontWeight: FontWeight.normal,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontFamily: fontFam))))),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: ElevatedButton(
                                // onPressed: () {
                                //   //check for login details
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) =>
                                //               CollegeDashboard()));
                                // },
                                onPressed: () async
                                    //TODO: password check(done)
                                    {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (validateSigninForm()) {
                                    clg_service.Services.checkLogin(
                                            _signin_email.text,
                                            _signin_password.text)
                                        .then((result) {
                                      print(result);
                                      if (result > 0) {
                                        prefs.setString(
                                            "collegeemail", _signin_email.text);
                                        prefs.setBool("collegesignedin", true);
                                        prefs.setInt("collegelink", result);
                                        Navigator.of(context).pop();

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CollegeDashboard(),
                                          ),
                                        );
                                        //Navigator.of(context).pushNamed("/home");
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                snackbarIncorrectCredentials);
                                      }
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green[400]),
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.015,
                                      fontFamily: fontFam),
                                ),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget departmentLogin(Size size) {
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

    return Stack(
      children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Image.asset(
              'assets/departmentBG.jpg',
              alignment: Alignment.center,
              fit: BoxFit.fill,
            )),
        Positioned(
          top: size.height * 0.08,
          right: size.width * 0.02,
          left: (size.width <= 780) ? size.width * 0.02 : null,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              height: size.height * 0.9,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/departmentFormBG.png'),
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain),
                  color: Colors.blue[50],
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        spreadRadius: 0.0,
                        blurRadius: 1000)
                  ],
                  borderRadius: BorderRadius.circular(7.0)),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * 0.25,
                    horizontal: MediaQuery.of(context).size.width * 0.04),
                //color: Colors.black,
                child: Form(
                  key: _signinFormKey,
                  child: Column(
                    children: [
                      Container(
                          //height: MediaQuery.of(context).size.height * 0.1,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontFamily: fontFam,
                                fontSize: size.height * 0.03,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal,
                              fontFamily: fontFam),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Container(
                        child: TextFormField(
                          controller: _signin_email,
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
                              fontSize: size.height * 0.015,
                              color: Colors.black,
                              fontFamily: fontFam),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Email Address",
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.0)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(7.0),
                                borderSide:
                                    BorderSide(color: Colors.blueAccent)),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.015,
                              fontWeight: FontWeight.normal,
                              fontFamily: fontFam),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      TextFormField(
                        controller: _signin_password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("This is a required field");
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                            fontSize: size.height * 0.015,
                            color: Colors.black,
                            fontFamily: fontFam),
                        obscureText: obscure,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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
                              borderSide: BorderSide(color: Colors.blueAccent)),
                        ),
                      ),
                      SizedBox(height: size.height * 0.025),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                child: MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: GestureDetector(
                                        onTap: () {
                                          print("Click on Forgot Password");
                                        },
                                        child: Text(
                                            "For Prototype Testing\nUsername :  iseadmin@gmail.com\nPassword : password",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: size.height * 0.015,
                                                fontWeight: FontWeight.normal,
                                                decoration:
                                                    TextDecoration.underline,
                                                fontFamily: fontFam))))),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: ElevatedButton(
                                // onPressed: () {
                                //   Navigator.of(context).push(
                                //             MaterialPageRoute(
                                //               builder: (context)=>DepartmentDashboard(),
                                //             ),
                                //             );
                                // },
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (validateSigninForm()) {
                                    dept_service.Services.checkLogin(
                                            _signin_email.text,
                                            _signin_password.text)
                                        .then((result) {
                                      if (result > 0) {
                                        prefs.setString(
                                            "deptemail", _signin_email.text);
                                        prefs.setBool("deptsignedin", true);
                                        prefs.setInt("departmentlink", result);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DepartmentDashboard(),
                                          ),
                                        );
                                        //Navigator.of(context).pushNamed("/home");
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                                snackbarIncorrectCredentials);
                                      }
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.blue[400]),
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.height * 0.015,
                                      fontFamily: fontFam),
                                ),
                              ),
                            )
                          ])
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
