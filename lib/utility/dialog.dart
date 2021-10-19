import 'package:cartoonex/utility/style.dart';
import 'package:flutter/material.dart';

Future<Null> normalDialog(BuildContext context, String string) async {
  showDialog(
    context: context,
    // ignore: missing_return
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: Image.asset('images/logo.png'),
        title: Text(
          'Normal Dialog',
          style: Style().redBoldStyle(),
        ),
        subtitle: Text(string),
      ),
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

Future<Null> successfulDialog(BuildContext context, String string) async {
  showDialog(
    context: context,
    // ignore: missing_return
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: Icon(
          Icons.check_circle,
          size: 40,
          color: Colors.green,
        ),
        title: Text(
          string,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}
