import 'package:flutter/material.dart';

class MyMessages extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return MyMessagesState();
    }

}

class MyMessagesState extends State<MyMessages> {
    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return bodyPage();
    }

    Widget bodyPage() {
        return const Text("MyMessages page");
    }
            
}