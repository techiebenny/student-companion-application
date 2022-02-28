import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:studentui/BottomNavBarScreen.dart';
import 'package:studentui/LoginRegister/LoginScreen.dart';

import 'LoginServices/student_services.dart';

class ClassCode extends StatefulWidget {
  const ClassCode({Key? key}) : super(key: key);

  @override
  _ClassCodeState createState() => _ClassCodeState();
}

class _ClassCodeState extends State<ClassCode> {
  TextEditingController _signup_classcode = new TextEditingController();
  final snackbarIncorrectCredentials = new SnackBar(content: Text("enter valid credentials"));
  final snackbarSuccessfullSignup=new SnackBar(content: Text("Successfully Signed up"));
  String email="a";
  String password="a";
  String name="a";
  String id="a";

  GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  bool validateSignupForm() {
    if (_signupFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? _email = prefs.getString("studentemail");
    String? _password = prefs.getString("studentpassword");
    String? _name = prefs.getString("studentname");
    String? _id = prefs.getString("studentid");
    if (_email != null) {
      setState(() {
        email = _email;
      });
    }
    if (_password != null) {
      setState(() {
        password = _password;
      });
    }
    if (_name != null) {
      setState(() {
        name = _name;
      });
    }
    if (_id != null) {
      setState(() {
        id = _id;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPref();
  }




  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniStartTop,
            resizeToAvoidBottomInset: true,
            body: Container(
                child: SafeArea(
                    top: true,
                    child: Column(children: [
                      Container(
                          padding: EdgeInsets.symmetric(vertical: 3.h),
                          child: Image.asset(
                            "assets/ClassCode.png",
                            scale: 1.5.h,
                          )),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              "Finally, enter the class code to join your class!",
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 2.h,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Form(
                          key:_signupFormKey,
                          child: Column(
                            children: [
                              Container(
                                width: 100.w,
                                padding:
                                    EdgeInsets.only(left: 0.5.w, bottom: 0.5.h),
                                child: Text(
                                  "Class Code:",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 2.h,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Inter'),
                                ),
                              ),
                              TextFormField(
                                controller: _signup_classcode,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("This is a required field");
                                    } else {
                                      return null;
                                    }
                                  },
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 1.7.h, fontFamily: 'Inter'),
                                  decoration: InputDecoration(
                                    alignLabelWithHint: false,
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "Class Code",
                                    prefixIcon: Icon(Icons.qr_code_rounded),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide:
                                            BorderSide(color: Colors.blue)),
                                  )),
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: 1.5.h, top: 1.5.h),
                                child: ElevatedButton(
                                    onPressed:()
                                    {
                                      if(validateSignupForm())
                                      {
                                        Services.addStudent(email,password,name, id, _signup_classcode.text).then((result) {
                                          if(result=="success") {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                                snackbarSuccessfullSignup);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen()));
                                          }
                                        });

                                        // Navigator.of(context).pop();

                                      }
                                      else
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(snackbarIncorrectCredentials);
                                      }
                                    },
                                    // onPressed: () {
                                    //   //Push the Second Page to gather college specific information
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               MainScreen()));
                                    // },
                                    child: Text("Next",
                                        style: TextStyle(fontSize: 2.5.h)),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0XFF509537),
                                        fixedSize: Size(90.w, 6.h))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ])))),
      );
    });
  }
}
