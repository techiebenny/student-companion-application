import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:college_dept_portals/DepartmentDashboard/ClassList.dart';
import 'package:college_dept_portals/DepartmentDashboard/AnnouncementList.dart';
import 'package:college_dept_portals/DepartmentDashboard/GroupList.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentDashboard extends StatefulWidget {
  const DepartmentDashboard({Key? key}) : super(key: key);

  @override
  _DepartmentDashboardState createState() => _DepartmentDashboardState();
}

class _DepartmentDashboardState extends State<DepartmentDashboard>
    with TickerProviderStateMixin {

  int postNumber = 16;
  String fontFam = '';
  DateTime now = DateTime.now();
  int tabIndex = 0;
  String navbar_login_details='a@email.com';

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);
    tabController.animateTo(tabIndex);
    Size s = MediaQuery.of(context).size;
    if (s.width < 1180 || s.height < 938) {
      s = Size(1180, 938);
    }
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: s.height * 0.08,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, size: s.height * 0.03),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        title: Text(
          "Department Dashboard",
          style: TextStyle(
              fontFamily: 'Inter',
              fontSize: s.height * 0.03,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.info_outline_rounded,
                size: s.height * 0.02, color: Colors.black),
            label: Text('DEPARTMENT NAME',
                style: TextStyle(
                    fontSize: s.height * 0.016,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
          ),
          SizedBox(
            width: s.width * 0.015,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/departmentFormBG.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                top: s.height * 0.08,
              ),
              //decoration: BoxDecoration(color: Colors.black),
              child: TabBarView(
                controller: tabController,
                children: [ClassList(), AnnouncementList(), GroupList()],
              )),
          Positioned(
            top: s.height * 0.022,
            left: 0,
            right: 0,
            child: Container(
              width: s.width,
              alignment: Alignment.center,
              child: Theme(
                data: ThemeData(hoverColor: Colors.transparent),
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  labelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.green,
                  indicator: UnderlineTabIndicator(
                      borderSide: BorderSide(width: 2, color: Colors.green)),
                  indicatorPadding: EdgeInsets.only(top: 4),
                  tabs: [
                    Container(
                      child: Text(
                        "Class List",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: s.height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Announcements",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: s.height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        "Groups/Clubs",
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: s.height * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
