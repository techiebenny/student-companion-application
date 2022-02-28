import 'package:flutter/material.dart';
import 'LoginRegister/LoginServices/Tasks.dart';

class TaskDetails extends StatelessWidget {
  final int index;
  final Tasks t;
  const TaskDetails({Key? key, required this.index, required this.t})
      : super(key: key);

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
    String taskTag = "Task Title" + index.toString();
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
                      Icons.arrow_back_rounded,
                      color: Colors.black,
                      size: size.height * 0.035,
                    )),
              ),
              SizedBox(height: size.height * 0.025),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.005),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Due ",
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: Hero(
                        flightShuttleBuilder: _flightShuttleBuilder,
                        tag: taskTag,
                        child: Text(
                          t.name!,
                          style: TextStyle(
                            fontSize: size.height * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: size.height * 0.05),
                      width: size.width,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        t.description!,
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
