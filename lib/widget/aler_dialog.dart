import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_app/models/contacts.dart';
import 'package:sqflite_app/provider/change_notifire.dart';
import 'package:sqflite_app/screens/update_contact%20.dart';

class Alret extends StatefulWidget {
  @override
  Alret({required this.ctn});
  late Contact ctn;
  State<Alret> createState() => _AlretState(ctn);
}

class _AlretState extends State<Alret> {
  _AlretState(this.ctn);
  Contact ctn;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Column(
          children: [
            SwitchListTile(
              value: ctn.blocked == 1,
              title: Text(
                'Block',
                style: TextStyle(color: Colors.red),
              ),
              onChanged: (val) {
                setState(() {
                  ctn.blocked = val ? 1 : 0;
                });

                Provider.of<ContactChangeProvider>(context, listen: false)
                    .update(ctn);

                // Provider.of<ContactChangeProvider>(context).update();
              },
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                // print('object');
                // Provider.of<ContactChangeProvider>(context, listen: false)
                //     .Delete(ctn.id);

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return UpdateContact(ctn);
                     
                  },
                ))
                .then((value) => Navigator.pop(context));
                //  Navigator.pop(context);
              },
              child: Container(
                height: 35,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.blue),
                child: Center(
                    child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ],
      title: Text('Options'),
    );
  }
}
