import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikaya/Controller/MessageController.dart';
import 'package:ikaya/library/constant.dart';
import 'package:ikaya/model/Utilisateur.dart';
import 'package:ikaya/modelView/ZoneText.dart';
import 'package:ikaya/library/lib.dart';

class MyMessage extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return MyMessageState();
    }
}

class MyMessageState extends State<MyMessage> {
    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return bodyPage();
    }

    Widget bodyPage() {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
                child: Column(
                    children: [
                        Container(
                            height: MediaQuery.of(context).size.height-80,
                            width: MediaQuery.of(context).size.width,
                            child: Messagecontroller(
                                MyUser,
                                MyPartenaire
                            ),
                        ),
                        ZoneText(MyPartenaire, MyUser)
                    ],
                ),
            )
        );
    }
            
}