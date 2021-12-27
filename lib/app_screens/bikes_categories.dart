import 'package:bicycleapp/app_screens/cart_screen.dart';
import 'package:bicycleapp/includes/bicycle_category_widget.dart';
import 'package:bicycleapp/includes/bicyclelist_widget.dart';
import 'package:bicycleapp/includes/drawer.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:bicycleapp/services/cart_database.dart';
import 'package:flutter/material.dart';

class BikesCategories extends StatefulWidget {
  final String? category;

  const BikesCategories({Key? key, this.category}) : super(key: key);

  @override
  _BikesCategoriesState createState() => _BikesCategoriesState();
}

class _BikesCategoriesState extends State<BikesCategories> {
  List<Cart> cart = [];
  int cartTotal = 0;
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
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text(widget.category!),
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
      body: BicycleCategoryListWidget(category: widget.category,),
    );
  }
}
