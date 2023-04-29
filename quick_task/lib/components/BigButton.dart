// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  BigButton(this.innerText);
  String innerText;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          color: Theme.of(context).primaryColor),
    );
  }
}
