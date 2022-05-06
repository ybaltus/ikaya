import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ikaya/model/Utilisateur.dart';

class FirestoreHelper {
    //Attributs
    final auth = FirebaseAuth.instance;
    final fireUser = FirebaseFirestore.instance.collection("Users");
    final storage = FirebaseStorage.instance;
    final fire_message = FirebaseFirestore.instance.collection("Message");
    final fire_conversation=FirebaseFirestore.instance.collection('Conversations');

    //Méthodes

    // Envoyer un message
    sendMessage(String texte,Utilisateur user,Utilisateur moi){
        DateTime date=DateTime.now();
        Map <String,dynamic>map={
            'from':moi.uid,
            'to':user.uid,
            'texte':texte,
            'envoiMessage':date
        };
        String idDate = date.microsecondsSinceEpoch.toString();
        addMessage(map, getMessageRef(moi.uid, user.uid, idDate));
        addConversation(getConversation(moi.uid, user, texte, date), moi.uid);
        addConversation(getConversation(user.uid, moi, texte, date), user.uid);
    }

    //Récupérer une conversation
    Map <String,dynamic> getConversation(String sender,Utilisateur partenaire,String
    texte,DateTime date){
        Map <String,dynamic> map = partenaire.toMap();
        map ['idmoi']=sender;
        map['lastmessage']=texte;
        map['envoimessage']=date;
        map['destinateur']=partenaire.uid;
        return map;
    }

    // Récupérer la référence d'un message
    String getMessageRef(String from,String to,String date){
        String resultat="";
        List<String> liste=[from,to];
        liste.sort((a,b)=>a.compareTo(b));
        for(var x in liste){
            resultat += x+"+";
        }
        resultat =resultat + date;
        return resultat;
    }


    // Ajouter un message
    addMessage(Map<String,dynamic> map,String uid){
        fire_message.doc(uid).set(map);
    }

    // Ajouter une conversation
    addConversation(Map<String,dynamic> map,String uid){
        fire_conversation.doc(uid).set(map);
    }

    // fonction pour s'inscrire
    Future Inscription(String prenom , String nom , String mail , String password) async {
        UserCredential result = await auth.createUserWithEmailAndPassword(email: mail, password: password);
        String uid = result.user!.uid;
        Map<String,dynamic> map = {
            "PRENOM" : prenom,
            "NOM" : nom,
            "MAIL": mail,
        };
        addUser(uid, map);
        DocumentSnapshot snapshot = await fireUser.doc(uid).get();
        return Utilisateur(snapshot);

    }


    //Fonction pour se conneter
    Future <Utilisateur> Connexion( String mail , String password) async {
        UserCredential result = await auth.signInWithEmailAndPassword(email: mail, password: password);
        String uid = result.user!.uid;
        DocumentSnapshot snapshot = await fireUser.doc(uid).get();
        return Utilisateur(snapshot);
    }


    //Créer un utilisateur dans la base donnée
    addUser(String uid , Map<String,dynamic> map){
        fireUser.doc(uid).set(map);
    }


    //Mettre à jour l'utilisateur
    updateUser(String uid , Map<String,dynamic> map){
        fireUser.doc(uid).update(map);
    }


    deconnexion(){
        auth.signOut();
    }


    //Stocker image
    Future <String> stockageImage(String nameImage,Uint8List data) async{
        String urlChemin = "";
        //Stocker l'image
        TaskSnapshot download = await storage.ref("image/$nameImage").putData(data);
        //Récupper le lien de l'image
        urlChemin = await download.ref.getDownloadURL();
        return urlChemin;
    }

}