import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikaya/Fonctions/FirestoreHelper.dart';
import 'package:ikaya/View/MyMessage.dart';
import 'package:ikaya/library/constant.dart';
import 'package:ikaya/model/Utilisateur.dart';
import 'package:ikaya/modelView/ImageRond.dart';

class MyConversations extends StatefulWidget {
    @override
    State<StatefulWidget> createState() {
        // TODO: implement createState
        return MyConversationsState();
    }
}

class MyConversationsState extends State<MyConversations> {
    @override
    Widget build(BuildContext context) {
        // TODO: implement build
        return bodyPage();
    }

    Widget bodyPage() {
        // return const Text("Mes conversations");
        return StreamBuilder<QuerySnapshot>(
      stream: FirestoreHelper().fireUser.snapshots(),
        builder: (context, snapshot){
        // Pas d'information dans la collection Users
          if(!snapshot.hasData){
              return const CircularProgressIndicator();
          }
          // Information dans la collection Users
          else
            {
              List documents = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context,index){
                    Utilisateur user = Utilisateur(documents[index]);
                    if(user.uid == MyUser.uid){
                      return Container();
                    }
                    else{
                      return InkWell(
                          child: Card(
                                elevation: 5.0,
                                color: Colors.lightBlue,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                //Image
                                leading: ImageRond(image: user.image,size:60),

                                title: Text("${user.prenom} ${user.nom}"),
                                subtitle: Text("${user.mail}"),
                                ),
                            ),
                            onTap: (){
                                setState(() {
                                    MyPartenaire = user;
                                });
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => MyMessage()
                                ));
                            }
                      );
                    }
                  }
              );
            }
        }
    );
    }
            
}