import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_app/config/string/string_info.dart';

class Contact {
  String? avatar;
  String? fistName;
  String? lastName;
  String? birthDay;
  String? idContact;
  String? idUser;
  bool? showPhone = false;
  String? phoneNumber;
  bool? showEmail = false;
  String? email;
  bool? showMessenger = false;
  String? messenger;
  bool? showZalo = false;
  String? zalo;
  String? other;
  DocumentReference? doc;
  Contact(
      {this.avatar,
      this.fistName,
      this.lastName,
      this.birthDay,
      this.idContact,
      this.idUser,
      this.showPhone,
      this.phoneNumber,
      this.showMessenger,
      this.showEmail,
      this.email,
      this.showZalo,
      this.zalo,
      this.messenger});
  factory Contact.fromJson(Map<String, dynamic> responseData) {
    return Contact(
        avatar: responseData[StringInfo.avatar] ?? "",
        idUser: responseData[StringInfo.idUser] is String
            ? responseData[StringInfo.idUser]
            : responseData[StringInfo.idUser].toString(),
        fistName: responseData[StringInfo.fistName] ?? "",
        lastName: responseData[StringInfo.lastName] ?? "",
        idContact: responseData[StringInfo.idContact] is String
            ? responseData[StringInfo.idContact]
            : responseData[StringInfo.idContact].toString(),
        birthDay: responseData[StringInfo.birthDay],
        showPhone: responseData[StringInfo.showPhone] is String
            ? false
            : responseData[StringInfo.showPhone],
        phoneNumber: responseData[StringInfo.phoneNumber],
        showEmail: responseData[StringInfo.showEmail] ?? false,
        email: responseData[StringInfo.email],
        showMessenger: responseData[StringInfo.showMessenger] ?? false,
        messenger: responseData[StringInfo.messenger],
        showZalo: responseData[StringInfo.showZalo] ?? false,
        zalo: responseData[StringInfo.zalo]);
  }
  Map<String, dynamic> toDynamic() {
    Map<String, dynamic> toData = {
      StringInfo.avatar: avatar,
      StringInfo.fistName: fistName,
      StringInfo.lastName: lastName,
      StringInfo.birthDay: birthDay,
      StringInfo.idContact: idContact,
      StringInfo.idUser: idUser,
      StringInfo.showEmail: showEmail,
      StringInfo.email: email,
      StringInfo.showZalo: showZalo,
      StringInfo.zalo: zalo,
      StringInfo.showMessenger: showMessenger,
      StringInfo.messenger: messenger,
      StringInfo.phoneNumber: phoneNumber,
      StringInfo.showPhone: phoneNumber,
    };
    return toData;
  }

  factory Contact.fromSnapshot(DocumentSnapshot snapshot) {
    Contact contact = Contact.fromJson(snapshot.data() as Map<String, dynamic>);
    contact.doc = snapshot.reference;
    return contact;
  }
}
