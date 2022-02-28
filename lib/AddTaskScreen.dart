//import 'dart:ffi';
import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentui/HomeScreen.dart';

import 'LoginRegister/LoginServices/student_services.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //
  int class_link=-1;
  Future<void> getClass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? classlink = prefs.getInt("class_link");
    if (classlink != null) {
      setState(() {
        class_link = classlink;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClass();

  }

  GlobalKey<FormState> _SectionSignupFormKey = GlobalKey<FormState>();
  TextEditingController _task_name = new TextEditingController();
  TextEditingController _task_desc = new TextEditingController();


  DateTime initialDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  final DateFormat dateFormatter = DateFormat.yMMMMEEEEd();
  final DateFormat dateFormatter2=DateFormat('yyyy-MM-dd');
  handleDatePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (date != null && date != initialDate) {
      setState(() {
        initialDate = date;
      });
      dateController.text = dateFormatter2.format(date);
    }
  }

  bool validateForm() {
    if (_SectionSignupFormKey.currentState!.validate()) {
      return true;
    } else
      return false;
  }


  final subjectNames = [
    "Select Subject",
    "Subject 1",
    "Subject 2",
    "Subject 3",
    "Subject 4",
    "Subject 5",
    "Subject 6"
  ];
  String currentSubject = "Select Subject";

  Widget createButton(Size size) {
    return SizedBox(
      height: 56,
      width: size.width * 0.5,
      child: ElevatedButton(
        //backgroundColor: Theme.of(context).buttonColor,
          onPressed: () {
            if (validateForm()) {
              Services.addTask(_task_name.text,_task_desc.text,dateController.text,class_link.toString())
                  .then((result) {
                if (result == "success") {
                  print("inserted successfully");
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                }
                else {
                  print("error");
                }
              });
            }
          },

          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            primary: Theme.of(context).focusColor),

        child: Text("+ Create Task",
            style: TextStyle(fontSize: size.height * 0.025)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isKeyboard = MediaQuery.of(context).viewInsets.bottom == 0;
    print(isKeyboard);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          top: true,
          child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              children: [
                Container(
                  width: size.width * 0.95,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Create New Task",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline1!
                              .copyWith(fontSize: size.height * 0.04),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              size: size.height * 0.04,
                            )),
                      ]),
                ),
                Expanded(
                    child: Container(
                  width: size.width * 0.98,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      )),
                  child: getTaskDetails(size),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTaskDetails(Size size) {
    TextStyle dropStyle =
        TextStyle(color: Colors.grey, fontSize: size.height * 0.02);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: size.height * 0.025),
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Form(
          key: _SectionSignupFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  width: size.width,
                  child: Text(
                    "Task Name",
                    style: TextStyle(
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                  controller: _task_name,
                  style: TextStyle(fontSize: size.height * 0.02),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter Task/Assignment Name",
                    prefixIcon: Icon(Icons.note_alt_rounded),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.blue)),
                  )),
              SizedBox(height: size.height * 0.02),
              Container(
                  width: size.width,
                  child: Text(
                    "Subject",
                    style: TextStyle(
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(height: size.height * 0.01),
              FormField(builder: (FormFieldState<String> state) {
                return InputDecorator(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0)),
                    ),
                    isEmpty: currentSubject == "",
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        style: dropStyle,
                        onTap: () {
                          dropStyle = dropStyle.copyWith(color: Colors.black);
                        },
                        dropdownColor: Colors.white,
                        value: currentSubject,
                        isDense: true,
                        onChanged: (newValue) {
                          setState(() {
                            currentSubject = newValue.toString();
                            dropStyle = dropStyle.copyWith(color: Colors.grey);
                          });
                        },
                        items: subjectNames
                            .map((String item) => DropdownMenuItem<String>(
                                child: Text(item), value: item))
                            .toList(),
                      ),
                    ));
              }),
              SizedBox(height: size.height * 0.02),
              Container(
                  width: size.width,
                  child: Text(
                    "Task Description",
                    style: TextStyle(
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                  controller: _task_desc,
                  style: TextStyle(fontSize: size.height * 0.02),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter Task/Assignment Description",
                    prefixIcon: Icon(Icons.article_rounded),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.blue)),
                  )),
              SizedBox(height: size.height * 0.02),
              Container(
                  width: size.width,
                  child: Text(
                    "Date/Time of Submission",
                    style: TextStyle(
                        fontSize: size.height * 0.025,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )),
              SizedBox(height: size.height * 0.01),
              TextFormField(
                controller: dateController,
                  style: TextStyle(fontSize: size.height * 0.02),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Enter Task/Assignment Date",
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.grey, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.blue)),
                  ),
                  onTap: handleDatePicker),
              SizedBox(height: size.height * 0.18),
              createButton(size)
            ],
          ),
        ),
      ),
    );
  }
}
