import 'package:flutter/cupertino.dart';
import 'package:sqflite_app/models/contacts.dart';
import 'package:sqflite_app/storage/db_controller.dart';

class ContactChangeProvider extends ChangeNotifier {
  List<Contact> contacts = [];
  ContactChangeProvider() {
    read();
  }
  Future<void> read() async {
    contacts = await DbController().read();
    notifyListeners();
  }

  Future<bool> update(Contact ctn) async {
    bool done = await DbController().update(ctn);
    if (done) {
      int index = contacts.indexWhere((element) => element.id == ctn.id);
      contacts[index] = ctn;
      notifyListeners();
    }
    return done;
  }

  Future<void> Delete(int id, int index) async {
    bool deleted = await DbController().delete(id);
    print(deleted);
    if (deleted) {
      contacts.removeAt(index);
      notifyListeners();
    }
  }

  Future<bool> create(Contact date) async {
    int inserted = await DbController().create(date);
    if (inserted != 0) {
      date.id = inserted;
      contacts.add(date);
      notifyListeners();
    }
    return inserted != 0;
  }
}
