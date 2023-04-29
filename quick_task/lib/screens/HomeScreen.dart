import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quick_task/components/DayTasksComponent.dart';
import 'package:quick_task/screens/ChatScreen.dart';
import 'package:quick_task/styles.dart';
import 'package:quick_task/service/authenticationService.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  var firebaseUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        drawer: Drawer(
            child: Container(
                color: Colors.black,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Text(
                        "Quick Task\n ".toString().toUpperCase() +
                            firebaseUser.email,
                        textScaleFactor: 1.7,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white70, fontWeight: FontWeight.bold),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                      onTap: () {
                        context.read<AuthenticationService>().signOut();
                      },
                      trailing: Icon(Icons.logout, color: Colors.red),
                    ),
                  ],
                ))),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () => {
                      // _showMyDialog(context)
                    },
                icon: Icon(
                  Icons.add_box_rounded,
                  color: Colors.deepOrangeAccent,
                ))
          ],
          backgroundColor: Colors.black87,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                  color: Colors.white70,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          shadowColor: Colors.white10,
          title: Text("Quick Task", style: TextStyle(color: Colors.white70)),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ChatScreen()))
          },
          backgroundColor: Colors.deepOrangeAccent,
          child: Icon(
            Icons.assistant,
            color: Colors.white,
          ),
        ),
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
              color: Colors.black87.withOpacity(0.8),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Good Afternoon!",
                          textScaleFactor: 1.5, style: styles.style1),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Your tasks for the day",
                          textScaleFactor: 1.5, style: styles.style1)
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DayTasksComponent(),
                ],
              ),
            ),
          ),
        )));
  }

  Future<void> _showMyDialog(context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black87,
          title: Text("Add user by email"),
        );
      },
    );
  }
}
