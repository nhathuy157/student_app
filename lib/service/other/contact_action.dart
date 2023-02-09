import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:student_app/config/string/string_info.dart';
import 'package:student_app/config/string/string_account.dart';
import 'package:student_app/model/users/user_detail.dart';
import 'package:student_app/model/shop/shop_category.dart';

class ContactAction {
  static List<Contact> contacts = [];

  Future addContact({required Contact contact}) async {
    return await FirebaseFirestore.instance
        .collection(StringInfo.contact)
        .doc(contact.idContact)
        .set(contact.toDynamic());
  }

  Future getContact({required String idContact}) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection(StringInfo.contact)
        .doc(idContact)
        .get();
    return Contact.fromSnapshot(snapshot);
  }
}
