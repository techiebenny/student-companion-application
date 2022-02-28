import 'package:flutter/material.dart';

class RootContainer extends StatelessWidget {
  final Widget? child;

  const RootContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: s.width * 0.05),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0XFF0196ff),
          //Color(0XFF0032fe),
          Color(0XFF006bff)
        ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        color: Color(0XFF0032FE),
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
              color: Colors.transparent,
              blurRadius: 1000.0,
              spreadRadius: 0.0,
              offset: Offset(4.0, 4.0))
        ],
      ),
      child: child,
    );
  }
}
