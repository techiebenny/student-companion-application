// ignore_for_file: camel_case_types
import 'dart:ui';
import 'package:college_dept_portals/CollegeDashboard/UpdateDepartment.dart';
import 'package:college_dept_portals/DbServices/dept_db.dart';
import 'package:college_dept_portals/DbServices/services_db.dart';
import 'package:flutter/material.dart';
import 'package:college_dept_portals/CollegeDashboard/CreateDepartment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class departmentList extends StatefulWidget {
  const departmentList({Key? key}) : super(key: key);

  @override
  _departmentListState createState() => _departmentListState();
}

class _departmentListState extends State<departmentList> {
  int _control = 1;
  String fontFam = '';
  Department? dpt;
  List<Department> _departments=[];
  var len = 0;

  int clglink=-1;

  Future<void> getSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? clg_link = prefs.getInt("collegelink");
    if (clg_link != null) {
      setState(() {
        clglink = clg_link;
      });

    }
  }


  void _updateDepartment(Department d) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateDepartment(d),
      ),
    );
  }

  void _deleteDepartment(int? id) {
    Services.deleteDepartment(id).then((value) {
      if (value == "success") {
        print("executed");
        _getDepartments();
      } else {
        //TODO:pass php error back to the user in all services functions
        print("failed");
      }
    });
  }

  void _getDepartments() {
    print("from get dept function");
    print(clglink);
    Services.getDepartments(clglink).then((result) {
      print("services get dept");
      print(result.length);
      setState(() {
        if (result.length != 0) {
          _departments = result;
          // _control=_colleges.length+1;
          _control = _departments.length + 1;
        } else {
          _departments = [];
          _control = 1;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPref().whenComplete(() {
      _getDepartments();
    });


  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (s.width < 1180 || s.height < 938) {
      s = Size(1180, 938);
    }
    return Column(
      children: [
        SizedBox(height: s.height * 0.04),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.blueGrey, spreadRadius: 0, blurRadius: 1)
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: s.width * 0.02),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: s.height * 0.018),
              child: ListView.builder(
                  physics: ClampingScrollPhysics(),
                  itemCount: _control,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: s.width * 0.02),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: s.width * 0.16,
                                    child: Text("Department Name",
                                        style: TextStyle(
                                            fontSize: s.height * 0.02,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter')),
                                  ),
                                  Text("Admin Email",
                                      style: TextStyle(
                                          fontSize: s.height * 0.02,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Inter')),
                                  FloatingActionButton(
                                    backgroundColor: Colors.green,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => NewDepartment(),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: s.height * 0.025,
                                      color: Colors.white,
                                    ),
                                  )
                                ]),
                          ),
                          SizedBox(height: s.height * 0.018),
                          Container(
                            width: s.width,
                            height: 1.5,
                            color: Colors.blueGrey[200],
                          )
                        ],
                      );
                    }
                    else {
                      return newDepartmentTile(
                          s, index, _departments.elementAt(index - 1));
                    }
                  }),
            ),
          ),
        ),
      ],
    );
  }

  Widget newDepartmentTile(Size s, int index,Department d) {
    return Container(
      height: s.height * 0.08,
      color: (index % 2 == 0) ? Colors.white : Colors.greenAccent[100],
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: s.width * 0.02),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: s.width * 0.225,
                constraints: BoxConstraints(maxWidth: s.width * 0.225),
                //color: Colors.black,
                child: Text(d.name!,
                    style: TextStyle(
                        fontSize: s.height * 0.018,
                        fontWeight: FontWeight.normal,
                        fontFamily: fontFam)),
              ),
              Text(d.userid!,
                  style: TextStyle(
                      fontSize: s.height * 0.018,
                      fontWeight: FontWeight.normal,
                      fontFamily: fontFam)),
              Row(
                children: [
                  IconButton(
                      iconSize: s.height * 0.028,
                      onPressed: () {
                        _updateDepartment(d);
                      },
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Colors.black,
                      )),
                  SizedBox(width: s.width * 0.025),
                  IconButton(
                      iconSize: s.height * 0.028,
                      onPressed: () {
                        _deleteDepartment(d.id!);
                      },
                      icon: Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red[400],
                      ))
                ],
              )
            ]),
      ),
    );
  }
}
