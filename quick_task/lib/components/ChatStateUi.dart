import 'package:flutter/material.dart';
import 'package:quick_task/service/GetAllProfiles.dart';

class ChatStateUi extends StatefulWidget {
  var data;
  ChatStateUi(this.data);
  @override
  State<ChatStateUi> createState() => _ChatStateUiState(data);
}

class _ChatStateUiState extends State<ChatStateUi> {
  _ChatStateUiState(this.data);
  var data;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: buildListview(context),
    ));
  }

  ListView buildListview(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
              color: Colors.transparent,
              height: 10,
            ),
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        reverse: true,
        itemBuilder: (
          context,
          index,
        ) {
          return Container(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Row(
              mainAxisAlignment: data[index]["user"]
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: Colors.grey),
                      color: data[index]["user"]
                          ? Colors.grey.withOpacity(0.2)
                          : Colors.deepOrangeAccent.withOpacity(0.6),
                    ),
                    width: MediaQuery.of(context).size.width / 1.4,
                    child: Text(data[index]["message"],
                        style: TextStyle(color: Colors.white70)))
              ],
            ),
          );
        });
  }
}
