import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class GetAllProfiles {
  static Future<List> getAllProfiles() async {
    var data;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    Uri url = Uri.parse("http://10.10.10.225:8080/getallProfile");
    String token = await firebaseUser.getIdToken();

    http.Response Response = await http.post(url, headers: {
      "Authorization": "Bearer " + token.toString(),
    }, body: {
      "email": firebaseUser.email.toString()
    });

    data = json.decode(Response.body);
    print(data);
    return Future.value(data);
  }
}
