import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DetailedAnnouncement extends StatelessWidget {
  final int count;
  DetailedAnnouncement({Key? key, required this.count}) : super(key: key);

  String fontFam = '';
  DateTime now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Container(
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.black,
                      size: s.height * 0.03,
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'announcement-details' + count.toString(),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "AnnouncementTitle",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: fontFam,
                            fontSize: s.height * 0.047,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: s.height * 0.01),
                    child: Text(
                      "Posted on " + DateFormat.yMMMMd().format(now),
                      style: TextStyle(
                          fontFamily: fontFam,
                          fontSize: s.height * 0.015,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: s.height * 0.01),
                width: s.width,
                child: SingleChildScrollView(
                  child: Text(
                    "Announcement Description + images if required ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: fontFam,
                        fontSize: s.height * 0.02,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
