import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ikaya/model/Utilisateur.dart';
import '../Fonctions/FirestoreHelper.dart';
import '../model/Message.dart';
import '../modelView/MessageBubble.dart';

class Messagecontroller extends StatefulWidget{
  //Attributes
  Utilisateur id;
  Utilisateur idPartner;

  //Constructor
  Messagecontroller(Utilisateur this.id,Utilisateur this.idPartner);

  @override
  State<StatefulWidget> createState() {
    return MessagecontrollerState();
  }
}

class MessagecontrollerState extends State<Messagecontroller> {
  //Attributes
  late Animation animation;
  late AnimationController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirestoreHelper().fire_message.orderBy('envoiMessage',descending: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          } else {
            List<DocumentSnapshot>documents = snapshot.data!.docs;
            return Scaffold(
                appBar: AppBar(
                    title: Text("${widget.idPartner.prenom} ${widget.idPartner.nom}"),
                ),
                body: bodyPage(documents: documents),
            );
          }
        }
    );
  }

    Widget bodyPage({required List<DocumentSnapshot<Object?>> documents}) {
        return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext ctx,int index) {
                Message discussion = Message(documents[index]);
                if ((discussion.from == widget.id.uid &&
                    discussion.to == widget.idPartner.uid) ||
                    (discussion.from == widget.idPartner.uid &&
                        discussion.to == widget.id.uid)) {

                    return MessageBubble(widget.id.uid, widget.idPartner, discussion);
                }
                else {
                    return Container();
                }
            }
        );
    }
}

