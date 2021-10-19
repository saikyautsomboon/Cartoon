import 'package:cartoonex/utility/dialog.dart';
import 'package:cartoonex/models/profile.dart';
import 'package:cartoonex/utility/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  // const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  double screen;
  bool statusredeye = true;
  Profile profile = Profile();
  Container buildName() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        onChanged: (String name) {
          profile.name = name;
        },
        style: TextStyle(color: Style().dartColor),
        decoration: new InputDecoration(
          hintText: 'User Name',
          hintStyle: TextStyle(color: Style().dartColor),
          prefixIcon: Icon(
            Icons.fingerprint,
            color: Style().dartColor,
          ),
          enabledBorder: OutlineInputBorder(
            // casor မချခင် border အနေအထား
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Style().dartColor),
          ),
          focusedBorder: OutlineInputBorder(
            // casor ချပြီ း border အနေအထား
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Style().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildEmail() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (String email) {
          profile.email = email;
        },
        style: TextStyle(color: Style().dartColor),
        decoration: new InputDecoration(
          hintText: 'Email',
          hintStyle: TextStyle(color: Style().dartColor),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Style().dartColor,
          ),
          enabledBorder: OutlineInputBorder(
            // casor မချခင် border အနေအထား
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Style().dartColor),
          ),
          focusedBorder: OutlineInputBorder(
            // casor ချပြီ း border အနေအထား
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Style().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white38,
      ),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        onChanged: (String password) {
          profile.password = password;
        },
        obscureText: statusredeye,
        style: TextStyle(color: Style().dartColor),
        decoration: new InputDecoration(
          hintText: 'Password',
          hintStyle: TextStyle(color: Style().dartColor),
          prefixIcon: Icon(
            Icons.lock_outlined,
            color: Style().dartColor,
          ),
          suffixIcon: IconButton(
            icon: statusredeye
                ? Icon(Icons.remove_red_eye)
                : Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                statusredeye = !statusredeye;
                print('staturedeye=$statusredeye');
              });
            },
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Style().dartColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: BorderSide(color: Style().lightColor),
          ),
        ),
      ),
    );
  }

  FloatingActionButton buildregister() {
    return FloatingActionButton(
      backgroundColor: Style().dartColor,
      onPressed: () {
        if ((profile.name?.isEmpty ?? true) ||
            (profile.email?.isEmpty ?? true) ||
            (profile.password?.isEmpty ?? true)) {
          // print('Have Space');
          normalDialog(context, 'Have Space ? Please Fill Every Blank');
        } else {
          // print('No Space');
          registerfirebase();
        }
        // print(
        //     'User Name=${profile.name},Email=${profile.email},Password=${profile.password}');
      },
      child: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> registerfirebase() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: profile.email, password: profile.password)
          .then((value) async {
        await value.user.updateProfile(displayName: profile.name).then((value) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/myservice', (route) => false);
        });
        // firebase_core new version
        // await value.user.updateDisplayName(profile.name).then((value) {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, '/myservice', (route) => false);
        // });
      }).catchError((e) {
        normalDialog(context, e.message);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style().prinaryColor,
        title: Text('New Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              buildName(),
              buildEmail(),
              buildPassword(),
            ],
          ),
        ),
      ),
      floatingActionButton: buildregister(),
    );
  }
}
