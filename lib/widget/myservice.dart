import 'dart:ffi';

import 'package:cartoonex/models/profile.dart';
import 'package:cartoonex/utility/style.dart';
import 'package:cartoonex/widget/information_login.dart';
import 'package:cartoonex/widget/show_cartoon_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MyService extends StatefulWidget {
  // const MyService({ Key? key }) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  Profile profile = Profile(); //15.10.2021
  Widget currentWidget = ShowCartoonList(); //15.10.2021
  //15.10.2021
  @override
  void initState() {
    super.initState();
    findNameand();
  }

  // 15.10.2021
  // select Name and email from firebase
  // ignore: missing_return
  Future<Void> findNameand() async {
    await Firebase.initializeApp().then((value) async {
      // ignore: await_only_futures
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          profile.name = event.displayName;
          profile.email = event.email;
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style().prinaryColor,
      ),
      drawer: builddrawer(),
      body: currentWidget,
    );
  }

  Drawer builddrawer() {
    return Drawer(
      //15.10.2021
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildshowcartoonlist(),
              buildinformationlogin(),
            ],
          ),
          buildLogout(),
        ],
      ),
    );
  }

//15.10.2021
  ListTile buildshowcartoonlist() {
    return ListTile(
      leading: Icon(
        Icons.face,
        size: 36.0,
      ),
      title: Text('Show Cartoon List'),
      subtitle: Text('Show All Cartoon in My Stock'),
      onTap: () {
        setState(() {
          currentWidget = ShowCartoonList();
        });
        Navigator.pop(context);
      },
    );
  }

//15.10.2021
  ListTile buildinformationlogin() {
    return ListTile(
      leading: Icon(
        Icons.perm_device_information_rounded,
        size: 36.0,
      ),
      title: Text('Information Lgoin'),
      subtitle: Text('Show All Cartoon in My Stock'),
      onTap: () {
        setState(() {
          currentWidget = InformationLogin();
        });
        Navigator.pop(context);
      },
    );
  }

//15.10.2021
  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/wall.jpeg'),
        ),
      ),
      accountName:
          Style().titileH2White(profile.name == null ? 'Name' : profile.name),
      accountEmail: Style()
          .titileH3White(profile.email == null ? 'Email' : profile.email),
      currentAccountPicture: Image.asset('images/logo.png'),
    );
  }

//14.10.2021
  Column buildLogout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then(
              (value) async {
                await FirebaseAuth.instance.signOut().then(
                  (value) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/authen', (route) => false);
                  },
                );
              },
            );
          },
          tileColor: Style().dartColor,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 34,
          ),
          title: Style().titileH2White('LogOut'),
          subtitle: Style().titileH3White('LogOut & Go to Authen'),
        ),
      ],
    );
  }
}
