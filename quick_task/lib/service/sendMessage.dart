import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class SendMessage {
  static Future<String> sendMessage(var data) async {
    print(data);
    var firebaseUser = FirebaseAuth.instance.currentUser;
    data["email"] = firebaseUser.email.toString();
    Uri url = Uri.parse("http://10.10.10.225:8080/sendMessage");
    String token = await firebaseUser.getIdToken();
    print(data.toString() + "{VK}");
    http.Response Response = await http.post(url,
        headers: {"Authorization": "Bearer " + token.toString()}, body: data);
    // data = json.decode(Response.body);
    // print(data);
    return Future.value(Response.body);
  }
}
