
import 'package:bicycleapp/app_screens/homepage.dart';
import 'package:bicycleapp/models/bicycle_data.dart';
import 'package:bicycleapp/services/bicycle_database.dart';
import 'package:bicycleapp/services/utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';



class AddBicycle extends StatefulWidget {
  @override
  _AddBicycleState createState() => _AddBicycleState();
}

class _AddBicycleState extends State<AddBicycle> {


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController bicycleNameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  // TextEditingController priceController =TextEditingController();

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Mountain Bikes"),value: "mountain_bikes"),
      DropdownMenuItem(child: Text("Child Bikes"),value: "child_bikes"),
      DropdownMenuItem(child: Text("Adult Bikes"),value: "adult_bikes"),
      DropdownMenuItem(child: Text("Others"),value: "Others"),
    ];
    return menuItems;
  }


  bool loding = false;
  String imageError = '';
  List images = [];
  Image? image;
  File? _image;
  String? category = "mountain_bikes";
  String? imgString;
  Future<File>? imgFile;


  final picker = ImagePicker();


  Future pickImageFromGallery() async {
     ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
       setState(() {
         imgString = Utility.base64String(imgFile.readAsBytesSync());
         _image = imgFile;
       });


    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.2,
          backgroundColor: Colors.deepOrange,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: Colors.black,)),
          title: Text('Add Bicycle', style: TextStyle(color: Colors.black),)
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _image != null ? Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 40, 14.0, 40),
                      child: Image.file(_image!, fit: BoxFit.contain),
                    ) : OutlineButton(
                      borderSide: BorderSide(
                          color: Colors.grey.withOpacity(0.8), width: 1.0),
                      onPressed: () {
                        pickImageFromGallery();
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14.0, 40, 14.0, 40),
                        child: Icon(Icons.add, color: Colors.grey,),
                      ),

                    ),
                  ),
                ),


              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                imageError, style: TextStyle(color: Colors.red, fontSize: 12),),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Enter a Bicylcle name', textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 12,)),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: bicycleNameController,
                decoration: InputDecoration(
                    hintText: "Add Bicycle name"
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Add a Bicycle name';
                  } else if (value.length > 30) {
                    return "Bicycle name cant be more than 15 letters";
                  }
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                    hintText: "Add some Description"
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Add Description';
                  }
                },
              ),
            ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
                value: category,
                onChanged: (String? newValue){
                  setState(() {
                    category = newValue!;
                  });
                },
                items: dropdownItems
            ),
          ),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,

                decoration: InputDecoration(
                    hintText: "Enter Amount"
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Add an amount';
                  }
                },
              ),
            ),
            SizedBox(
              height: 0,
            ),
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('Add Bicycle'),
              onPressed: () async {
                print("printing category");
                print(category);
                final isValid = _formKey.currentState!.validate();
                if (isValid){
                  final bicycle = Bicycles(
                      name: bicycleNameController.text,
                      description: descriptionController.text,
                      amount: amountController.text,
                      picture: imgString!,
                      category: category!
                  );

                  await BicyclesDatabase.instance.create(bicycle).then((value) async{
                    print(" creating bicycle success.r");

                    Fluttertoast.showToast(msg: "Created Successfully");
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => BicycleList()));
                  });
                }
              },
            )

          ],
        ),
      ),
    );
  }



}




