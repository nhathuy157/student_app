import 'package:student_app/model/map/building.dart';
import 'package:student_app/modules/map/widget/photo_page/item_photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:student_app/modules/map/widget/photo_page/view_detail_photo.dart';
import 'package:student_app/service/action/map/building_action.dart';

class PhotoGridView extends StatefulWidget {
  final pageController = PageController();
  PhotoGridView({
    Key? key,
  }) : super(key: key);
  @override
  State<PhotoGridView> createState() => _PhotoGridViewState();
}

class _PhotoGridViewState extends State<PhotoGridView> {
  Building building = BuildingAction.buildingSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: (building.listPhoto).length,
        itemBuilder: (context, index) {
          return InkWell(
            child: PhotoItem(building.listPhoto[index]),
            onTap: () {
              setState(() {
                BuildingAction.photoSelected = index;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewDetailPhoto(
                    urlImages:
                    building.listPhoto
                  ),
                ),
              );

            },
          );
        },
      ),
    );
  }
}
