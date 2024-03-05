import 'package:flutter/material.dart';

class AlartMessage_2 {

  MySnackBar(massage, context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(massage)));}

    MyAlartDialog1(context) {
      return showDialog(
          context: context,
          builder: (BuildContext Context) {
            return Expanded(
              child: AlertDialog(
                title: const Text("Alart___!"),
                content: const Text("Do you want to delete?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        MySnackBar("The Book has been deleted", context);
                      },
                      child: const Text("Yes")),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("No")),
                ],
              ),
            );
          });
    }

}

