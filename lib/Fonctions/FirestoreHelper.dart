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



    //Méthodes

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