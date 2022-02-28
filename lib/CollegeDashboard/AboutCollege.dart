import 'dart:ui';
import 'package:flutter/material.dart';

class AboutCollege extends StatefulWidget {
  const AboutCollege({Key? key}) : super(key: key);

  @override
  _AboutCollegeState createState() => _AboutCollegeState();
}

class _AboutCollegeState extends State<AboutCollege> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    if (s.width < 1180 || s.height < 938) {
      s = Size(1180, 938);
    }
    TextSpan text = TextSpan(
        text:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean pretium accumsan nulla sit amet scelerisque. In hac habitasse platea dictumst. Vivamus tincidunt urna dictum magna congue, posuere ullamcorper arcu blandit. Aenean ultrices sem vel risus consectetur, vitae commodo turpis tempor. Mauris nec volutpat nulla. Sed ullamcorper elementum tempor. Interdum et malesuada fames ac ante ipsum primis in faucibus. Proin volutpat elit non nisi dapibus, sed efficitur libero tincidunt. Ut quis lacus ipsum. Nam pellentesque laoreet nisi, a ultricies lacus varius id. Phasellus ultricies euismod malesuada. Quisque imperdiet lorem volutpat odio porttitor, nec accumsan est laoreet. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Integer fermentum dui tellus. Curabitur nec magna molestie, sollicitudin nisl eget, pharetra orci. Ut ornare sodales mauris, quis rutrum felis pellentesque non. Morbi vitae neque tellus. Mauris scelerisque gravida diam ut vehicula. Phasellus vitae posuere quam. Morbi at diam gravida, gravida turpis tempus, auctor libero. Integer quis augue vitae erat blandit ultrices. Ut id porttitor erat. Nunc mattis ornare dui in scelerisque. Cras mollis ut dui ut ultricies. Aliquam sagittis placerat turpis vel euismod. Nulla sed odio vel velit vulputate faucibus. Ut neque arcu, consectetur vel dictum vel, vestibulum vel nisi. Nunc lacinia nec lectus sit amet lacinia. Donec congue dapibus consequat. Phasellus condimentum non tortor a eleifend. Etiam maximus molestie velit, at accumsan velit condimentum eu. Praesent ut commodo augue, vitae convallis odio. Integer scelerisque diam nec purus volutpat, ultricies efficitur tellus faucibus. Pellentesque massa sapien, elementum eu metus at, elementum lacinia nunc.");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          focusColor: Colors.white,
          alignment: Alignment.topCenter,
          icon: Icon(Icons.arrow_back_rounded, size: s.height * 0.03),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/collegeBG.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                    height: s.height,
                    margin: EdgeInsets.symmetric(horizontal: s.width * 0.2),
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: s.width * 0.01,
                          vertical: s.height * 0.03),
                      //color: Colors.black,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      height: s.height * 0.1,
                                      width: s.width * 0.1,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/collegeBG.jpg'))),
                                    ),
                                    Container(
                                      child: Text(
                                        '*COLLEGE NAME*',
                                        style: TextStyle(
                                            fontSize: s.height * 0.02,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: s.height * 0.15,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      child: Text(
                                        '*ADMINISTRATOR NAME*',
                                        style: TextStyle(
                                            fontSize: s.height * 0.018),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        'name@exammple.com',
                                        style: TextStyle(
                                            fontSize: s.height * 0.015),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text("EDIT PROFILE",
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: s.height * 0.015)),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green[300]),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: s.height * 0.1),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: s.width * 0.05),
                            child: Text.rich(
                              text,
                              style: TextStyle(fontSize: s.height * 0.02),
                            ),
                          )
                        ],
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
