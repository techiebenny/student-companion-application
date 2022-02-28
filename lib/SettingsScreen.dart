//import 'dart:ffi';
import 'dart:io';
import 'package:demoji/demoji.dart';
import 'package:flutter/material.dart';
import 'package:studentui/ProfileEdit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String name = "User";
  final soundList = [
    "Select Sound",
    "Sound 1",
    "Sound 2 ",
  ];
  String currentSound = "Select Sound";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextStyle dropStyle =
        TextStyle(color: Colors.grey, fontSize: size.height * 0.02);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        child: Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Settings",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline1!
                      .copyWith(fontSize: size.height * 0.05),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                width: size.width,
                //margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                child: Text(
                  "Hello, " + name + Demoji.wave,
                  style: TextStyle(fontSize: size.height * 0.04),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "General",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline1!
                      .copyWith(fontSize: size.height * 0.02),
                ),
              ),
              Container(
                //height: size.height * 0.25,
                width: size.width,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(vertical: size.height * 0.01),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Notification Sound",
                          style: TextStyle(fontSize: size.height * 0.02),
                        )),
                    Container(
                      width: size.width,
                      height: size.height * 0.07,
                      child: FormField(builder: (FormFieldState<String> state) {
                        return InputDecorator(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide(
                                      color: Colors.black, width: 2.0)),
                            ),
                            isEmpty: currentSound == "",
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                style: dropStyle,
                                onTap: () {
                                  dropStyle =
                                      dropStyle.copyWith(color: Colors.black);
                                },
                                dropdownColor: Colors.white,
                                value: currentSound,
                                isDense: true,
                                onChanged: (newValue) {
                                  setState(() {
                                    currentSound = newValue.toString();
                                    dropStyle =
                                        dropStyle.copyWith(color: Colors.grey);
                                  });
                                },
                                items: soundList
                                    .map((String item) =>
                                        DropdownMenuItem<String>(
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: size.height * 0.02),
                                            ),
                                            value: item))
                                    .toList(),
                              ),
                            ));
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.025),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: size.height * 0.015),
                child: Text(
                  "Account",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline1!
                      .copyWith(fontSize: size.height * 0.02),
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.05,
                child: TextButton(
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.green, fontSize: 20),
                          children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.edit_rounded,
                          color: Colors.green,
                          size: 20,
                        )),
                        TextSpan(text: "  Edit Profile"),
                      ])),
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileEdit()));
                  },
                ),
              ),
              Container(
                width: size.width,
                height: size.height * 0.05,
                child: TextButton(
                  child: RichText(
                      text: TextSpan(
                          style:
                              TextStyle(color: Colors.redAccent, fontSize: 20),
                          children: [
                        WidgetSpan(
                            child: Icon(
                          Icons.logout_rounded,
                          color: Colors.red,
                        )),
                        TextSpan(text: "  Log Out?"),
                      ])),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      alignment: Alignment.centerLeft,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onPressed: () {
                    print("Log Out current user and exit");
                    exit(0);
                  },
                ),
              ),
              SizedBox(height: size.height * 0.025),
              Container(
                alignment: Alignment.centerLeft,
                //padding: EdgeInsets.only(bottom: size.height * 0.005),
                child: Text(
                  "About",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline1!
                      .copyWith(fontSize: size.height * 0.02),
                ),
              ),
              Container(
                width: size.width,
                child: TextButton(
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onPressed: () {},
                ),
              ),
              Container(
                width: size.width,
                child: TextButton(
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      primary: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0))),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
