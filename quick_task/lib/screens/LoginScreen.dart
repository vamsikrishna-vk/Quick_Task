import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_task/components/LoginComponent.dart';
import 'package:quick_task/styles.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back.png"), fit: BoxFit.fitHeight),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 3.0,
              sigmaY: 3.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.black87.withOpacity(0.8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text("Kick start your",
                          textScaleFactor: 2, style: styles.style1),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("productivity journey.",
                          textScaleFactor: 2, style: styles.style1)
                    ],
                  ),
                  LoginComponent(),
                  Center(
                      child: Text(
                    "New user? Signup",
                    style: TextStyle(color: Colors.white70),
                  ))
                ],
              ),
            ),
          ),
        )));
  }
}
