import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:studentui/AnnouncementsTab/AnnouncementDetails.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

  @override
  _AnnouncementScreenState createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  int postNumber = 16;

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
                width: s.width,
                height: s.height * 0.1,
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
                          padding:
                              EdgeInsets.symmetric(vertical: s.height * 0.025),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailedAnnouncement(count: index)));
                            },
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat.MMMd().format(now)),
                                Text(DateFormat.y().format(now)),
                              ],
                            ),
                            minLeadingWidth: s.width * 0.05,
                            title: Hero(
                              tag: 'announcement-details' + index.toString(),
                              child: Text(
                                "AnnouncementTitle",
                                style: TextStyle(
                                    fontFamily: fontFam,
                                    fontWeight: FontWeight.bold,
                                    fontSize: s.height * 0.027,
                                    color: Colors.black,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            subtitle: ReadMoreText(
                              "Announcement Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium accumsan nulla sit amet scelerisque. In hac habitasse platea dictumst. Vivamus tincidunt urna dictum magna congue, posuere ullamcorper arcu blandit. Aenean ultrices sem vel risus consectetur, vitae commodo turpis tempor. Mauris nec volutpat nulla. Sed ullamcorper elementum tempor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin volutpat elit non nisi dapibus, sed efficitur libero tincidunt. Ut quis lacus ipsum. Nam pellentesque laoreet nisi, a ultricies lacus varius id. Phasellus ultricies euismod malesuada. Quisque imperdiet lorem volutpat odio porttitor, nec accumsan est laoreet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer fermentum dui tellus. Curabitur nec magna molestie, sollicitudin nisl eget, pharetra orci. Ut ornare sodales mauris, quis rutrum felis pellentesque non. Morbi vitae neque tellus. Mauris scelerisque gravida diam ut vehicula. Phasellus vitae posuere quam. Morbi at diam gravida, gravida turpis tempus, auctor libero. Integer quis augue vitae erat blandit ultrices. Ut id porttitor erat. Nunc mattis ornare dui in scelerisque. Cras mollis ut dui ut ultricies. Aliquam sagittis placerat turpis vel euismod. Nulla sed odio vel velit vulputate faucibus. Ut neque arcu, consectetur vel dictum vel, vestibulum vel nisi. Nunc lacinia nec lectus sit amet lacinia. Donec congue dapibus consequat. Phasellus condimentum non tortor a eleifend. Etiam maximus molestie velit, at accumsan velit condimentum eu. Praesent ut commodo augue, vitae convallis odio. Integer scelerisque diam nec purus volutpat, ultricies efficitur tellus faucibus. Pellentesque massa sapien, elementum eu metus at, elementum lacinia nunc.",
                              style: TextStyle(
                                  fontFamily: fontFam,
                                  fontWeight: FontWeight.normal,
                                  fontSize: s.height * 0.017),
                              colorClickableText: Colors.green,
                              trimLength: 120,
                            ),
                          ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
