import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:college_dept_portals/DepartmentDashboard/CreateClub.dart';

class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  int _control = 16;
  String fontFam = '';

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
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
            margin: EdgeInsets.symmetric(horizontal: s.width * 0.2),
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
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: s.width * 0.2,
                                    child: Text("Club Name",
                                        style: TextStyle(
                                            fontSize: s.height * 0.02,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Inter')),
                                  ),
                                  FloatingActionButton(
                                    backgroundColor: Colors.blue[400],
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => CreateClub(),
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
                    return newClubTile(s, index);
                  }),
            ),
          ),
        ),
      ],
    );
  }

  Widget newClubTile(Size s, int index) {
    return Container(
      height: s.height * 0.08,
      color: (index % 2 == 0) ? Colors.white : Colors.lightBlue[50],
      child: Container(
        color: Colors.transparent,
        //margin: EdgeInsets.symmetric(horizontal: s.width * 0.02),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                constraints: BoxConstraints(maxWidth: s.width * 0.15),
                width: s.width * 0.15,
                child: Text("*CLUB NAME*",
                    style: TextStyle(
                        fontSize: s.height * 0.018,
                        fontWeight: FontWeight.normal,
                        fontFamily: fontFam)),
              ),
              Row(
                children: [
                  IconButton(
                      iconSize: s.height * 0.028,
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Colors.black,
                      )),
                  SizedBox(width: s.width * 0.025),
                  IconButton(
                      iconSize: s.height * 0.028,
                      onPressed: () {},
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
