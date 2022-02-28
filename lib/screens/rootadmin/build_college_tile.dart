import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:student_app/DB/college_db.dart';
import '../../DB/services_college.dart';
import 'update_college.dart';

class BuildCollegeTile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _BuildCollegeTileState();
  }
}

class _BuildCollegeTileState extends State<BuildCollegeTile> {
  College? clg;
  List<College> _colleges = [];
  Timer? _timer;
  String fontFam = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCollege();
    // EasyLoading.addStatusCallback((status) {
    //   print('EasyLoading Status $status');
    //   if (status == EasyLoadingStatus.dismiss) {
    //     _timer?.cancel();
    //   }
    // });
    //EasyLoading.showSuccess('Use in initState');
  }

  void _updateCollege(College c) {
    Navigator.of(context).pop();
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
        if (result.length != 0)
          _colleges = result;
        else
          _colleges = [];
      });
    });
  }

  void _modalAction(College c) {
    //print(c.name);
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (context) {
          return (Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text("Edit"),
                onTap: () {
                  Navigator.of(context).pop();
                  _updateCollege(c);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text("Delete"),
                onTap: () {
                  Navigator.of(context).pop();
                  _deleteCollege(c.id);
                },
              ),
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return (SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          showBottomBorder: false,
          dividerThickness: 0.0,
          columns: [DataColumn(label: Text(""))],
          rows: _colleges
              .map((clg) => DataRow(cells: [
                    DataCell(
                      Container(
                        width: MediaQuery.of(context).size.width * .875,
                        margin: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 0.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white,
                        ),
                        child: ListTile(
                            //tileColor: Colors.white,
                            contentPadding:
                                EdgeInsets.only(right: 10.0, left: 20.0),
                            title: Text(clg.name.toString()),
                            trailing: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () => _modalAction(clg),
                            )),
                      ),
                    ),
                  ]))
              .toList(),
        ),
      ),
    ));
  }
}
