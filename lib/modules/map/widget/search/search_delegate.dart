import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_app/config/themes/app_colors.dart';
import 'package:student_app/config/themes/app_text_styles.dart';
import 'package:student_app/model/map/list_building.dart';
import 'package:student_app/model/map/list_room.dart';
import 'package:student_app/model/map/log_search.dart';
import 'package:student_app/modules/map/widget/common_used/text_item.dart';
import 'package:student_app/modules/map/widget/map/control_map.dart';
import 'package:student_app/service/action/map/building_action.dart';
import 'package:student_app/service/action/map/search_log_action.dart';
import 'package:student_app/service/action/map/search_recent.dart';

import '../../../../model/map/direction.dart';

class BuildingSearchDelegate extends SearchDelegate<String> {
  /// type 1: search normal
  /// type 2: search source location to direct
  int typeSearch;
  BuildingSearchDelegate({required this.typeSearch});
  List<String> searchResultsBuildings =
      ListBuildings.listBuildings.map((e) => e.name).toList();
  List<String> searchResultRooms = Rooms.rooms.map((e) => e.nameRoom).toList();
  // List<String> suggestionsRecent = [];
  List<String> suggestionsNow = [];
  List<SearchLog> searchLog = SearchLogAction.actions;
  String idBuildingSelected = '';

  @override
  TextInputType? get keyboardType => super.keyboardType;

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              closeSearch(context);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        )
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
      onPressed: () => closeSearch(context),
      icon: const Icon(Icons.arrow_back));

  @override
  Widget buildResults(BuildContext context) {
    if (suggestionsNow.isNotEmpty) {
      String itemFirst = suggestionsNow[0];
      WidgetsBinding.instance.addPostFrameCallback((_) {
        handleWhenSearchRight(context, itemFirst);
      });
    }
    return Consumer<DirectionPolyline>(
      builder: ((context, value, child) {
        return StatefulBuilder(builder: (context, setState) {
          FocusScope.of(context).unfocus();
          if (suggestionsNow.isNotEmpty) {
            setState(
              () {
                idBuildingSelected = searchLog
                        .where((element) => element.name == suggestionsNow[0])
                        .first
                        .idBuilding ??
                    '';
                BuildingAction.buildingSelected = ListBuildings.listBuildings
                    .where((element) => element.id == idBuildingSelected)
                    .first;
              },
            );
            if (typeSearch == 2) {
              setState(() {
                var position = BuildingAction.buildingSelected.geo;
                BuildingAction.sourceLocation =
                    LatLng(position.latitude, position.longitude);
                if (BuildingAction.sourceLocation != null &&
                    BuildingAction.destinationLocation != null) {
                  value.createPolyines(BuildingAction.sourceLocation!,
                      BuildingAction.destinationLocation!);
                }
              });
            }
            return const Center();
          } else {
            return const Center(
              child: Text(
                'Không tìm kiếm thấy!',
                style: AppTextStyles.h2,
              ),
            );
          }
        });
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // suggestionsRecent = SearchRecent.searchRecent.toList();
    List<String> searchResult =
        searchLog.map((element) => element.name ?? '').toList();
    suggestionsNow = searchResult.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();
    // return query.isEmpty
    //     ? buildSuggestionsUI(
    //         context,
    //         suggestionsRecent.isEmpty ? suggestionsNow : suggestionsRecent,
    //         const Icon(
    //           Icons.query_builder_rounded,
    //           color: AppColors.mainColor,
    //         ),
    //       ):
    return buildSuggestionsUI(
      context,
      suggestionsNow,
      const Icon(
        Icons.business,
        color: AppColors.mainColor,
      ),
    );
  }

  Widget buildNoSuggestions() => Center(
        child: Text(
          'No suggestions!',
          style: AppTextStyles.h1.copyWith(color: Colors.black),
        ),
      );

  void closeSearch(BuildContext context) async {
    Navigator.of(context).pop();
  }

  void handleWhenSearchRight(
    BuildContext context,
    String result,
  ) {
    // Your Code Here
    // FocusScope.of(context).unfocus();
    query = result;
    closeSearch(context);
    SearchRecent.searchRecent.add(result);
    // Navigator.of(context).pop();
    if (typeSearch == 1) {
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          ControlMap
              .markers[MarkerId(BuildingAction.buildingSelected.id.toString())]
              ?.onTap
              ?.call();
        },
      );
    }
    if (typeSearch == 2) {
      ControlMap().animateToLocation(
        200,
        BuildingAction.sourceLocation!,
        18,
      );
    }
  }

  Widget buildSuggestionsUI(
      BuildContext context, List<String> suggestions, Icon icon) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return suggestions.isEmpty
            ? buildNoSuggestions()
            : Consumer<DirectionPolyline>(
                builder: ((context, value, child) {
                  return ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      final suggestion = suggestions[index];
                      return Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.greyBlur,
                              width: 1,
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: IconText(
                            icon: icon,
                            text: suggestion,
                            isBorder: false,
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.keyboard_return_outlined),
                            onPressed: () {
                              query = suggestion;
                            },
                          ),
                          onTap: () async {
                            setState(() {
                              idBuildingSelected = searchLog
                                      .where((element) =>
                                          element.name == suggestion)
                                      .first
                                      .idBuilding ??
                                  '';
                              BuildingAction.buildingSelected = ListBuildings
                                      .mapBuildings[idBuildingSelected] ??
                                  ListBuildings.listBuildings[0];

                            });
                            if (typeSearch == 2) {
                              setState(() {
                                var position =
                                    BuildingAction.buildingSelected.geo;
                                BuildingAction.sourceLocation = LatLng(
                                    position.latitude, position.longitude);
                                if (BuildingAction.sourceLocation != null &&
                                    BuildingAction.destinationLocation !=
                                        null) {
                                  value.createPolyines(
                                      BuildingAction.sourceLocation!,
                                      BuildingAction.destinationLocation!);
                                }
                              });
                            }
                            handleWhenSearchRight(
                              context,
                              suggestion,
                            );
                          },
                        ),
                      );
                    },
                  );
                }),
              );
      },
    );
  }
}
