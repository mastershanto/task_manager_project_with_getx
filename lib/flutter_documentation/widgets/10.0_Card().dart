import 'package:flutter/material.dart';

class TextField_2 extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
   return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 75,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Login Here",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 45,
                          fontWeight: FontWeight.bold),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: TextStyle(),
                    decoration: InputDecoration(
                      label: Text("Email"),
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter your email address.....",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.deepPurple,
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                      suffixIconColor: Colors.deepPurple,
                      prefixIconColor: Colors.deepPurple,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2)),
                      disabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    obscureText: true,
                    controller: TextEditingController(),
                    style: TextStyle(),
                    decoration: InputDecoration(
                      label: Text("Password"),
                      labelStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Enter your email password.....",
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.deepPurple,
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                      suffixIconColor: Colors.deepPurple,
                      prefixIconColor: Colors.deepPurple,
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 2),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Login"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 100,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [InkWell(///GestureDitector same as InkWeel
                child: Text("masterShanot",style: TextStyle(color: Colors.red),),
                onLongPress: (){},
                onDoubleTap: (){},
                onTap: (){
                  print("tapped on masterShanto");
                },
                borderRadius: BorderRadius.circular(15),
                focusColor: Colors.red,
              ),],
            ),
          ),

        ],
      );
  }
}