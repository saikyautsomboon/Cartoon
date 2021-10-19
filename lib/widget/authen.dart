import 'package:cartoonex/utility/dialog.dart';
import 'package:cartoonex/models/profile.dart';
import 'package:cartoonex/utility/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  // const Authen({ Key? key }) : super(key: key);

  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  double screen;
  bool statusredeye = true;
  Profile profile = Profile();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    // print(screen);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.35),
            radius: 1.1,
            colors: <Color>[Colors.white70, Style().dartColor],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildlogo(),
                Style().titileH1('Cartoon NetWork'),
                buildUser(),
                buildPassword(),
                buildlogin(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: buildregister(),
    );
  }

  TextButton buildregister() {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/register');
      },
      child: Text(
        'New Register',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Container buildlogin() {
    return Container(
      width: screen * 0.73,
      margin: EdgeInsets.only(top: 18),
      child: ElevatedButton(
        onPressed: () {
          // print('Email=${profile.email} and Password=${profile.password}');
          if ((profile.email?.isEmpty ?? true) ||
              (profile.password?.isEmpty ?? true)) {
            normalDialog(context, 'Have Space ? Please Fill Every Blank');
          } else {
            checkAuth();
          }
        },
        child: Text('Login'),
        style: ElevatedButton.styleFrom(
          primary: Style().dartColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  Container buildUser() {
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
          profile.email = email.trim();
        },
        style: TextStyle(color: Style().dartColor),
        decoration: new InputDecoration(
          hintText: 'Eamil/User',
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
          profile.password = password.trim();
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

  Container buildlogo() {
    return Container(
      width: screen * 0.5,
      child: Style().logo(),
    );
  }

  Future<Null> checkAuth() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: profile.email, password: profile.password)
          .then((value) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/myservice', (route) => false);
      }).catchError((e) {
        if (e.code == 'user-not-found') {
          normalDialog(context, 'There is no User Register');
        } else {
          normalDialog(context, e.message);
        }
      });
    });
  }
}
