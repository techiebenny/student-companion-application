import 'dart:io';
import 'dart:ui';
import 'package:college_dept_portals/DepartmentDashboard/DepartmentDashboard.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewAnnouncement extends StatefulWidget {
  const NewAnnouncement({Key? key}) : super(key: key);

  @override
  _NewAnnouncementState createState() => _NewAnnouncementState();
}

class _NewAnnouncementState extends State<NewAnnouncement> {
  String fontFam = '';

  final ImagePicker _picker = new ImagePicker();
  File? _image;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (s.width < 1180 || s.height < 938) {
      s = Size(1180, 938);
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded, size: s.height * 0.03),
            onPressed: () => Navigator.pop(context),
            color: Colors.black,
          ),
          title: Text(
            "Create New Announcement",
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
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 0, horizontal: s.width * 0.05),
                  child: Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding:
                              EdgeInsets.symmetric(vertical: s.height * 0.01),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Announcement Title",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                                fontFamily: fontFam,
                                fontSize: s.height * 0.015),
                          )),
                      Container(
                        child: TextFormField(
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
                              hintText: "Title",
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
                            "Announcement Description",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[700],
                              fontFamily: fontFam,
                              fontSize: s.height * 0.015,
                            ),
                          )),
                      Container(
                        child: TextFormField(
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
                              hintText: "Description",
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
                            "Picture",
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[700],
                                fontFamily: fontFam,
                                fontSize: s.height * 0.015),
                          )),
                      GestureDetector(
                        onTap: () async {
                          final pickedImage = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (pickedImage != null) {
                            setState(() {
                              _image = File(pickedImage.path);
                            });
                          } else {
                            print("No image selected");
                          }
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue[100]!.withOpacity(0.1),
                                border: Border.all(
                                    color: Colors.lightBlueAccent, width: 0.0),
                                borderRadius: BorderRadius.circular(7.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    padding:
                                        EdgeInsets.only(left: s.width * 0.008),
                                    child: Text(
                                      "Upload an image to  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[500],
                                          fontFamily: fontFam,
                                          fontSize: s.height * 0.015),
                                    )),
                                imagepick(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: s.height * 0.05),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(
                            height: s.height * 0.05,
                            width: s.width * 0.06,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DepartmentDashboard(),
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
                              onPressed: () {},
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Text("Create",
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
    );
  }

  Widget imagepick() {
    Future getGallerySelectedImg() async {
      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      } else {
        print("No image selected");
      }
    }

    return Container(
      //margin: EdgeInsets.symmetric(
      //    horizontal: MediaQuery.of(context).size.width * 0.15),
      height: MediaQuery.of(context).size.height * 0.05,

      //ternary decision
      child: _image == null
          ? ElevatedButton(
              child: FittedBox(
                fit: BoxFit.cover,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.file_upload_outlined),
                  Text("  Upload Image "),
                ]),
              ),
              onPressed: getGallerySelectedImg,
              style: ElevatedButton.styleFrom(primary: Colors.blue[400]),
            )
          : Image.file(_image!),
    );
  }
}
