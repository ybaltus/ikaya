import 'package:flutter/material.dart';

class ErrorDialogHelper {
  DialogErrorAuth(String type, context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return
            (type == 'connexion') ?
            AlertDialog(
              title: Text("Erreur"),
              content: Text("Votre addresse mail ou votre mot de passe a été mal saisie."),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("OK")
                )
              ],
            ):
          AlertDialog(
            title: Text("Erreur"),
            content: Text("Votre inscription ne s'est pas effectuée correctement."),
            actions: [
              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: const Text("OK")
              )
            ],
          );
        }
    );
  }

  DialogErrorMedia(String type, context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context){
          return
            (type == 'image') ?
            AlertDialog(
              title: Text("Erreur"),
              content: Text("Il y a une erreur sur l'image."),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("OK")
                )
              ],
            ):
            AlertDialog(
              title: Text("Erreur"),
              content: Text("Une erreur est survenu pour l'ajout du fichier"),
              actions: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("OK")
                )
              ],
            );
        }
    );
  }
}