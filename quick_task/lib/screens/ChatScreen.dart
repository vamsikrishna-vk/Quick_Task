import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:quick_task/components/ChatStateUi.dart';
import 'package:quick_task/service/GetAllProfiles.dart';
import 'package:quick_task/service/sendMessage.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String noFriendFeedbackMessage = "";
  bool noFriendFeedback = false;
  bool noIntentFeedback = false;
  bool noTimingFeedback = false;
  bool dataProcessing = false;
  final TextEditingController inputController = new TextEditingController();
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    setState(() {
      data.add({
        "user": false,
        "message":
            "send a message to schedule or remind a task.\nEx: Hello vamsi, i need the work to be done by today."
      });
    });
  }

  loadData() async {
    profilesData = await GetAllProfiles.getAllProfiles();
    print(profilesData);
  }

  var profilesData;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.black87,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () => {Navigator.pop(context)},
            icon: Icon(Icons.arrow_back, color: Colors.white70),
          ),
          title: Text(
            "Quick Task",
            style: TextStyle(color: Colors.white70),
          ),
          centerTitle: true,
        ),
        body: Container(
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
                color: Colors.black.withOpacity(0.8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ChatStateUi(data),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextFormField(
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                          controller: inputController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                            ),
                            // errorText: emailerror,
                            errorBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                  color: Colors.redAccent, width: 2.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.7),
                                  width: 1.0),
                            ),
                            contentPadding: const EdgeInsets.only(
                                left: 14.0, bottom: 8.0, top: 8.0),
                            hintText: 'Type some thing to inform',
                            hintStyle: TextStyle(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7)),
                            labelStyle: TextStyle(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.7)),
                            labelText: "Enter message ",
                            suffixIcon: IconButton(
                                onPressed: () => {
                                      setState(() {
                                        data.insert(0, {
                                          "user": true,
                                          "message": inputController.text.trim()
                                        });
                                        processData();
                                      }),
                                      inputController.clear()
                                    },
                                icon: Icon(Icons.send_rounded,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.7))),
                          )),
                    ),
                  ],
                ),
              ),
            )));
  }

  void processData() async {
    var targetData = data[0];
    String targetMessage = targetData["message"];
    if (noIntentFeedback || noTimingFeedback) {
      //send Target Message
      data.insert(0, {"user": false, "message": "Information sent"});
      setState(() {});
      return;
    }
    String targetName = "";
    String targetEmail = "";
    for (var i in profilesData) {
      if (targetMessage.contains(i["nickname"])) {
        targetName = i["nickname"];
        targetEmail = i["email"];
      }
    }
    if (targetName == "") {
      data.insert(0, {
        "user": false,
        "message": "no connection found in the sentence. can you tell his name?"
      });
      noFriendFeedbackMessage = targetMessage;
      noFriendFeedback = true;
      return;
    }
    if (noFriendFeedback) {
      targetMessage = noFriendFeedbackMessage;
      noFriendFeedback = false;
    }
    print("data to send" + targetMessage + targetEmail + targetName);
    setState(() => {
          data.insert(0, {"user": false, "message": "Processing Information"}),
          dataProcessing = true
        });
    var JsonData = {
      "nickname": targetName,
      "senderemail": targetEmail,
      "message": targetMessage
    };
    var data2 = await SendMessage.sendMessage(JsonData).then((value) => {
          setState(() {
            data.removeAt(0);
            dataProcessing = false;
          }),
          if (value == "Success")
            {
              data.insert(0, {
                "user": false,
                "message":
                    "Information sent to " + targetName + "\"$targetMessage\""
              }),
            },
          if (value == "Failure")
            {
              noIntentFeedback = true,
              data.insert(0, {
                "user": false,
                "message": "Enter Intent of the message to " + targetName
              }),
            },
          if (value == "timing")
            {
              noTimingFeedback = true,
              data.insert(0, {
                "user": false,
                "message": "when should be the task or remainder set?"
              }),
            },
          setState(() {})
        });
  }
}
