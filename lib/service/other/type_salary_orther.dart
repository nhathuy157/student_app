import 'package:student_app/model/other/type_salary.dart';

import '../../config/string/string_category.dart';
import '../../config/string/string_utility.dart';
import 'json_manager.dart';

class TypeSalaryAction {
  Future<List<TypeSalary>> getFromFirebase() async {
    List<dynamic> list = await JsonManager().categoryFormFireBase(
        url: StringUtility.urlTypeSalary, nameType: StringCategory.typeSalary);
    return list.map((e) => TypeSalary.fromJson(e)).toList();
  }
}
