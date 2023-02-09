import 'package:student_app/service/other/contact_action.dart';
import 'package:student_app/service/other/json_manager.dart';
import 'package:student_app/service/other/range_money_action.dart';

class FakeUser {
  Future GetContactFake() async {
    ContactAction.contacts = await JsonManager().readJsonContact();
    ContactAction.contacts.forEach((element) {
      ContactAction().addContact(contact: element);
    });
  }
}
