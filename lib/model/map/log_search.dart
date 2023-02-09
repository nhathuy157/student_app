class SearchLog {
  String? name;
  String? idBuilding;

  SearchLog({this.name, this.idBuilding});

  String getValue() {
    return "$name^$idBuilding";
  }
}
