import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class GetMyTasks {
  static Future<List> getMyTasks() async {
    var data;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    Uri url = Uri.parse("http://10.10.10.225:8080/getalltask");
    String token = await firebaseUser.getIdToken();

    http.Response Response = await http
        .post(url, body: {"user_email": firebaseUser.email.toString()});
    print(Response.body);
    data = json.decode(Response.body);
    print(data.toString() + "vamsi");
    return Future.value(data);
  }
}
