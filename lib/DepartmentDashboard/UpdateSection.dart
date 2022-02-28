import 'package:college_dept_portals/DbServices/class_db.dart';
import 'package:college_dept_portals/DbServices/services_class.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:college_dept_portals/DepartmentDashboard/DepartmentDashboard.dart';

TextEditingController _dept_link = new TextEditingController();
TextEditingController _sectionid = new TextEditingController();
TextEditingController _section_name = new TextEditingController();
TextEditingController _section_batch_join= new TextEditingController();
TextEditingController _section_class_code= new TextEditingController();
GlobalKey<FormState> _UpdateSectionFormKey = GlobalKey<FormState>();
class UpdateSection extends StatefulWidget {
  //const UpdateSection({Key? key}) : super(key: key);



  UpdateSection(Student_class d) {
    _dept_link.text=d.dept_link!.toString();
    _sectionid.text=d.section_id!.toString();
    _section_name.text=d.section_name!;
    _section_batch_join.text=d.section_batch_join!;
    _section_class_code.text=d.section_classcode!;
  }

  @override
  _UpdateSectionState createState() => _UpdateSectionState();
}

class _UpdateSectionState extends State<UpdateSection> {
  String fontFam = '';
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();
  String code = 'Click Generate to generate club code.';
  Color codeColor = Colors.grey;
  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  bool validateForm() {
    if (_UpdateSectionFormKey.currentState!.validate()) {
      return true;
    } else
      return false;
  }

  bool? updateData() {
    //TODO:make update passwords a separate service
    Services.updateSection(int.parse(_sectionid.text),_section_name.text,_section_batch_join.text)
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
              "Update Section",
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
                    image: AssetImage('assets/departmentFormBG.png'),
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
                      key:_UpdateSectionFormKey,
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding:
                                EdgeInsets.symmetric(vertical: s.height * 0.01),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Section Name",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[700],
                                  fontFamily: fontFam,
                                  fontSize: s.height * 0.015),
                            )),
                        Container(
                          child: TextFormField(
                            controller:_section_name,
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
                                hintText: "Section Name",
                                fillColor:
                                    Colors.lightBlue[100]!.withOpacity(0.1),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
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
                              "Batch Year",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                                fontFamily: fontFam,
                                fontSize: s.height * 0.015,
                              ),
                            )),
                        Container(
                          child: TextFormField(
                            controller: _section_batch_join,
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
                                hintText: "Batch Year",
                                fillColor:
                                    Colors.lightBlue[100]!.withOpacity(0.1),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(
                                        color: Colors.lightBlueAccent,
                                        width: 0.0)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(7.0),
                                    borderSide: BorderSide(color: Colors.blue)),
                              )),
                        ),
                        SizedBox(height: s.height * 0.02),
                        // Container(
                        //     padding:
                        //         EdgeInsets.symmetric(vertical: s.height * 0.01),
                        //     alignment: Alignment.centerLeft,
                        //     child: Text(
                        //       "Class Code",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.normal,
                        //         color: Colors.grey[700],
                        //         fontFamily: fontFam,
                        //         fontSize: s.height * 0.015,
                        //       ),
                        //     )),
                        SizedBox(height: s.height * 0.01),
                        // Container(
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: s.width * 0.01),
                        //   height: s.height * 0.05,
                        //   decoration: BoxDecoration(
                        //       color: Colors.lightBlue[100]!.withOpacity(0.1),
                        //       borderRadius: BorderRadius.circular(7.0),
                        //       border: Border.all(
                        //           color: Colors.lightBlueAccent, width: 0.0),
                        //       shape: BoxShape.rectangle),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       SelectableText(
                        //         code,
                        //         style: TextStyle(color: codeColor),
                        //       ),
                        //       ElevatedButton(
                        //         onPressed: () {
                        //           setState(() {
                        //             code = getRandomString(5);
                        //             codeColor = Colors.black;
                        //           });
                        //         },
                        //         child: FittedBox(
                        //           fit: BoxFit.cover,
                        //           child: Text(
                        //             "Generate Code",
                        //             style: TextStyle(
                        //               fontSize: s.height * 0.018,
                        //             ),
                        //           ),
                        //         ),
                        //         style: ElevatedButton.styleFrom(
                        //             primary: Colors.blue,
                        //             fixedSize: Size(s.width * 0.08, s.height)),
                        //       )
                        //     ],
                        //   ),
                        // ),
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
                                              DepartmentDashboard(),
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
                                                DepartmentDashboard(),
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
                                        primary: Colors.blue[400],
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
