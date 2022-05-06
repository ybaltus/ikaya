
import 'dart:io';
import 'dart:typed_data';

import 'package:ikaya/Fonctions/FirestoreHelper.dart';
import 'package:ikaya/modelView/ImageRond.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikaya/library/lib.dart';
import 'package:file_picker/file_picker.dart';


class MyUsers extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyUsersState();
  }

}

class MyUsersState extends State<MyUsers>{
  //Variables
  String? lienImage;
  Uint8List? bytesImages;
  String? nameImage;

  /////

  //Fonctions
  RecupererImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.image
    );
    if(result != null){
      setState(() {
        nameImage = result.files.first.name;
        bytesImages = result.files.first.bytes;
      });
      popImage();
    }

  }

  popImage(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context){
          if(Platform.isIOS){
            return CupertinoAlertDialog(
              title: const Text("Souhaitez- vous avoir cette photo de profil?"),
              content : Image.memory(bytesImages!),
              actions : [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    child: const Text("Annuler")
                ),
                ElevatedButton(
                    onPressed: (){
                      //Stocker mon image dans la base de donnée
                      FirestoreHelper().stockageImage(nameImage!, bytesImages!).then((value){
                        setState(() {
                          lienImage = value;
                          MyUser.image = value;
                          Map<String,dynamic> map ={
                            "IMAGE": lienImage,
                          };
                          FirestoreHelper().updateUser(MyUser.uid, map);
                          Navigator.pop(context);
                        });
                      });
                    },
                    child: const Text("Ok")
                ),
              ]
            );
          }
          else
            {
              return AlertDialog(
                  title: const Text("Souhaitez- vous avoir cette photo de profil?"),
                  content : Image.memory(bytesImages!),
                  actions : [
                    ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler")
                    ),
                    ElevatedButton(
                        onPressed: (){
                            //Stocker mon image dans la base de donnée
                            FirestoreHelper().stockageImage(nameImage!, bytesImages!).then((value){
                                setState(() {
                                    lienImage = value;
                                    MyUser.image = value;
                                    
                                    Map<String,dynamic> map ={
                                        "IMAGE": lienImage,
                                    };
                                    FirestoreHelper().updateUser(MyUser.uid, map);
                                    Navigator.pop(context);
                                });
                            });
                        },
                        child: const Text("Valider")
                    ),
                  ]

              );
            }

        }
    );
  }




  /////
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(20),
      child: bodyPage(),
    );
      
  }


  Widget bodyPage(){
    return Column(
      children: [
        //Logo de moi
        InkWell(
          child: ImageRond(image: MyUser.image,size: 150,),
          onTap: (){
            print("J'ai appuyer sur l'image");
            RecupererImage();
          },
        ),



        //NOm et prénom
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                decoration: InputDecoration(
                  hintText: MyUser.prenom,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  )
                ),
                onChanged: (newValue){
                  setState(() {
                    MyUser.prenom = newValue;
                  });

                },
              ),
            ),

            IconButton(
                onPressed: (){
                  Map<String,dynamic> map ={
                    "PRENOM": MyUser.prenom,
                  };
                  FirestoreHelper().updateUser(MyUser.uid, map);

                },
                icon: const Icon(Icons.edit)
            ),
          ],
        ),
        const SizedBox(height: 10,),


        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: TextField(
                decoration: InputDecoration(
                    hintText: MyUser.nom,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    )
                ),
                onChanged: (newValue){
                  setState(() {
                    MyUser.nom = newValue;
                  });

                },
              ),
            ),

            IconButton(
                onPressed: (){
                  Map<String,dynamic> map ={
                    "NOM": MyUser.nom,
                  };
                  FirestoreHelper().updateUser(MyUser.uid, map);
                },
                icon: const Icon(Icons.edit)
            ),
          ],
        ),
        const SizedBox(height: 10,),


        Text(MyUser.mail)

        // adresse mail
      ],
    );
  }

}