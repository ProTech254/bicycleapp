import 'package:bicycleapp/app_screens/add_bicycle.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body:  Column(
        children: [
          ListTile(
            subtitle: FlatButton.icon(
              onPressed: null,
              icon: Icon(
                Icons.attach_money,
                size: 30.0,
                color: Colors.green,
              ),
              label: Text('12,000',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.green)),
            ),
            title: Text(
              'Total Revenue',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, color: Colors.grey),
            ),
          ),
          Expanded(
          child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.people_outline),
                            label: Text("Users")),
                        subtitle: Text(
                          '7',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text("Categories")),
                        subtitle: Text(
                          '4',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text("Total Orders")),
                        subtitle: Text(
                          '50',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    child: ListTile(
                        title: FlatButton.icon(
                            onPressed: null,
                            icon: Icon(Icons.category),
                            label: Text("Total Bikes")),
                        subtitle: Text(
                          '5',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: active, fontSize: 60.0),
                        )),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Card(
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddBicycle()));
                      },
                      child: ListTile(
                          title: FlatButton.icon(
                              onPressed: (){

                              },
                              icon: Icon(Icons.category),
                              label: Text("Add bikes")),
                          subtitle: Icon(Icons.add)
                      ),
                    ),
                  ),

                ),
              ]
          ))
        ],
      )
    );
  }
}
