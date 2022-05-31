import 'package:sqflite/sqflite.dart';
import 'package:sqflite_app/models/contacts.dart';
import 'package:sqflite_app/storage/db_operation.dart';
import 'package:sqflite_app/storage/db_provider.dart';

class DbController implements DbOperation<Contact> {
  late Database _database;

  DbController() : _database = DbProvider().database;

  @override
  Future<int> create(Contact date) async {
    return await _database.insert('contacts', date.toMap());
  }

  @override
  Future<bool> delete(int id) async {
    int numberOfRow =
        await _database.delete('contacts', where: 'id=?', whereArgs: [id]);
    return numberOfRow != 0;
  }

  @override
  Future<List<Contact>> read() async {
    var rowMaps = await _database.query('contacts');
    List<Contact> contacts =
        rowMaps.map((rowMap) => Contact.fromMap(rowMap)).toList();
    return contacts;
  }

  @override
  Future<Contact?> show(int id) async {
    var data =
        await _database.query('contacts', where: 'id=?', whereArgs: [id]);
    List contacts = data.map((e) => Contact.fromMap(e)).toList();
    return contacts.length > 0 ? contacts.first : null;
  }

  @override
  Future<bool> update(Contact data) async {
    int count = await _database
        .update('contacts', data.toMap(), where: 'id=?', whereArgs: [data.id]);
    return count > 0;
  }
}
