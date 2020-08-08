import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/widgets/add_capel.dart';
import 'package:project/widgets/capel_list.dart';
import 'package:project/widgets/main_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _authService = new AuthService();
  int _selectedIndex = 0;

  void _showAddingCapelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) => SingleChildScrollView(
        child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: AddCapel(),
          ),
        ),
      ),
    );
  }

  final List<Widget> _widgetOptions = <Widget>[
    CapelList(isFinished: false,),
    CapelList(isFinished: true,),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //In the descendant widget we can access the data.
    return Scaffold(
      drawer: MainDrawer(_authService),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddingCapelBottomSheet(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.green[800],
      ),
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.green[400],
        elevation: 0.0,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            title: Text('Unfinished'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assessment),
            title: Text('Finished'),
          ),
        ],
        type: BottomNavigationBarType.shifting,
        unselectedItemColor: Colors.green[500],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
