import 'package:bicycleapp/app_screens/allOrders.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:bicycleapp/models/orders_data.dart';
import 'package:bicycleapp/services/orders_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_money_formatter/flutter_money_formatter.dart';



class CheckOutPage extends StatefulWidget {
  final List<Cart>? cart;

  const CheckOutPage({Key? key, this.cart}) : super(key: key);
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    double total = 0;
    setState(() {
      widget.cart!.forEach((item) {
        total = total + (int.parse(item.amount) * 1);
      });
    });
    return Scaffold(

      key: _scaffoldKey,

      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "ADDRESS",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
      body: Builder(builder: (context) {
        return Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: ListView(
                  children: <Widget>[
                    selectedAddressSection(),
                    standardDelivery(),

                    priceSection(total),
                    InkWell(
                      onTap: () async{

                        widget.cart!.forEach((item) async{
                          final cart = Orders(
                                  name: item.name,
                                  amount: item.amount,
                                  picture: item.picture
                              );

                              await OrdersDatabase.instance.create(cart).then((value) async{
                                print(" creating order success.r");

                              });
                        });
                        Fluttertoast.showToast(msg: "Order Placed successfully");
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrdersPage()));



                      },

                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width/1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff6bceff),
                                Color(0xFF00abff),
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(50)
                            )
                        ),
                        child: Center(
                          child: Text('Place order'.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flex: 90,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: RaisedButton(
                  onPressed: () {
                    /*Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => OrderPlacePage()));*/
                    showThankYouBottomSheet(context);
                  },
                  child: Text(
                    "Place Order",
                    style: TextStyle(color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),)
                      ),
                  color: Colors.pink,

                ),
              ),


          ],
        );
      }),
    );
  }

  showThankYouBottomSheet(BuildContext context) {
    return _scaffoldKey.currentState!.showBottomSheet((context) {
      return Container(
        height: 400,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade200, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(16), topLeft: Radius.circular(16))),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage("images/ic_thank_you.png"),
                    width: 300,
                  ),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  children: <Widget>[
                    RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(children: [
                          TextSpan(
                            text:
                            "\n\nThank you for your purchase. Our company values each and every customer. We strive to provide state-of-the-art devices that respond to our clients’ individual needs. If you have any questions or feedback, please don’t hesitate to reach out.",
                            style: TextStyle(fontSize: 12, color: Colors.grey)
                          )
                        ])),
                    SizedBox(
                      height: 24,
                    ),
                    RaisedButton(
                      onPressed: () {},
                      padding: EdgeInsets.only(left: 48, right: 48),
                      child: Text(
                        "Track Order",
                        style: TextStyle(fontSize: 12, color: Colors.grey)
                      ),
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(24))),
                    )
                  ],
                ),
              ),
              flex: 5,
            )
          ],
        ),
      );
    },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        backgroundColor: Colors.white,
        elevation: 2);
  }

  selectedAddressSection() {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "James Francois (Default)",
                    style: TextStyle(fontSize: 12, color: Colors.grey)
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Text(
                      "HOME",
                      style:TextStyle(fontSize: 12, color: Colors.grey)
                    ),
                  )
                ],
              ),
              createAddressText(
                  "431, Commerce House, Nagindas Master, Fort", 16),
              createAddressText("Mumbai - 400023", 6),
              createAddressText("Maharashtra", 6),
              SizedBox(
                height: 6,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Mobile : ",
                      style:TextStyle(fontSize: 12, color: Colors.grey)),
                  TextSpan(
                      text: "02222673745",
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ]),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.grey.shade300,
                height: 1,
                width: double.infinity,
              ),

            ],
          ),
        ),
      ),
    );
  }

  createAddressText(String strAddress, double topMargin) {
    return Container(
      margin: EdgeInsets.only(top: topMargin),
      child: Text(
        strAddress,
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
    );
  }



  standardDelivery() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border:
          Border.all(color: Colors.tealAccent.withOpacity(0.4), width: 1),
          color: Colors.tealAccent.withOpacity(0.2)),
      margin: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Radio(
            value: 1,
            groupValue: 1,
            onChanged: (isChecked) {},
            activeColor: Colors.tealAccent.shade400,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Standard Delivery",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Get it by 20 Jan - 27 Jan | Free Delivery",
                style: TextStyle(fontSize: 12, color: Colors.grey)
              )
            ],
          ),
        ],
      ),
    );
  }



  priceSection(double total) {

    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4))),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              border: Border.all(color: Colors.grey.shade200)),
          padding: EdgeInsets.only(left: 12, top: 8, right: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 4,
              ),
              Text(
                "PRICE DETAILS",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              createPriceItem("Total MRP", '20',
                  Colors.grey.shade700),

              createPriceItem(
                  "Tax", '1000', Colors.grey.shade700),
              createPriceItem("Order Total", total.toString(),
                  Colors.grey.shade700),
              createPriceItem(
                  "Delievery Charges", "FREE", Colors.teal.shade300),
              SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 0.5,
                margin: EdgeInsets.symmetric(vertical: 4),
                color: Colors.grey.shade400,
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(total.toString(),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
              SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }

//  String getFormattedCurrency(double amount) {
//    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(amount: amount);
//    fmf.symbol = "₹";
//    fmf.thousandSeparator = ",";
//    fmf.decimalSeparator = ".";
//    fmf.spaceBetweenSymbolAndNumber = true;
//    return fmf.formattedLeftSymbol;
//  }

  createPriceItem(String key, String value, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            key,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}