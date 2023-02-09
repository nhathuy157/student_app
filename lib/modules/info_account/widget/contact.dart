import 'package:cloud_firestore/cloud_firestore.dart';

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
  DocumentReference? doc;

}