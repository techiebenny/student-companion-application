import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagepick extends StatefulWidget {
  @override
  _ImagepickState createState() => _ImagepickState();
}

class _ImagepickState extends State<Imagepick> {
  final ImagePicker _picker = new ImagePicker();
  //XFile image = await _picker.pickImage(source: ImageSource.gallery);
  File? _image;

  @override
  Widget build(BuildContext context) {
    Future getGallerySelectedImg() async {
      final PickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (PickedImage != null) {
        setState(() {
          _image = File(PickedImage.path);
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
              style: ElevatedButton.styleFrom(primary: Colors.blue[600]),
            )
          : Image.file(_image!),
    );
  }
}
