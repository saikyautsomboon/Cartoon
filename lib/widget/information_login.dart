import 'package:cartoonex/utility/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class InformationLogin extends StatefulWidget {
  // const InformationLogin({ Key? key }) : super(key: key);

  @override
  _InformationLoginState createState() => _InformationLoginState();
}

class _InformationLoginState extends State<InformationLogin> {
  String displayname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findName();
  }

  Future<Null> findName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          displayname = event.displayName;
        });
        print('########Display Name= $displayname########');
      });
    });
  }

  Future<Null> editName() async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: Style().logo(),
          title: Text('Edit Display Name'),
          subtitle: Text('Please Enter New Name'),
        ),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: Style().boxDecoration(),
                width: 250,
                child: TextFormField(
                  initialValue: displayname,
                  onChanged: (value) {
                    displayname = value.trim();
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.account_box_outlined),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 14,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                  onPressed: () async {
                    print('Change Name= $displayname');
                    await Firebase.initializeApp().then((value) async {
                      FirebaseAuth.instance
                          .authStateChanges()
                          .listen((event) async {
                        event
                            .updateProfile(displayName: displayname)
                            .then((value) {
                          findName();
                          Navigator.pop(context);
                        });
                      });
                    });
                  },
                  child: Text('Edit Name')),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 250,
          child: ListTile(
            trailing: IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  size: 40,
                  color: Style().dartColor,
                ),
                onPressed: () {
                  editName();
                }),
            leading: Icon(
              Icons.account_box_sharp,
              size: 40,
              color: Style().dartColor,
            ),
            title: Style().titileH2(
              displayname == null ? 'No Name ?' : displayname,
            ),
            subtitle: Text('Display Name'),
          ),
        ),
      ),
    );
  }
}
