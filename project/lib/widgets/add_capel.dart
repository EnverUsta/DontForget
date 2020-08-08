import 'package:flutter/material.dart';
import 'package:project/models/capel_item.dart';
import 'package:project/models/user.dart';
import 'package:project/services/database_service.dart';
import 'package:provider/provider.dart';

class AddCapel extends StatefulWidget {
  @override
  _AddCapelState createState() => _AddCapelState();
}

class _AddCapelState extends State<AddCapel> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final subtitleController = TextEditingController();
  String term = 'ShortTerm';

  final List<String> terms = ['ShortTerm', 'LongTerm'];

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Text(
            'Add New Capel',
            style: TextStyle(
              color: Colors.green[800],
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
            keyboardType: TextInputType.text,
            validator: (val) {
              if (val.isEmpty)
                return 'Please try to write something';
              else
                return null;
            },
          ),
          SizedBox(
            height: 40.0,
          ),
          TextFormField(
            controller: subtitleController,
            decoration: InputDecoration(labelText: 'Subtitle'),
            keyboardType: TextInputType.text,
            validator: (val) {
              if (val.isEmpty)
                return 'Please try to write something';
              else
                return null;
            },
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            'When would you like to learn?',
            style: TextStyle(fontSize: 18.0),
          ),
          DropdownButtonFormField(
            items: terms
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
            onChanged: (newTerm) {
              setState(() {
                term = newTerm;
              });
            },
          ),
          SizedBox(height: 40.0),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await DatabaseService(uid: user.userId).addNewCapel(CapelItem(
                  title: titleController.text ?? 'error',
                  subtitle: subtitleController.text ?? 'error',
                  term: term ?? 'error',
                  level: 0,
                  isFinished: false,
                ));
                Navigator.of(context).pop();
              }
            },
            child: Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.green[600],
          ),
        ],
      ),
    );
  }
}
