import 'package:student_app/config/string/string_info.dart';

class Address {
  String? other;
  String? street;
  String? block;
  String? city;
  String? province;
  String? country;

  Address(
      {this.street,
      this.block,
      this.city,
      this.province,
      this.country,
      this.other});
  factory Address.fromJson(Map<String, dynamic> responseData) {
    return Address(
      other: responseData[StringAddress.other],
      street: responseData[StringAddress.street],
      block: responseData[StringAddress.block],
      city: responseData[StringAddress.city],
      province: responseData[StringAddress.province],
      country: responseData[StringAddress.country],
    );
  }
  factory Address.getString(String str) {
    return Address(other: str
        // street: address[0],
        // block: lengthStr > 1 ? address[1] : StringAddress.other,
        // city: lengthStr > 2 ? address[2] : StringAddress.defaultCity,
        // province: lengthStr > 3 ? address[3] : StringAddress.defaultProvince,
        // country: lengthStr > 4 ? address[4] : StringAddress.defaultCountry,
        );
  }

  @override
  toString() {
    if (other == null) {
      return "$street, $block , $city, $province, $country";
    } else {
      return other!;
    }
  }

  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringAddress.other: other,
      StringAddress.street: street,
      StringAddress.block: block,
      StringAddress.city: city,
      StringAddress.province: province,
      StringAddress.country: country,
    };
    return toData;
  }
}
