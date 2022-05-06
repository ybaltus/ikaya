import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikaya/Fonctions/FirestoreHelper.dart';
import 'package:ikaya/View/MyUsers.dart';
import 'package:ikaya/library/constant.dart';
import 'package:ikaya/model/Utilisateur.dart';
import 'package:ikaya/modelView/ImageRond.dart';
import 'package:ikaya/modelView/ZoneText.dart';

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
        return Column(
            children: [
                ZoneText(MyPartenaire, MyUser)
            ],
        );
    }
            
}