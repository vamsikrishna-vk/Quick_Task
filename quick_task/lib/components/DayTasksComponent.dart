import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_task/service/GetAllProfiles.dart';
import 'package:quick_task/service/GetMyTasks.dart';

class DayTasksComponent extends StatefulWidget {
  @override
  State<DayTasksComponent> createState() => _DayTasksComponentState();
}

class _DayTasksComponentState extends State<DayTasksComponent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  var profilesData;
  String getNameByEmail(email) {
    for (var i in profilesData) {
      print(i);
      if (i["email"] == email) {
        return i["nickname"];
      }
    }
    return "";
  }

  void loadData() async {
    profilesData = await GetAllProfiles.getAllProfiles();
    print(profilesData);
    data = await GetMyTasks.getMyTasks();
    setState(() {
      loading = false;
    });
  }

  int ExpndedView = -1;
  bool loading = true;
  var data;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (loading) {
      return CircularProgressIndicator();
    }
    return Expanded(child: buildListview(context));
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
        itemBuilder: (
          context,
          index,
        ) {
          return InkWell(
            onTap: () => {
              setState(() => {
                    if (index == ExpndedView)
                      {ExpndedView = -1}
                    else
                      {ExpndedView = index}
                  })
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey)),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getNameByEmail(data[index]["sender"]) + " say's",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white70),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              data[index]["intent"].toString().toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Colors.deepOrangeAccent),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              data[index]["time"].toString().toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                  color: Colors.white70),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      (data[index]["message"].toString().length > 35 &&
                              (ExpndedView == -1 || ExpndedView != index))
                          ? data[index]["message"].toString().substring(0, 33) +
                              "..."
                          : data[index]["message"].toString(),
                      style: TextStyle(color: Colors.white54),
                    )
                  ],
                )),
          );
        });
  }
}
