//import 'dart:html';
import 'package:flutter/gestures.dart';
import 'package:student_app/DB/college_db.dart';
import 'package:student_app/DB/services_college.dart';
import 'package:student_app/screens/rootadmin/new_college.dart';
import 'package:student_app/screens/rootadmin/update_college.dart';
import 'package:student_app/widgets/RootContainer.dart';
import 'package:flutter/material.dart';
import 'package:student_app/utils/newtheme.dart';
import '../../utils/newtheme.dart';

//newly added imports
import 'build_college_tile.dart';

class RootDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RootDashboardState();
  }
}

class _RootDashboardState extends State<RootDashboard> {
  int _control = 0;
  String fontFam = '';
  College? clg;
  List<College> _colleges = [];
  var len = 0;

  void _updateCollege(College c) {
    //Navigator.of(context).pop();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UpdateCollege(c),
      ),
    );
  }

  void _deleteCollege(int? id) {
    Services.deleteCollege(id).then((value) {
      if (value == "success") {
        print("executed");
        _getCollege();
      } else {
        //TODO:pass php error back to the user in all services functions
        print("failed");
      }
    });
  }

  void _getCollege() {
    Services.getCollege().then((result) {
      setState(() {
        if (result.length != 0) {
          _colleges = result;
          // _control=_colleges.length+1;
          _control = _colleges.length + 1;
        } else {
          _colleges = [];
          _control = 1;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCollege();
  }

  @override
  Widget newCollegeTile(Size s, int index, College c) {
    return Container(
      height: s.height * 0.08,
      color: (index % 2 == 0) ? Colors.white : Colors.lightBlue[50],
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: s.width * 0.02),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: s.width * 0.2,
            constraints: BoxConstraints(maxWidth: s.width * 0.2),
            child: Text(c.name!,
                style: TextStyle(
                    fontSize: s.height * 0.018,
                    fontWeight: FontWeight.normal,
                    fontFamily: fontFam)),
          ),
          Container(
            width: s.width * 0.2,
            constraints: BoxConstraints(maxWidth: s.width * 0.2),
            alignment: Alignment.centerLeft,
            child: Text(c.userid!,
                style: TextStyle(
                    fontSize: s.height * 0.018,
                    fontWeight: FontWeight.normal,
                    fontFamily: fontFam)),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            IconButton(
                iconSize: s.height * 0.028,
                onPressed: () {
                  // edit icon
                  _updateCollege(c);
                },
                icon: Icon(
                  Icons.edit_rounded,
                  color: Colors.black,
                )),
            SizedBox(width: s.width * 0.025),
            IconButton(
                iconSize: s.height * 0.028,
                onPressed: () {
                  //delete icon
                  _deleteCollege(c.id);
                },
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red[400],
                ))
          ])
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // College col = new College(1234, "colg", "abt", "userid", "password");
    Size s = MediaQuery.of(context).size;
    if (s.width <= 1100 || s.height <= 938) {
      s = Size(1100, 938);
    }
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: s.height * 0.08,
          backgroundColor: Colors.white,
          shadowColor: Colors.blue[200],
          title: Text(
            "College List",
            style: TextStyle(
                fontFamily: 'Inter',
                fontSize: s.height * 0.03,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            Container(
              alignment: Alignment.center,
              child: Text('John Doe',
                  style: TextStyle(
                      fontSize: s.height * 0.016,
                      fontWeight: FontWeight.normal,
                      color: Colors.black)),
            ),
            SizedBox(width: s.width * 0.01),
            Icon(Icons.person, size: s.height * 0.05, color: Colors.black)
          ]),
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/rootDashboardBG.png'),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: s.height * 0.02),
              width: s.width * 0.95,
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewCollege(),
                    ),
                  );
                },
                child: Icon(
                  Icons.add,
                  size: s.height * 0.03,
                  color: Colors.blue,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.blueGrey,
                          spreadRadius: 0,
                          blurRadius: 1)
                    ]),
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
                                          width: s.width * 0.19,
                                          child: Text("College Name",
                                              style: TextStyle(
                                                  fontSize: s.height * 0.02,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter')),
                                        ),
                                        Container(
                                          width: s.width * 0.2,
                                          alignment: Alignment.centerLeft,
                                          constraints: BoxConstraints(
                                              maxWidth: s.width * 0.2),
                                          child: Text("Admin Email",
                                              style: TextStyle(
                                                  fontSize: s.height * 0.02,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Inter')),
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.edit_rounded,
                                              color: Colors.transparent,
                                              size: s.height * 0.028,
                                            ),
                                            SizedBox(width: s.width * 0.025),
                                            Icon(
                                              Icons.delete_outline_rounded,
                                              color: Colors.transparent,
                                              size: s.height * 0.028,
                                            )
                                          ],
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

                          return newCollegeTile(
                              s, index, _colleges.elementAt(index - 1));
                        }) //
                    // endof listview builder

                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RootDashboard extends StatelessWidget {
//   int _control = 5;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Root Dashboard'),
//       ),
//       body: Container(
//           margin: EdgeInsets.symmetric(vertical: 15.0),
//           padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
//           child: ListView.builder(
//               physics: BouncingScrollPhysics(),
//               itemCount: _control,
//               itemBuilder: (BuildContext context, int index) {
//                 if (index == 0) {
//                   return Padding(
//                       padding: EdgeInsets.only(left: 10.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                               alignment: Alignment.center,
//                               child: Text(
//                                 'College List',
//                                 style: TextStyle(
//                                   fontSize: 25.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               )),
//                           Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
//                         ],
//                       ));
//                 }
//                 return BuildCollegeTile("College 1");
//               })),
//       floatingActionButton: new FloatingActionButton(
//         backgroundColor: Colors.white,
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => NewCollege(),
//             ),
//           );
//         },
//         child: new Icon(
//           Icons.add_circle_rounded,
//           size: 25.0,
//         ),
//       ),
//     );
//   }
// }

// FutureBuilder(
// future: Services.getCollege(),
// builder: (context,snapshot){
// if(snapshot.hasData){
// // print(snapshot.data.elementAt(0).userid);
// switch (snapshot.connectionState) {
// case ConnectionState.none:
// case ConnectionState.waiting:
// return CircularProgressIndicator();
// // case ConnectionState.active:
// case ConnectionState.done:
// // return Text('${snapshot.data.elementAt(0).userid}');
//
// return ListView.builder(
// physics: ClampingScrollPhysics(),
// itemCount: _control,
// itemBuilder: (BuildContext context, int index) {
// if (index == 0) {
// return Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// //SizedBox(height: s.height * 0.018),
// Row(children: [
// SizedBox(width: s.width * 0.02),
// Text("College Name",
// style: TextStyle(
// fontSize: s.height * 0.02,
// fontWeight: FontWeight.bold,
// fontFamily: 'Inter')),
// SizedBox(width: s.width * 0.3533),
// Text("Admin Email",
// style: TextStyle(
// fontSize: s.height * 0.02,
// fontWeight: FontWeight.bold,
// fontFamily: 'Inter')),
// ]),
// SizedBox(height: s.height * 0.018),
// Container(
// width: s.width,
// height: 1.5,
// color: Colors.blueGrey[200],
// )
// ],
// );
// }
//
// return newCollegeTile(s, index,snapshot.data.elementAt(index-1));
// }); //
// // endof listview builder
// }return null;
// }
//
// else{
// return Center(child: CircularProgressIndicator());
// }
// },
// ),
