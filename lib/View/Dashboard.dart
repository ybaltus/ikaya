import 'package:ikaya/Fonctions/FirestoreHelper.dart';
import 'package:ikaya/View/AllUsers.dart';
import 'package:ikaya/View/MyConversations.dart';
import 'package:ikaya/View/MyUsers.dart';
import 'package:ikaya/main.dart';
import 'package:flutter/material.dart';
class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState()=> DashboardState();
}

class DashboardState extends State<Dashboard>{
  int selected = 0;
  PageController controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context){
    return Scaffold(

        appBar : AppBar(
            title : const Text("Accueil - Ikaya"),
            actions: [
            IconButton(onPressed: (){
                FirestoreHelper().deconnexion();
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                        return const MyHomePage(title: "");
                    }
                ));

            },
                icon: const Icon(Icons.exit_to_app ,color: Colors.red,)
            )
          ],
        ),
        body : bodyPage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected,
        onTap: (newValue){
          setState(() {
            selected = newValue;
            controller.jumpToPage(newValue);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            label: "Utilisateurs"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
            label : "Paramètres"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label : "Messagerie"
          )
        ],
      ),
    );
  }

  Widget bodyPage(){
    return PageView(
      onPageChanged: (value){
        setState(() {
          selected = value;
        });
      },
      children: [
        // Afficher tous les utilisateurs
        AllUsers(),

        // Créer une page de profil
        MyUsers(),

        // Accéder à la messagerie
        MyConversations()
      ],
      controller: controller,
    );


  }

}