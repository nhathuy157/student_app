import '../../config/string/string_utility.dart';

class TypeSalary {
  String id;
  String value;
  TypeSalary({required this.id, required this.value});

  factory TypeSalary.fromJson(Map<String, dynamic> responseData) {
    return TypeSalary(
      id: responseData[StringUtility.idTypeSalary].toString(),
      value: responseData[StringUtility.nameTypeSalary],
    );
  }
  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringUtility.idTypeSalary: id,
      StringUtility.nameTypeSalary: value,
    };
    return toData;
  }

  @override
  String toString() {
    return value;
  }
}
