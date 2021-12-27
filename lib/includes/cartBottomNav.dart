
import 'package:bicycleapp/includes/checkout_screen.dart';
import 'package:bicycleapp/models/cart_data.dart';
import 'package:flutter/material.dart';


class CartBottomBar extends StatefulWidget{
  final List<Cart>? cart;

  const CartBottomBar({Key? key, this.cart}) : super(key: key);
  @override
  _CartBottomBarState createState() => _CartBottomBarState();
}

class _CartBottomBarState extends State<CartBottomBar> {


  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);



    double total = 0;
    setState(() {
      widget.cart!.forEach((item) {
        total = total + (int.parse(item.amount) * 1);
      });
    });
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 3.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(

        height: 50.0,
        decoration: BoxDecoration(

            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)
            ),
            color: Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 38,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Total :', style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600
                      ),),
                      Text("ksh.${total.toString()}", style: TextStyle(
                        fontSize: 10,

                      ),)
                    ],
                  ),


                  Container(

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.red,
                    ),
                    child: OutlineButton(

                      splashColor: Colors.grey,
                      onPressed: () {
                        if(widget.cart!.length == 0){
                          scaffold.showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.deepOrange,
                              content: Text('Add items on your basket first', style: TextStyle(
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                          );

                        }else
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutPage(cart: widget.cart,)));

                      },

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      highlightElevation: 3 ,
                      borderSide: BorderSide(color: Colors.deepOrange),

                      color: Colors.redAccent,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.arrow_forward, color: Colors.white,),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Check Out',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}