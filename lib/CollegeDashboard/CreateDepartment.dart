import 'dart:ui';
import 'package:college_dept_portals/CollegeDashboard/CollegeDashboard.dart';
import 'package:college_dept_portals/DbServices/services_db.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewDepartment extends StatefulWidget {
  const NewDepartment({Key? key}) : super(key: key);

  @override
  _NewDepartmentState createState() => _NewDepartmentState();
}

class _NewDepartmentState extends State<NewDepartment> {
  String fontFam = '';

  TextEditingController _dept_name = new TextEditingController();
  TextEditingController _offno = new TextEditingController();
  TextEditingController _userid = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  GlobalKey<FormState> _DeptSignupFormKey = GlobalKey<FormState>();

  int clg_link=-1;

  Future<void> getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? clglink = prefs.getInt("collegelink");
    if (clglink != null) {
      setState(() {
        clg_link = clglink;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPref();
  }



  bool validateForm() {
    if (_DeptSignupFormKey.currentState!.validate()) {
      return true;
    } else
      return false;
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    print(s);
    if (s.width <= 1180 || s.height <= 938) {
      s = Size(1180, 938);
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 938, minWidth: 1180),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_rounded, size: s.height * 0.03),
              onPressed: () => Navigator.pop(context),
              color: Colors.black,
            ),
            title: Text(
              "Create New Department",
              style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: s.height * 0.03,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/collegeFormBG.png'),
                    fit: BoxFit.cover)),
            child: Center(
              child: Container(
                height: s.height * 0.88,
                width: s.width * 0.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 10)],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                //margin: EdgeInsets.symmetric(
                //    vertical: s.height * 0.05, horizontal: s.width * 0.25),
                //constraints: BoxConstraints(maxWidth: 1180, maxHeight: 938),
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 0, horizontal: s.width * 0.05),
                    child: Form(
                      key: _DeptSignupFormKey,
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding:
                                EdgeInsets.symmetric(vertical: s.height * 0.01),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Department Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[700],
                                  fontFamily: fontFam,
                                  fontSize: s.height * 0.015),
                            )),
                        Container(
                          child: TextFormField(
                            controller: _dept_name,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required Field";
                                } else
                                  return null;
                              },
                              style: TextStyle(
                                  fontSize: s.height * 0.015,
                                  color: Colors.black,
                                  fontFamily: fontFam),
                              decoration: InputDecoration(
                                hintText: "Department Name",
                                fillColor:
                                    Colors.lightGreen[100]!.withOpacity(0.1),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        color: Colors.lightGreenAccent,
                                        width: 0.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(color: Colors.blue)),
                              )),
                        ),
                        SizedBox(height: s.height * 0.02),
                        Container(
                            padding:
                                EdgeInsets.symmetric(vertical: s.height * 0.01),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Office Number",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                                fontFamily: fontFam,
                                fontSize: s.height * 0.015,
                              ),
                            )),
                        Container(
                          child: TextFormField(
                            controller:_offno,
                              style: TextStyle(
                                  fontSize: s.height * 0.015,
                                  color: Colors.black,
                                  fontFamily: fontFam),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Required Field";
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Office Number",
                                fillColor:
                                    Colors.lightGreen[100]!.withOpacity(0.1),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        color: Colors.lightGreenAccent,
                                        width: 0.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(color: Colors.blue)),
                              )),
                        ),
                        SizedBox(height: s.height * 0.02),
                        Container(
                            padding:
                                EdgeInsets.symmetric(vertical: s.height * 0.01),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Administrator Email",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                                fontFamily: fontFam,
                                fontSize: s.height * 0.015,
                              ),
                            )),
                        Container(
                          child: TextFormField(
                            controller: _userid,
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
                                  fontSize: s.height * 0.015,
                                  color: Colors.black,
                                  fontFamily: fontFam),
                              decoration: InputDecoration(
                                hintText: "name@example.com",
                                fillColor:
                                    Colors.lightGreen[100]!.withOpacity(0.1),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        color: Colors.lightGreenAccent,
                                        width: 0.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(color: Colors.blue)),
                              )),
                        ),
                        SizedBox(height: s.height * 0.001),
                        Container(
                            padding:
                                EdgeInsets.symmetric(vertical: s.height * 0.01),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "*This will be used to give administrator access*",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontFamily: fontFam,
                                fontSize: s.height * 0.01,
                              ),
                            )),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: s.height * 0.01),
                          alignment: Alignment.centerLeft,
                          child: Text("Password",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                                fontFamily: fontFam,
                                fontSize: s.height * 0.015,
                              )),
                        ),
                        Container(
                          child: TextFormField(
                            controller: _password,
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: s.height * 0.015,
                                  color: Colors.black,
                                  fontFamily: fontFam),
                              decoration: InputDecoration(
                                hintText: "Password",
                                fillColor:
                                    Colors.lightGreen[100]!.withOpacity(0.1),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        color: Colors.lightGreenAccent,
                                        width: 0.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(color: Colors.blue)),
                              )),
                        ),
                        SizedBox(height: s.height * 0.05),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                  height: s.height * 0.05,
                                  width: s.width * 0.06,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CollegeDashboard(),
                                        ),
                                      );
                                    },
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Text("Discard",
                                          style: TextStyle(
                                              color: Colors.red[400],
                                              fontSize: s.height * 0.02,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shadowColor: Colors.black,
                                        side: BorderSide(color: Colors.red)),
                                  )),
                              SizedBox(width: s.width * 0.01),
                              Container(
                                  height: s.height * 0.05,
                                  width: s.width * 0.06,
                                  child: ElevatedButton(
                                    onPressed: () {
                                        if (validateForm()) {
                                        Services.addDepartment(clg_link,_dept_name.text,_offno.text,_userid.text,_password.text)
                                            .then((result) {
                                                if (result == "success") {
                                                  print("correct credentials");
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(builder: (context) => CollegeDashboard(),),
                                                      );
                                                }
                                                else {
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
                                              fontSize: s.height * 0.02,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.green[400],
                                        shadowColor: Colors.black),
                                  ))
                            ]),
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
