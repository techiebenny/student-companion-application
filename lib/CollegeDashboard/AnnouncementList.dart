import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:college_dept_portals/CollegeDashboard/CreateAnnouncement.dart';

class AnnouncementList extends StatefulWidget {
  const AnnouncementList({Key? key}) : super(key: key);

  @override
  _AnnouncementListState createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  int postNumber = 16;
  bool postVisiblity = false;
  String fontFam = '';
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              postVisiblity = false;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: s.width * 0.02),
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: s.width,
                  height: s.height * 0.15,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  alignment: Alignment.center,
                  child: Text(
                    "Announcements",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: s.height * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: postNumber,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: s.width * 0.2),
                            padding: EdgeInsets.symmetric(
                                vertical: s.height * 0.025),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  postVisiblity = true;
                                });
                              },
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(DateFormat.MMMd().format(now)),
                                  Text(DateFormat.y().format(now)),
                                ],
                              ),
                              minLeadingWidth: s.width * 0.05,
                              title: Text(
                                "Announcement Title",
                                style: TextStyle(
                                    fontFamily: fontFam,
                                    fontWeight: FontWeight.bold,
                                    fontSize: s.height * 0.02),
                              ),
                              subtitle: ReadMoreText(
                                "Announcement Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium accumsan nulla sit amet scelerisque. In hac habitasse platea dictumst. Vivamus tincidunt urna dictum magna congue, posuere ullamcorper arcu blandit. Aenean ultrices sem vel risus consectetur, vitae commodo turpis tempor. Mauris nec volutpat nulla. Sed ullamcorper elementum tempor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin volutpat elit non nisi dapibus, sed efficitur libero tincidunt. Ut quis lacus ipsum. Nam pellentesque laoreet nisi, a ultricies lacus varius id. Phasellus ultricies euismod malesuada. Quisque imperdiet lorem volutpat odio porttitor, nec accumsan est laoreet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer fermentum dui tellus. Curabitur nec magna molestie, sollicitudin nisl eget, pharetra orci. Ut ornare sodales mauris, quis rutrum felis pellentesque non. Morbi vitae neque tellus. Mauris scelerisque gravida diam ut vehicula. Phasellus vitae posuere quam. Morbi at diam gravida, gravida turpis tempus, auctor libero. Integer quis augue vitae erat blandit ultrices. Ut id porttitor erat. Nunc mattis ornare dui in scelerisque. Cras mollis ut dui ut ultricies. Aliquam sagittis placerat turpis vel euismod. Nulla sed odio vel velit vulputate faucibus. Ut neque arcu, consectetur vel dictum vel, vestibulum vel nisi. Nunc lacinia nec lectus sit amet lacinia. Donec congue dapibus consequat. Phasellus condimentum non tortor a eleifend. Etiam maximus molestie velit, at accumsan velit condimentum eu. Praesent ut commodo augue, vitae convallis odio. Integer scelerisque diam nec purus volutpat, ultricies efficitur tellus faucibus. Pellentesque massa sapien, elementum eu metus at, elementum lacinia nunc.",
                                style: TextStyle(
                                    fontFamily: fontFam,
                                    fontWeight: FontWeight.normal,
                                    fontSize: s.height * 0.015),
                                colorClickableText: Colors.green,
                              ),
                            ));
                      }),
                )
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: s.height * 0.02),
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewAnnouncement(),
                ),
              );
            },
            child: Icon(
              Icons.add,
              size: s.height * 0.025,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Visibility(
              visible: postVisiblity,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: s.width * 0.2, vertical: s.height * 0.05),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(blurRadius: 50, color: Colors.black54)
                      ]),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: s.height * 0.05, horizontal: s.width * 0.05),
                    //color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "Announcement Title",
                                    style: TextStyle(
                                        fontFamily: fontFam,
                                        fontSize: s.height * 0.05,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: s.height * 0.01),
                                  child: Text(
                                    "Posted on " +
                                        DateFormat.yMMMMd().format(now),
                                    style: TextStyle(
                                        fontFamily: fontFam,
                                        fontSize: s.height * 0.015,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      postVisiblity = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: Colors.black,
                                    size: s.height * 0.03,
                                  )),
                            )
                          ],
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: s.height * 0.01),
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
              )),
        ),
      ],
    );
  }
}
