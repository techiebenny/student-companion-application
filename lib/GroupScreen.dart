//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGroup extends StatefulWidget {
  const MyGroup({Key? key}) : super(key: key);

  @override
  _MyGroupState createState() => _MyGroupState();
}

class _MyGroupState extends State<MyGroup> {
  int groupCount = 10;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).focusColor,
        child: Icon(
          Icons.group_add_rounded,
          size: size.width * 0.065,
        ),
        onPressed: null,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            //SizedBox(height: (size.height) * 0.044),
            Container(
              padding: EdgeInsets.symmetric(horizontal: (size.width) * 0.033),
              alignment: Alignment.centerLeft,
              //constraints: BoxConstraints(maxHeight: (size.height) * 0.073),
              child: Text(
                "My Groups",
                style: Theme.of(context)
                    .primaryTextTheme
                    .headline1!
                    .copyWith(fontSize: size.height * 0.06),
              ),
            ),
            SizedBox(height: (size.height) * 0.01),
            Expanded(
              child: Container(
                //height: size.height * 0.7946,
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: groupCount,
                      itemBuilder: (BuildContext context, int index) {
                        return groupsList(index, size);
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget groupsList(int index, Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: Card(
        child: ListTile(
          leading: Image.asset(
            'assets/groupDefault.png',
            height: size.height * 0.1,
            width: size.width * 0.1,
            fit: BoxFit.contain,
          ),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          title: Text(
            "Group Name",
            style: TextStyle(
                fontSize: size.height * 0.024, fontWeight: FontWeight.w500),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          onTap: () {
            print("Open Group Details");
          },
        ),
      ),
    );
  }
}
