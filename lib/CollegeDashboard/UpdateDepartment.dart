import 'dart:io';
import 'dart:ui';
import 'package:college_dept_portals/DbServices/dept_db.dart';
import 'package:college_dept_portals/DbServices/services_db.dart';
import 'package:image_picker/image_picker.dart';
import 'package:college_dept_portals/CollegeDashboard/CollegeDashboard.dart';
import 'package:flutter/material.dart';


TextEditingController _college_link = new TextEditingController();
TextEditingController _id = new TextEditingController();
TextEditingController _name = new TextEditingController();
TextEditingController _helpno= new TextEditingController();
TextEditingController _userid= new TextEditingController();
TextEditingController _password = new TextEditingController();
GlobalKey<FormState> _DeptFormKey = GlobalKey<FormState>();

class UpdateDepartment extends StatefulWidget {
  // const UpdateDepartment({Key? key}) : super(key: key);
  UpdateDepartment(Department d) {
    _college_link.text=d.college_link!.toString();
    _id.text=d.id!.toString();
    _name.text=d.name!;
    _helpno.text=d.helpno!;
    _userid.text=d.userid!;
    // _password.text=d.password!;
  }
  @override
  _UpdateDepartmentState createState() => _UpdateDepartmentState();
}

class _UpdateDepartmentState extends State<UpdateDepartment> {
  String fontFam = '';

  bool validateForm() {
    if (_DeptFormKey.currentState!.validate()) {
      return true;
    } else
      return false;
  }

  bool? updateData() {
    //TODO:make update passwords a separate service
    Services.updateDepartment(_helpno.text, _password.text, int.parse(_id.text))
        .then((result) {
      if (result == "success") {
        return true;
      } else
        return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (s.width < 1180 || s.height < 938) {
      s = Size(1180, 938);
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, size: s.height * 0.03),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
          title: Text(
            "Update Department",
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
                  fit: BoxFit.fill)),
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
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 0, horizontal: s.width * 0.05),
                  child: Form(
                    key: _DeptFormKey,
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
                          controller: _name,
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
                          controller: _helpno,
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
                        child: Text("Update Password",
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
                      SizedBox(height: s.height * 0.001),
                      Container(
                          padding:
                              EdgeInsets.symmetric(vertical: s.height * 0.01),
                          alignment: Alignment.centerLeft,
                          child: Text("*leave blank if not required*",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                                fontFamily: fontFam,
                                fontSize: s.height * 0.01,
                              ))),
                      SizedBox(height: s.height * 0.05),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(
                            height: s.height * 0.05,
                            width: s.width * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => CollegeDashboard(),
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
                                  updateData();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CollegeDashboard(),
                                    ),
                                  );
                                }
                              },
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text("Update",
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
    );
  }
}
