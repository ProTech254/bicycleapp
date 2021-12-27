import 'package:bicycleapp/app_screens/bikes_categories.dart';
import 'package:bicycleapp/includes/cartBottomNav.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:bicycleapp/services/cart_database.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),

      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text("Bike Categories", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
          ),
          ListTile(
            title: Text("Mountain Bikes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            leading: Container(

              child: RaisedButton(
                child: Text("View", style: TextStyle(fontSize: 15),),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => BikesCategories(category: "mountain_bikes",)));
                },
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.grey,
              )
            ),
          ),
          ListTile(
            title: Text("Child Bikes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            leading: Container(

                child: RaisedButton(
                  child: Text("View", style: TextStyle(fontSize: 15),),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BikesCategories(category: "child_bikes",)));

                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                )
            ),
          ),
          ListTile(
            title: Text("Adult Bikes", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            leading: Container(

                child: RaisedButton(
                  child: Text("View", style: TextStyle(fontSize: 15),),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BikesCategories(category: "adult_bikes",)));

                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                )
            ),
          ),

          ListTile(
            title: Text("Others", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            leading: Container(

                child: RaisedButton(
                  child: Text("View", style: TextStyle(fontSize: 15),),
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BikesCategories(category: "others",)));

                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Colors.grey,
                )
            ),
          )
        ],
      )

    );
  }
}




