import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:demoji/demoji.dart';
import 'package:sizer/sizer.dart';
//import 'package:studentui/BottomNavBarScreen.dart';
import 'package:studentui/LoginRegister/ClassCode.dart';

class CollegeInfo extends StatefulWidget {
  const CollegeInfo({Key? key}) : super(key: key);

  @override
  _CollegeInfoState createState() => _CollegeInfoState();
}

class _CollegeInfoState extends State<CollegeInfo> {

  TextEditingController _signup_name = new TextEditingController();
  TextEditingController _signup_id = new TextEditingController();
  final snackbarIncorrectCredentials = new SnackBar(content: Text("enter valid credentials"));

  GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  bool validateSignupForm() {
    if (_signupFormKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      Container(child: Image.asset("assets/Building.png")),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 0.5.h),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "College Details:",
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
                              "To proceed, we need some details to help your college identify you.",
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
                                    "Name",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter'),
                                  ),
                                ),
                                TextFormField(
                                    controller: _signup_name,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("This is a required field");
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(
                                        fontSize: 1.7.h, fontFamily: 'Inter'),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "Name",
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
                                    "University Seat Number",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 2.h,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Inter'),
                                  ),
                                ),
                                TextFormField(
                                    controller: _signup_id,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("This is a required field");
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(
                                        fontSize: 1.7.h, fontFamily: 'Inter'),
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: "USN",
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
                              ],
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.only(bottom: 1.5.h, top: 1.5.h),
                        child: ElevatedButton(
                            onPressed:()async
                            {
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              if(validateSignupForm())
                              {
                                prefs.setString("studentname",_signup_name.text);
                                prefs.setString("studentid",_signup_id.text);
                                // Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClassCode()));
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
                            //           builder: (context) => ClassCode()));
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
