import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/widgets/stateless/dismissble_page.dart';

class ViewDetailPhoto extends StatefulWidget {
  final PageController pageController;
  final List<String> urlImages;
  ViewDetailPhoto({
    Key? key,
    required this.urlImages,
  }) : pageController =
            PageController(initialPage: BuildingAction.photoSelected);

  @override
  State<ViewDetailPhoto> createState() => _ViewDetailPhotoState();
}

class _ViewDetailPhotoState extends State<ViewDetailPhoto> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DismissiblePageCustom(
      function: () {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.black,
          titleSpacing: 0,
        ),
        body: PhotoViewGallery.builder(
          pageController: widget.pageController,
          scrollPhysics: const BouncingScrollPhysics(),
          itemCount: widget.urlImages.length,
          builder: (context, index) {
            final urlImage = widget.urlImages[index];
            return PhotoViewGalleryPageOptions(
              imageProvider: NetworkImage(urlImage),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 4,
            );
          },
          onPageChanged: (currentIndex) {
            setState(() {
              currentIndex = currentIndex;
            });
          },
        ),
      ),
    );
  }
}
