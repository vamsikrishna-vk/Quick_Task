import 'package:flutter/material.dart';
import 'package:quick_task/screens/HomeScreen.dart';
import 'package:quick_task/screens/LoginScreen.dart';
import 'service/authenticationService.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (_) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.white, secondaryHeaderColor: Colors.white),
          home: AuthenticationWrapper(),
        ));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      printToken(firebaseUser);
      return HomeScreen();
    }
    return LoginScreen();
  }

  printToken(abc) async {
    String a = await abc.getIdToken();
    print("[VK] " + a);
  }
}
