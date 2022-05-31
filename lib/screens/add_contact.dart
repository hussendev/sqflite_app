import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_app/models/contacts.dart';
import 'package:sqflite_app/provider/change_notifire.dart';

class AddContact extends StatefulWidget {
  AddContact({Key? key}) : super(key: key);

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  late TextEditingController name;
  late TextEditingController mobile;
  bool isBlocked = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController();
    mobile = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    mobile.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add contact')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        children: [
          Text('Add new contact'),
          TextField(
            controller: name,
            decoration: InputDecoration(
              hintText: 'Name',
            ),
          ),
          TextField(
            controller: mobile,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Mobile',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              savePerform(context);
            },
            child: Text('SAVE'),
            style: ElevatedButton.styleFrom(minimumSize: Size(20, 50)),
          )
        ],
      ),
    );
  }

  void savePerform(BuildContext context) async {
    if (checkDate()) {
      saveContact(context);
    }
  }

  bool checkDate() {
    if (name.text.isNotEmpty && mobile.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future saveContact(BuildContext context) async {
    bool succesful =
        await Provider.of<ContactChangeProvider>(context, listen: false)
            .create(info);
    if (succesful) {
      Navigator.pop(context);
    } else {
      print('error');
    }
  }

  Contact get info {
    Contact ctn = Contact();
    ctn.name = name.text;
    ctn.mobile = mobile.text;
    
    ctn.blocked = isBlocked ? 1 : 0;
    return ctn;
  }
}
