import 'dart:convert';

import 'package:bicycleapp/includes/cartBottomNav.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:bicycleapp/models/orders_data.dart';
import 'package:bicycleapp/services/cart_database.dart';
import 'package:bicycleapp/services/orders_database.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Orders> orders = [];

  Future refreshOrder() async {

    this.orders = await OrdersDatabase.instance.readAll();

  }

  void initState(){
    super.initState();
    refreshOrder();
  }

  // @override
  // void dispose(){
  //   CartDatabase.instance.close();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    print("order lenght");
    print(orders.length);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),

      ),
      body: orders.length > 0 ? Container(
          child:ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return createOrderListItem(orders[index].name, orders[index].amount, orders[index].picture);
            },
            itemCount:orders.length,
          )
      ): Center(child: Text("You have no orders")),

    );
  }
}

createOrderListItem(String name, String price, String picture) {
  return Stack(
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8, left: 8, top: 8, bottom: 8),
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  color: Colors.white,
                  image: DecorationImage(
                      image: MemoryImage(base64Decode(picture),)
                  )),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(right: 8, top: 4),
                      child: Text(
                          name,
                          maxLines: 2,
                          softWrap: true,
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                      ),
                    ),
                    SizedBox(height: 6,),

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              price,
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  onTap: ()async{

                                  },
                                  child: Icon(
                                    Icons.remove,
                                    size: 24,
                                    color: Colors.grey.shade700,
                                  ),
                                ),

                                Icon(
                                  Icons.add,
                                  size: 24,
                                  color: Colors.grey.shade700,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              flex: 100,
            )
          ],
        ),
      ),
      Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 10, top: 8),
          child: Icon(
            Icons.close,
            color: Colors.white,
            size: 20,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              color: Colors.redAccent),
        ),
      )
    ],
  );
}


