import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_app/models/contacts.dart';
import 'package:sqflite_app/provider/change_notifire.dart';
import 'package:sqflite_app/screens/update_contact%20.dart';
import 'package:sqflite_app/widget/aler_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_screen');
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Consumer<ContactChangeProvider>(
        builder: (context, value, child) {
          if (value.contacts.isNotEmpty) {
            return ListView.builder(
              itemCount: value.contacts.length,
              itemBuilder: (context, index) {
                Contact ctn = value.contacts[index];
                return ListTile(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Alret(
                          ctn: ctn,
                        );
                      },
                    );
                  },
                  leading: ctn.blocked == 1 ? Text('Blocked') : null,
                  title: Text(ctn.name),
                  subtitle: Text(ctn.mobile),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await Provider.of<ContactChangeProvider>(context,
                              listen: false)
                          .Delete(ctn.id, index);
                    },
                  ),
                );
              },
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.warning, size: 100),
                      Text(
                        'No Data',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
