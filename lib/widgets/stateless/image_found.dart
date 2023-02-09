import 'package:flutter/material.dart';

import '../../constants/assets_part.dart';

class ImageNotFound extends StatelessWidget {
  final String? imageLink;
  final BoxFit boxFit;
  final double? heightImage;
  final double? widthImage;
  const ImageNotFound(
      {Key? key,
      required this.imageLink,
      this.boxFit = BoxFit.fitHeight,
      this.heightImage,
      this.widthImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageLink != '' && imageLink != null) {
      return Image(
        image: NetworkImage(imageLink!),
        errorBuilder: (context, exception, stackTrace) {
          return const Image(
              image: AssetImage(
            ImgAssets.imgNoteFound,
          ));
        },
        fit: boxFit,
        height: heightImage,
        width: widthImage,
      );
    }
    return const Image(image: AssetImage(ImgAssets.logo));
  }
}
