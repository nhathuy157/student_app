import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:student_app/modules/map/widget/body_sheet/photo_ui.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/size_screen.dart';

class PhotoSlide extends StatefulWidget {
  const PhotoSlide({Key? key}) : super(key: key);

  @override
  State<PhotoSlide> createState() => _PhotoSlideState();
}

class _PhotoSlideState extends State<PhotoSlide> {
  @override
  Widget build(BuildContext context) {
    int lengthListPhotos = BuildingAction.buildingSelected.listPhoto.length;
    return CarouselSlider.builder(
      itemCount: lengthListPhotos > 3 ? 2 : 1,
      itemBuilder: (context, index, index2) {
        List<String> listImageLeft = [];
        List<String> listImageRight = [];
        for (var i = 0;
            i < BuildingAction.buildingSelected.listPhoto.length;
            i++) {
          if (i % 2 == 0) {
            listImageLeft.add(BuildingAction.buildingSelected.listPhoto[i]);
          } else {
            listImageRight.add(BuildingAction.buildingSelected.listPhoto[i]);
          }
        }
        final urlImage = listImageLeft[index];
        final urlImage2 = listImageRight[index];
        return Row(
          children: [
            Expanded(child: BuildPhoto(urlImage: urlImage)),
            SizedBox(
              width: SizeScreen.sizeSpace,
            ),
            Expanded(child: BuildPhoto(urlImage: urlImage2)),
            SizedBox(
              width: SizeScreen.sizeSpace,
            ),
          ],
        );
      },
      options: CarouselOptions(
        height: SizeScreen.sizeSpace * 21,
        viewportFraction: 1,
        enableInfiniteScroll: false,
        onPageChanged: (index, reason) {
          setState(
            () {
              index = index + 2;
            },
          );
        },
      ),
    );
  }
}
