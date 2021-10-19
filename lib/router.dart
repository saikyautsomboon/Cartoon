import 'package:cartoonex/widget/authen.dart';
import 'package:cartoonex/widget/myservice.dart';
import 'package:cartoonex/widget/register.dart';
import 'package:flutter/widgets.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => RegisterPage(),
  '/myservice': (BuildContext context) => MyService(),
};
