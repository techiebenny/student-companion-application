//import 'package:flutter/cupertino.dart';
import 'dart:html';
import 'package:animated_button_bars/animated_button_bars.dart';
import 'package:flutter/material.dart';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentui/TaskDetails.dart';
import 'AddTaskScreen.dart';
import 'LoginRegister/LoginServices/Tasks.dart';
import 'LoginRegister/LoginServices/student_services.dart';

enum WidgetMarker { tasks, notes }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //

  int class_link = -1;
  List<Tasks> _tasks = [];
  Future<void> getClassLinkSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? sectionlink = prefs.getInt("class_link");
    if (sectionlink != null) {
      setState(() {
        class_link = sectionlink;
      });
    }
  }

  int _control =
      3; //_control is always number of tasks + 1, i.e, if number of tasks is 1, then _control = 2
  int subjectCount = 6;
  WidgetMarker selectedMarker = WidgetMarker.tasks;
  bool value = false;
  TextStyle taskStyle = TextStyle(decoration: null);
  bool isClassRep = true;

  void _getTasks() {
    print("retrieve");
    print(class_link);
    Services.getTasks(class_link).then((result) {
      setState(() {
        print("Res length");
        print(result.length);
        if (result.length != 0) {
          _tasks = result;
          // _control=_colleges.length+1;
          _control = _tasks.length + 1;
        } else {
          _tasks = [];
          _control = 1;
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClassLinkSharedPref().whenComplete(() {
      _getTasks();
    });
  }

  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: toHeroContext.widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Column(
              children: [
                //SizedBox(height: (size.height) * 0.0435),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: (size.width) * 0.033),
                  alignment: Alignment.centerLeft,
                  //constraints: BoxConstraints(maxHeight: (size.height) * 0.073),
                  child: Text(
                    "My Classroom",
                    style: Theme.of(context)
                        .primaryTextTheme
                        .headline1!
                        .copyWith(fontSize: size.height * 0.06),
                  ),
                ),
                SizedBox(height: (size.height) * 0.0122),
                Container(
                  width: size.width * 0.55,
                  child: AnimatedTextBar(
                      currentIndex: 0,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.1),
                      backgroundColor: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      onTap: (int) {
                        setState(() {
                          if (selectedMarker == WidgetMarker.tasks) {
                            selectedMarker = WidgetMarker.notes;
                          } else {
                            selectedMarker = WidgetMarker.tasks;
                          }
                        });
                      },
                      items: [
                        BarItem(
                            label: "Tasks",
                            activeColor: Colors.green[300],
                            iconData: Icons.check_box),
                        BarItem(
                            label: "Notes",
                            activeColor: Colors.green[300],
                            iconData: Icons.note_alt_rounded),
                      ]),
                ),
                SizedBox(height: (size.height) * 0.0149),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: size.width * 0.01),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                      child: getList(size),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget getList(Size size) {
    switch (selectedMarker) {
      case WidgetMarker.tasks:
        return getTaskList(size);
      case WidgetMarker.notes:
        return getNotesList(size);
      default:
        return getTaskList(size);
    }
  }

  Widget getTaskList(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _control,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Container(
                      width: size.width * 0.965,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(children: [
                            Container(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Tasks',
                                style: TextStyle(
                                  fontSize: size.height * 0.034,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 1.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(),
                              child: Text(
                                (_control - 1).toString() + " tasks",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: size.height * 0.017,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic),
                              ),
                            ),
                          ]),
                          //SizedBox(width: size.width * 0.59),
                          Visibility(
                            visible: (isClassRep) ? true : false,
                            child: ElevatedButton.icon(
                              icon: Icon(Icons.add_circle_outline_rounded,
                                  color: Colors.white),
                              label: Text('New Task'),
                              onPressed: () {
                                print("Add Task");
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddTaskScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Theme.of(context).focusColor,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  //fixedSize: size * 0.05,
                                  alignment: Alignment.center),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            } else if (_tasks.length > 0) {
              // print(index);
              return _buildTask(index, _tasks[index - 1]);
            } else {
              return Container();
            }
          }),
    );
  }

  Widget getNotesList(Size size) {
    return Container(
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        height: size.height * 0.7375,
        child: ListView.builder(
            itemCount: subjectCount,
            physics: BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: _buildNotes(index, size));
            }));
  }

  Widget _buildNotes(index, size) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 0.0, bottom: 50.0),
        title: Text(
          "SUBJECT" + (index + 1).toString(),
          style: TextStyle(
              fontSize: size.height * 0.025, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        onTap: () {
          setState(() {
            print("Tapped");
          });
        },
      ),
    );
  }

  Widget _buildTask(int index, Tasks t) {
    String taskTag = "Task Title" + index.toString();
    Size size = MediaQuery.of(context).size;
    return Card(
        child: ListTile(
      onTap: () {
        print("Open Task Details");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TaskDetails(index: index, t: t)));
      },
      contentPadding: EdgeInsets.only(top: 0.0, right: 10.0, left: 10.0),
      title: Hero(
        flightShuttleBuilder: _flightShuttleBuilder,
        tag: taskTag,
        child: Text(
          t.name!,
          style: this.taskStyle.copyWith(
                fontSize: size.height * 0.020,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
        ),
      ),
      subtitle: Text(t.description!,
          style: this.taskStyle.copyWith(fontSize: size.height * 0.017)),
      trailing: Checkbox(
        onChanged: (value) {
          setState(() {
            this.value = value!;
            this.taskStyle = TextStyle(decoration: TextDecoration.lineThrough);
            if (this.value == false) {
              this.taskStyle = TextStyle(decoration: null);
            }
            print(value);
          });
        },
        value: this.value,
      ),
    ));
  }
}
