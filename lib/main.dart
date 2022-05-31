import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_app/provider/change_notifire.dart';
import 'package:sqflite_app/screens/add_contact.dart';
import 'package:sqflite_app/screens/home_screen.dart';
import 'package:sqflite_app/screens/lunch_screen.dart';
import 'package:sqflite_app/storage/db_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbProvider().initDatabase();
  await ContactChangeProvider();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ContactChangeProvider>(
            create: (_) => ContactChangeProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/lunch_screen',
        routes: {
          '/lunch_screen': ((context) => LunchScreen()),
          '/home_screen': ((context) => HomeScreen()),
          '/add_screen': ((context) => AddContact()),
        },
      ),
    );
  }
}
