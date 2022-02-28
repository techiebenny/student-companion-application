import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CreateClass.dart';
import 'package:college_dept_portals/DbServices/class_db.dart';
import 'package:college_dept_portals/DbServices/services_class.dart';

import 'UpdateSection.dart';


class ClassList extends StatefulWidget {
  // const ClassList({Key? key}) : super(key: key);


  @override
  _ClassListState createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {

  int dept_link=-1;

  Future<void> getDepartment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? deptlink = prefs.getInt("departmentlink");
    if (deptlink != null) {
      setState(() {
        dept_link = deptlink;
      });

    }
  }

  int _control = 1;
  String fontFam = '';
  Student_class? section;
  List<Student_class> _sections=[];
  var len = 0;
  // int deptlink=1;

  //helper functions
  void _updateSection(Student_class d) {
    Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateSection(d),
      ),
    );
  }

  void _deleteSection(int? id) {
    Services.deleteSection(id).then((value) {
      if (value == "success") {
        print("executed");
        _getSections();
      } else {
        //TODO:pass php error back to the user in all services functions
        print("failed");
      }
    });
  }

  void _getSections() {
    print("retrieve");
    print(dept_link);
    Services.getSections(dept_link).then((result) {
      setState(() {
        if (result.length != 0) {
          _sections = result;
          // _control=_colleges.length+1;
          _control = _sections.length + 1;
        } else {
          _sections = [];
          _control = 1;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDepartment().whenComplete(() {
      _getSections();
    });

  }

  // end helper functions


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
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.transparent, spreadRadius: 0, blurRadius: 1)
              ],
            ),
            margin: EdgeInsets.symmetric(horizontal: s.width * 0.02),
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                itemCount: _control,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: s.height * 0.01),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.blueAccent)),
                      child: Column(
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
                                    width: s.width * 0.23,
                                    child: Text("Class Name",
                                        style: TextStyle(
                                            fontSize: s.height * 0.02,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter')),
                                  ),
                                  Container(
                                    width: s.width * 0.25,
                                    child: Text("Batch Year",
                                        style: TextStyle(
                                            fontSize: s.height * 0.02,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter')),
                                  ),
                                  Container(
                                    width: s.width * 0.25,
                                    child: Text("Class Code",
                                        style: TextStyle(
                                            fontSize: s.height * 0.02,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter')),
                                  ),
                                  Container(
                                    width: s.width * 0.15,
                                    child: FloatingActionButton(
                                      backgroundColor: Colors.blue[300],
                                      onPressed: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => NewClass(),
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: s.height * 0.025,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    );
                  }else{
                    return newDepartmentTile(s, index,_sections.elementAt(index - 1));
                  }
                }),
          ),
        ),
      ],
    );
  }

  Widget newDepartmentTile(Size s, int index,Student_class d) {
    return Card(
      color: (index % 2 == 0) ? Colors.white : Colors.lightBlue[50],
      child: Container(
        height: s.height * 0.08,
        margin: EdgeInsets.symmetric(horizontal: s.width * 0.02),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: s.width * 0.25,
            //constraints: BoxConstraints(maxWidth: s.width * 0.225),
            child: Text(d.section_name!,
                style: TextStyle(
                    fontSize: s.height * 0.018,
                    fontWeight: FontWeight.normal,
                    fontFamily: fontFam)),
          ),
          Container(
            width: s.width * 0.25,
            child: Text(d.section_batch_join!,
                style: TextStyle(
                    fontSize: s.height * 0.018,
                    fontWeight: FontWeight.normal,
                    fontFamily: fontFam)),
          ),
          Container(
            width: s.width * 0.26,
            child: Text(d.section_classcode!,
                style: TextStyle(
                    fontSize: s.height * 0.018,
                    fontWeight: FontWeight.normal,
                    fontFamily: fontFam)),
          ),
          Container(
            width: s.width * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    iconSize: s.height * 0.028,
                    onPressed: (){
                      _updateSection(d);
                    },
                    icon: Icon(
                      Icons.edit_rounded,
                      color: Colors.black,
                    )),
                SizedBox(width: s.width * 0.025),
                IconButton(
                    iconSize: s.height * 0.028,
                    onPressed: () {
                      _deleteSection(d.section_id!);
                    },
                    icon: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red[400],
                    ))
              ],
            ),
          )
        ]),
      ),
    );
  }
}
