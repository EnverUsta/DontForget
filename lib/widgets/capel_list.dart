import 'package:flutter/material.dart';
import 'package:project/models/capel_item.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database_service.dart';
import 'package:project/shared/Loading.dart';
import 'package:project/widgets/capel_list_tile.dart';
import 'package:provider/provider.dart';

class CapelList extends StatelessWidget {
  final isFinished;
  CapelList({this.isFinished});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return StreamBuilder<List<CapelItem>>(
      stream: DatabaseService(uid: user.userId).capel,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List<CapelItem> myCapelList = snapshot.data.where((capelItem) => capelItem.isFinished == isFinished).toList();
          return ListView.builder(
            itemCount: myCapelList.length,
            itemBuilder: (ctx, index) => Padding(
              padding: const EdgeInsets.all(2.0),
              child: CapelListTile(
                capelItem: myCapelList[index]
              ),
            )
          );
        }else{
          return Loading();
        }
      }
    );
  }
}
