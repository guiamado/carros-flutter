import 'package:flutter/material.dart';

Future push(context, Widget page, {bool replace = false}) {
  if (replace) {
    return Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return page;
      },
    ));
  }

  return Navigator.push(context, MaterialPageRoute(
    builder: (BuildContext context) {
      return page;
    },
  ));
}

pop(context, text) {
  Navigator.pop(context, text);
}
