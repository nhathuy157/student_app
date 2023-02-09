import 'package:student_app/model/map/building.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/size_screen.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  Building building = BuildingAction.buildingSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeScreen.sizeSpace),
      child: Text(building.description),
    );
  }
}
