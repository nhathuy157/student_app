import 'package:flutter/material.dart';
import 'package:student_app/service/size_screen.dart';

class BuildPhoto extends StatefulWidget {
  String urlImage;
  BuildPhoto({Key? key, required this.urlImage}) : super(key: key);

  @override
  State<BuildPhoto> createState() => _BuildPhotoState();
}

class _BuildPhotoState extends State<BuildPhoto> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child:

          //  Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          // children: [
          ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          widget.urlImage,
          width: SizeScreen.sizeSpace * 22,
          height: SizeScreen.sizeSpace * 22,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
