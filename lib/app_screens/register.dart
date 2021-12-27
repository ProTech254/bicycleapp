
import 'package:bicycleapp/app_screens/login.dart';
import 'package:bicycleapp/models/user_data.dart';
import 'package:bicycleapp/services/user_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameTextController =TextEditingController();
  TextEditingController _emailTextController =TextEditingController();
  TextEditingController _phoneTextController =TextEditingController();
  TextEditingController _passwordTextController =TextEditingController();
  TextEditingController _passwordconfirmTextController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(

          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4.5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff6bceff),
                      Color(0xff6bceff)
                    ],
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.person,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 24,
                          right: 32
                      ),
                      child: Text('Bicycle App',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Enter your details here", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      padding: EdgeInsets.only(
                          top: 4,left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.circular(50)
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5
                            )
                          ]
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if(_nameTextController.text.isEmpty)
                          {
                            return "Cannot be empty";
                          }
                        },
                        controller: _nameTextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.person,
                            color: Color(0xff6bceff),
                          ),
                          hintText: 'Enter Full names',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if(_emailTextController.text.isEmpty)
                        {
                          return "Email cannot be empty";
                        }
                      },
                      controller: _emailTextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.person,
                          color: Color(0xff6bceff),
                        ),
                        hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextFormField(
                      controller: _phoneTextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.phone,
                          color: Color(0xff6bceff),
                        ),
                        hintText: 'Phone Number',
                      ),
                    ),
                  ),


                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if(_passwordTextController.text.isEmpty)
                        {
                          return "Passowrd cannot be empty";
                        }
                      },
                      controller: _passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.vpn_key,
                          color: Color(0xff6bceff),
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 32),
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if(_passwordconfirmTextController.text != _passwordTextController.text)
                        {
                          return "Passwords do not match";
                        }
                      },
                      controller: _passwordconfirmTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.vpn_key,
                          color: Color(0xff6bceff),
                        ),
                        hintText: 'Confirm Password',
                      ),
                    ),
                  ),


                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 16, right: 32
                      ),
                      child: Text('Forgot Password ?',
                        style: TextStyle(
                            color: Colors.grey
                        ),
                      ),
                    ),
                  ),



                  InkWell(
                    onTap: () async{
                      final isValid = _formKey.currentState!.validate();
                      if (isValid){

                        if(_nameTextController.text == "admin@gmail.com" && _passwordTextController.text == "admin1234"){
                          final user = Users(
                              full_names: _nameTextController.text,
                              email_address: _emailTextController.text,
                              phone_number: _phoneTextController.text,
                              password: _passwordTextController.text,
                              user_role: "admin"
                          );
                          await UserDatabase.instance.create(user).then((value) async{
                            print(" creating user success. Login the user");
                            await UserDatabase.instance.readLoginData(_emailTextController.text, _passwordTextController.text, context);
                            Fluttertoast.showToast(msg: "Registered admin Successfully");
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                          });
                        }else{
                          final user = Users(
                              full_names: _nameTextController.text,
                              email_address: _emailTextController.text,
                              phone_number: _phoneTextController.text,
                              password: _passwordTextController.text,
                              user_role: "customer"
                          );

                          await UserDatabase.instance.create(user).then((value) async{
                            print(" creating user success. Login the user");
                            await UserDatabase.instance.readLoginData(_emailTextController.text, _passwordTextController.text, context);
                            Fluttertoast.showToast(msg: "Registered Successfully");
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
                          });
                        }


                      }
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));

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
                        child: Text('Register'.toUpperCase(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already Registered?"),
                        Text("Sign in",style: TextStyle(color: Color(0xff6bceff)),),
                      ],
                    ),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),



                ],
              ),

            ),

          ],

        ),
      ),
    );
  }
}