
import 'package:bicycleapp/app_screens/add_bicycle.dart';
import 'package:bicycleapp/app_screens/admin.dart';
import 'package:bicycleapp/app_screens/allOrders.dart';
import 'package:bicycleapp/app_screens/categories.dart';
import 'package:bicycleapp/app_screens/homepage.dart';
import 'package:bicycleapp/app_screens/login.dart';
import 'package:bicycleapp/wrapper.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          ListTile(
            leading: Icon(Icons.input),
            title: Text('Admin Dashboard'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AdminPage()))

            },
          ),

          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Bicycle'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddBicycle()))

            },
          ),

          ListTile(
            leading: Icon(Icons.add),
            title: Text('Categories'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => CategoryPage()))

            },
          ),

          ListTile(
            leading: Icon(Icons.book),
            title: Text('My Orders'),
            onTap: () => {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrdersPage()))

            },
          ),

          ListTile(
            leading: Icon(Icons.book),
            title: Text('Log Out'),
            onTap: () async{

              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Wrapper()));

            },
          ),
        ],
      ),
    );
  }
}