import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final DbProvider _instanc = DbProvider._internal();

  
  factory DbProvider() {
    return _instanc;
  }

  late Database _database;

  Future<void> initDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, 'app.sql');

    _database = await openDatabase(path,version: 1, onOpen: (db) {},
        onCreate: (db, version) async{
     await db.execute(
        'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, mobile TEXT, blocked BIT)',
      );
    },
        onUpgrade: (db, oldVersion, newVersion) {},
        onDowngrade: (db, oldVersion, newVersion) {});
  }

  Database get database => _database;

  DbProvider._internal();
}
