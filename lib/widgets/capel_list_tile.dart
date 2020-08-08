import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project/models/capel_item.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database_service.dart';
import 'package:provider/provider.dart';

class CapelListTile extends StatelessWidget {
  final CapelItem capelItem;
  CapelListTile({this.capelItem});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Dismissible(
      key: ValueKey(capelItem.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (dismissDirection) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          elevation: 12,
          title: Text('Are you sure?'),
          content: Text('Do you want to remove the item?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
            )
          ],
        ),
      ),
      onDismissed: (direction) {
        DatabaseService(uid: user.userId).deleteCapel(capelItem.id);
      },
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(
          right: 20,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      child: Card(
        elevation: 5,
        color: Colors.green[300],
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: CircularPercentIndicator(
              radius: 37.0,
              lineWidth: 2.0,
              percent: (capelItem.level / 5),
              center: new Text("${capelItem.level}"),
              progressColor: Colors.red,
            ),
          ),
          title: Row(
            children: <Widget>[
              Text(
                capelItem.title + '   ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(capelItem.subtitle),
            ],
          ),
          subtitle: Row(
            children: <Widget>[
              const Text('Started: '),
              Text(DateFormat('EEE, M/d/y').format(capelItem.startTime)),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Flexible(child: Text(capelItem.term)),
              Flexible(
                child: RaisedButton(
                  color: Colors.green[800],
                  onPressed: capelItem.level == 5
                      ? null
                      : () async {
                          if (capelItem.level < 5) {
                            await DatabaseService(uid: user.userId)
                                .updateCapel(capelItem);
                          }
                        },
                  child: const Text(
                    'Up',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
