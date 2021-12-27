import 'dart:convert';

import 'package:bicycleapp/models/bicycle_data.dart';
import 'package:bicycleapp/services/bicycle_database.dart';
import 'package:flutter/material.dart';

class SearchResults extends StatefulWidget {
  final String? search_string;

  const SearchResults({Key? key, this.search_string}) : super(key: key);


  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  List<Bicycles> item = [];
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
    this.item = await BicyclesDatabase.instance.readAll();

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Searching for ${widget.search_string}.."),
      ),
      body: item.length == 0 ? Center(child: Text("No search results", style: TextStyle(fontWeight: FontWeight.bold),)):Container(
          child:ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) {
              return searchListItem(item[index].name, item[index].amount, item[index].picture);
            },
            itemCount:item.length,
          )
      ),
    );
  }
}


searchListItem(String name, String price, String picture) {
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
                    Text(
                        "Category",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                    ),
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