//import 'dart:html';
//import 'package:student_app/widgets/RootContainer.dart';

import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:student_app/screens/rootadmin/root_dashboard.dart';
import 'package:student_app/DB/services_college.dart';
import 'package:image_picker/image_picker.dart';

import 'imgpick.dart';

class NewCollege extends StatefulWidget {
  @override
  _NewCollegeState createState() => _NewCollegeState();
}

class _NewCollegeState extends State<NewCollege> {
  TextEditingController _signup_email = new TextEditingController();
  TextEditingController _college_name = new TextEditingController();
  TextEditingController _bio = new TextEditingController();
  GlobalKey<FormState> _CollegeSignupFormKey = GlobalKey<FormState>();

  bool validateForm() {
    if (_CollegeSignupFormKey.currentState!.validate()) {
      return true;
    } else
      return false;
  }

  String fontFam = '';

  final ImagePicker _picker = new ImagePicker();

  File? _image;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width <= 1100 || size.height <= 938) {
      size = Size(1100, 938);
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: size.height * 0.08,
            backgroundColor: Colors.white,
            shadowColor: Colors.blue[200],
            title: Text(
              "Create New College",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: size.height * 0.03,
                  color: Colors.black),
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_outlined),
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/svg.png'), fit: BoxFit.fill)),
            child: Center(
              child: Container(
                height: size.height * 0.88,
                width: size.width * 0.5,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.blueGrey,
                                spreadRadius: 0,
                                blurRadius: 100)
                          ]),
                      //margin: EdgeInsets.symmetric(
                      //    horizontal: size.width * 0.25,
                      //    vertical: size.height * 0.02),
                      child: SingleChildScrollView(
                        child: Container(
                          decoration: BoxDecoration(color: Colors.transparent),
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05),
                          child: Form(
                              key: _CollegeSignupFormKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "College Name",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700],
                                            fontFamily: fontFam,
                                            fontSize: size.height * 0.015),
                                      )),
                                  Container(
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required Field";
                                          } else
                                            return null;
                                        },
                                        controller: _college_name,
                                        style: TextStyle(
                                            fontSize: size.height * 0.015,
                                            color: Colors.black,
                                            fontFamily: fontFam),
                                        decoration: InputDecoration(
                                          hintText: "College Name",
                                          fillColor: Colors.lightBlue[100]!
                                              .withOpacity(0.1),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 0.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                        )),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "About The College",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[700],
                                          fontFamily: fontFam,
                                          fontSize: size.height * 0.015,
                                        ),
                                      )),
                                  Container(
                                    child: TextFormField(
                                        style: TextStyle(
                                            fontSize: size.height * 0.015,
                                            color: Colors.black,
                                            fontFamily: fontFam),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required Field";
                                          } else
                                            return null;
                                        },
                                        controller: _bio,
                                        decoration: InputDecoration(
                                          hintText: "Bio",
                                          fillColor: Colors.lightBlue[100]!
                                              .withOpacity(0.1),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 0.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                        )),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Administrator",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[700],
                                          fontFamily: fontFam,
                                          fontSize: size.height * 0.015,
                                        ),
                                      )),
                                  Container(
                                    child: TextFormField(
                                        controller: _signup_email,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Required Field";
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
                                          hintText: "name@example.com",
                                          fillColor: Colors.lightBlue[100]!
                                              .withOpacity(0.1),
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.lightBlueAccent,
                                                  width: 0.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                        )),
                                  ),
                                  SizedBox(height: size.height * 0.001),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "*This will be used to give administrator access*",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey,
                                          fontFamily: fontFam,
                                          fontSize: size.height * 0.01,
                                        ),
                                      )),
                                  Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Picture",
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey[700],
                                            fontFamily: fontFam,
                                            fontSize: size.height * 0.015),
                                      )),
                                  GestureDetector(
                                    onTap: () async {
                                      final PickedImage =
                                          await _picker.pickImage(
                                              source: ImageSource.gallery);
                                      if (PickedImage != null) {
                                        setState(() {
                                          _image = File(PickedImage.path);
                                        });
                                      } else {
                                        print("No image selected");
                                      }
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color: Colors.lightBlue[100]!
                                                .withOpacity(0.1),
                                            border: Border.all(
                                                color: Colors.lightBlueAccent,
                                                width: 0.0),
                                            borderRadius:
                                                BorderRadius.circular(7.0)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: size.width * 0.008),
                                                child: Text(
                                                  "Upload an image to  ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey[500],
                                                      fontFamily: fontFam,
                                                      fontSize:
                                                          size.height * 0.015),
                                                )),
                                            Imagepick(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.05),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                            height: size.height * 0.06,
                                            width: size.width * 0.08,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        RootDashboard(),
                                                  ),
                                                );
                                              },
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Text("Discard",
                                                    style: TextStyle(
                                                        color: Colors.red[400],
                                                        fontSize:
                                                            size.height * 0.025,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.white,
                                                  shadowColor: Colors.black,
                                                  side: BorderSide(
                                                      color: Colors.red[400]!)),
                                            )),
                                        SizedBox(width: size.width * 0.01),
                                        Container(
                                            height: size.height * 0.06,
                                            width: size.width * 0.08,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                if (validateForm()) {
                                                  Services.addCollege(
                                                          _college_name.text,
                                                          _signup_email.text,
                                                          _bio.text)
                                                      .then((result) {
                                                    if (result == "success") {
                                                      print(
                                                          "correct credentials");
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              RootDashboard(),
                                                        ),
                                                      );
                                                    } else {
                                                      print("error");
                                                    }
                                                  });
                                                }
                                              },
                                              child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: Text("Create",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            size.height * 0.025,
                                                        fontFamily: 'Inter',
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue[400],
                                                  shadowColor: Colors.black),
                                            ))
                                      ]),
                                ],
                              )),
                        ),
                      )),
                ),
              ),
            ),
          )),
    );
  }
}
