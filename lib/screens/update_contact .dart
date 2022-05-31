import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_app/models/contacts.dart';
import 'package:sqflite_app/provider/change_notifire.dart';

class UpdateContact extends StatefulWidget {
  final Contact ctn;

  UpdateContact(this.ctn);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  late TextEditingController name;
  late TextEditingController mobile;
  late bool isBlocked;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = TextEditingController(text: widget.ctn.name);
    mobile = TextEditingController(text: widget.ctn.mobile);
    isBlocked = widget.ctn.blocked == 1;
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
      appBar: AppBar(title: Text('Update contact')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        children: [
          Text('Update contact'),
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
              savePerform();
              Navigator.pop(context);
            },
            child: Text('SAVE'),
            style: ElevatedButton.styleFrom(minimumSize: Size(20, 50)),
          )
        ],
      ),
    );
  }

  void savePerform() async {
    if (checkDate()) {
      saveContact();
    }
  }

  bool checkDate() {
    if (name.text.isNotEmpty && mobile.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future saveContact() async {
    bool succesful =
        await Provider.of<ContactChangeProvider>(context, listen: false)
            .update(info);
    if (succesful) {
      print('done');
    } else {
      print('error');
    }
  }

  Contact get info {
    Contact ctn = widget.ctn;
    ctn.name = name.text;
    ctn.mobile = mobile.text;
    ctn.blocked = isBlocked ? 1 : 0;
    return ctn;
  }
}
