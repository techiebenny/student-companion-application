import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:demoji/demoji.dart';
import 'package:sizer/sizer.dart';
import 'package:studentui/LoginRegister/CollegeInfo.dart';

class BasicInfo extends StatefulWidget {
  const BasicInfo({Key? key}) : super(key: key);

  @override
  _BasicInfoState createState() => _BasicInfoState();
}

bool obscure = true;
bool validLogin = true;
bool validPassword = true;

class _BasicInfoState extends State<BasicInfo> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _signup_email = new TextEditingController();
    TextEditingController _signup_password = new TextEditingController();
    final snackbarIncorrectCredentials = new SnackBar(content: Text("enter valid credentials"));

    GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
    bool validateSignupForm() {
      if (_signupFormKey.currentState!.validate()) {
        return true;
      } else {
        return false;
      }
    }



    return Sizer(
      builder: (context, orientation, deviceType) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            //backgroundColor: Color(0XFFf8f8f8),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniStartTop,
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              child: Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                    //image: DecorationImage(
                    //    image: AssetImage("assets/BG1.gif"),
                    //    fit: BoxFit.contain,
                    //    alignment: Alignment.topCenter),
                    color: Colors.lightBlue[100]),
                child: SafeArea(
                  top: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(child: Image.asset("assets/Saly-13.png")),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 1.h),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Let's get you signed up!",
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 3.h,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 2.h),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            child: Text(
                              "We just need some basic information to get you started.",
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
                            key: _signupFormKey,
                            child: Column(
                              children: [
                                Container(
                                  width: 100.w,
                                  padding: EdgeInsets.only(
                                      left: 0.5.w, bottom: 0.5.h),
                                  child: Text(
                                    "Email",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter'),
                                  ),
                                ),
                                TextFormField(
                                    controller: _signup_email,
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
                                        fontSize: 1.7.h, fontFamily: 'Inter'),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "yourid@example.com",
                                      prefixIcon: Icon(Icons.email_rounded),
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
                                  width: 100.w,
                                  padding: EdgeInsets.only(
                                      left: 0.5.w, bottom: 0.5.h, top: 1.h),
                                  child: Text(
                                    "Password",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter'),
                                  ),
                                ),
                                TextFormField(
                                  controller: _signup_password,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("This is a required field");
                                    } else {
                                      return null;
                                    }
                                  },
                                  style: TextStyle(
                                      fontSize: 1.7.h, fontFamily: 'Inter'),
                                  obscureText: obscure,
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefixIcon: Icon(Icons.vpn_key),
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
                                      hintText: "Your password here",
                                      suffixIcon: GestureDetector(
                                        child:
                                            Icon(Icons.remove_red_eye_outlined),
                                        onTap: () {
                                          setState(() {
                                            obscure = !obscure;
                                          });
                                        },
                                      )),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 0.5.h, bottom: 1.h),
                                  child: Visibility(
                                      visible: !validPassword,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.info_outline,
                                              color: Colors.red),
                                          Text(
                                              "  Please Enter a Valid Password",
                                              style:
                                                  TextStyle(color: Colors.red))
                                        ],
                                      )),
                                )
                              ],
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(bottom: 1.5.h),
                        child: ElevatedButton(
                            onPressed:()async
                                {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    if(validateSignupForm())
                                    {
                                      prefs.setString("studentemail",_signup_email.text);
                                      prefs.setString("studentpassword",_signup_password.text);
                                      // Navigator.of(context).pop();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CollegeInfo()));
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
                            //           builder: (context) => CollegeInfo()));
                            // },
                            child:
                                Text("Next", style: TextStyle(fontSize: 2.5.h)),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0XFF509537),
                                fixedSize: Size(90.w, 6.h))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
