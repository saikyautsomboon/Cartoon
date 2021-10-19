import 'package:cartoonex/router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

String initialRoute = '/authen';

//Auto Login
//14.10.2021
Future<Null> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // firebase အရင်ပြီးအောင်လုပ်မယ် ေနာက်မှ runappနားသွား
  await Firebase.initializeApp().then((value) async {
    // ignore: await_only_futures
    await FirebaseAuth.instance.authStateChanges().listen((event) {
      //firebase ထဲမှာ data ရှိမရှိစစ်တာ
      if (event != null) {
        initialRoute = '/myservice';
      }
      runApp(MyApp());
    });
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: initialRoute,
    );
  }
}
