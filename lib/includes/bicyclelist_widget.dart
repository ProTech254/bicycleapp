import 'dart:convert';

import 'package:bicycleapp/app_screens/homepage.dart';
import 'package:bicycleapp/models/bicycle_data.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:bicycleapp/services/bicycle_database.dart';
import 'package:bicycleapp/services/cart_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BicycleListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ShopListState();
  }
}
class _ShopListState extends State<BicycleListWidget> {

    final _scaffoldKey = GlobalKey<ScaffoldState>();
    List<Bicycles> bicycles = [];
    bool isLoading = false;
    @override
    void initState(){
      super.initState();
      refreshBicycles();
    }
    @override
    void dispose(){
      BicyclesDatabase.instance.close();
      super.dispose();
    }
    Future refreshBicycles() async {
      setState(() {
        isLoading = true;
      });
      this.bicycles = await BicyclesDatabase.instance.readAll();

      setState(() {
        isLoading = false;
      });
    }

  @override
  Widget build(BuildContext context) {
      if(bicycles.length == 0){
        return Center(child: Text("No Bicycles for sale currently"));
      }else{
        return GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: bicycles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index){
              print(index);
              return SingleBicycle(
                id: bicycles[index].id,
                bicycle_name: bicycles[index].name,
                description: bicycles[index].description,
                price: bicycles[index].amount,
                picture: bicycles[index].picture,


              );

            }
        );
      }


  }
}

class SingleBicycle extends StatelessWidget{
  final int? id;
  final String? bicycle_name;
  final String? price;
  final String? description;
  final String? picture;

  const SingleBicycle({Key? key, this.id, this.bicycle_name, this.price, this.description, this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        height: 300,
        child: Stack(
            children: <Widget>[
              Container(

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2, 1),
                          blurRadius: 10
                      )
                    ]
                ), child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.red,

                      ),
                      child: InkWell(

                          onTap: () {
                            print('presses inkwell');
                            // Navigator.of(context).push(
                            //     MaterialPageRoute(builder: (context) => ProductDetailsTest(
                            //       product_id:product_id,
                            //       product_name: product_name,
                            //       product_price: product_price,
                            //       product_picture: product_picture,
                            //       product_rating: product_rating,
                            //       product_category: product_category,
                            //       product_description: product_description,
                            //       product_available: product_available,
                            //
                            //     ))
                            // );
                          },
                          child: Image.memory(
                            base64Decode(picture!),
                            fit: BoxFit.fill,
                          )
                      )),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(bicycle_name!,
                              style: TextStyle(
                                  fontSize: 13
                              ),),
                          ),
                          SizedBox(height: 5,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Ksh. ${price.toString()}",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade600
                              ),),
                          ),

                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(2, 5),
                                        blurRadius: 7
                                    )
                                  ]
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      onTap: () async {
                                        //add to cart

                                          final cart = Cart(
                                              name: bicycle_name!,
                                              amount: price!,
                                              picture: picture!,

                                          );

                                          await CartDatabase.instance.create(cart).then((value) async{
                                            print(" creating cart success.r");

                                            Fluttertoast.showToast(msg: "Added to cart successfully");

                                          });
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => BicycleList()));



                                      },
                                      child: Icon(Icons.shopping_cart, size: 16,
                                        color: Colors.red,))
                              )),

                        ],

                      ),

                    ],
                  ),
                ],
              ),
              ),


            ]
        ),
      ),
    );
  }
}