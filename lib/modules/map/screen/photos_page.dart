import 'package:student_app/modules/map/widget/photo_page/photos_gridview.dart';
import 'package:flutter/material.dart';

class PhotosViewPage extends StatelessWidget {
  const PhotosViewPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhotoGridView();
  }
}
