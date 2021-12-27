import 'package:bicycleapp/app_screens/cart_screen.dart';
import 'package:bicycleapp/app_screens/search_results.dart';
import 'package:bicycleapp/includes/bicyclelist_widget.dart';
import 'package:bicycleapp/includes/drawer.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:bicycleapp/services/cart_database.dart';
import 'package:flutter/material.dart';

class BicycleList extends StatefulWidget {
  const BicycleList({Key? key}) : super(key: key);

  @override
  _BicycleListState createState() => _BicycleListState();
}

class _BicycleListState extends State<BicycleList> {
  List<Cart> cart = [];
  int cartTotal = 0;
  TextEditingController searchController = TextEditingController();
  Future refreshCart() async {
   
    this.cart = await CartDatabase.instance.readAll();
    setState(() {
      cartTotal = cart.length;
    });
  }

  void initState(){
    super.initState();
    refreshCart();
  }


  @override
  Widget build(BuildContext context) {
    final String? search_string;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text("Bicycle App"),
          actions: <Widget>[

            new Padding(padding: const EdgeInsets.all(18.0),

              child: new Container(
                  height: 150.0,
                  width: 30.0,
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder:(BuildContext context) =>
                              new CartPage()
                          )
                      );
                    },

                    child: new Stack(

                      children: <Widget>[
                        new IconButton(icon: new Icon(Icons.shopping_cart,
                          color: Colors.white,),
                          onPressed: null,
                        ),
                        cart.length ==0 ? new Container() :
                        new Positioned(

                            child: new Stack(
                              children: <Widget>[
                                new Icon(
                                    Icons.brightness_1,
                                    size: 20.0, color: Colors.green[800]),
                                new Positioned(
                                    top: 3.0,
                                    right: 4.0,
                                    child: new Center(
                                      child: new Text(
                                        cart.length.toString(),
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    )),


                              ],
                            )),

                      ],
                    ),
                  )
              )

              ,)],

      ),
      body: ListView(
          children: [
            // Search bar
      Container(
      padding: EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          Container(
              padding: const EdgeInsets.all(8.0),
              child: new Container(
                  height: 70.0,
                  child: new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Card(
                          child: new Container(
                              child: new Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                        onTap : (){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchResults(search_string: searchController.text,)));
                                        },
                                        child: new Icon(Icons.search)),
                                    new Container(
                                      width: MediaQuery.of(context).size.width - 100.0,
                                      child: new TextFormField(
                                          controller: searchController,
                                          decoration: InputDecoration(
                                            hintText: 'Search',
                                            //onSearchTextChanged,
                                          ),
                                          onChanged: (String text) async {

                                          }),
                                    )
                                  ]))))))
              ])),
            Image.asset('assets/bike.jpg'),
            BicycleListWidget()
          ],
    )
    );
  }
}
