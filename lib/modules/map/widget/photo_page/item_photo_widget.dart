import 'package:flutter/material.dart';
import 'package:student_app/widgets/stateless/image_found.dart';

class PhotoItem extends StatelessWidget {
  final String urlPhoto;

  const PhotoItem(this.urlPhoto);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ImageNotFound(
        imageLink: urlPhoto,
        boxFit: BoxFit.cover,
      ),
    );
  }
}
