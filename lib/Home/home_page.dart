import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:webbanana/constants.dart';
import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushNamedAndRemoveUntil(context, '/loginpage', (route) => false,);
      } else {
        print('User is signed in!');
       // Navigator.pushNamed(context, '/homepage');
      }
    });
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('posts').snapshots();






  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: 1,
     child: Scaffold(

      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          ],
          body: TabBarView(children: [
            card(context),
        ],
      ),
      )

    ));
  }


  Widget card(BuildContext context){
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError){
            return Text('Paso algo malo');
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return Text("Cargando");
          }

          return ListView(

            children: snapshot.data!.docs.map((DocumentSnapshot document) {
             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
             print(data['title']);
             return Card(
               color: primaryColor,
               child: ListTile(
                 onTap: (){},
                 leading: Icon(Icons.email),
                 title: Text(data['title'], style: TextStyle(color: Colors.white)),
                 subtitle: Text(data['description'], style: TextStyle(color: Colors.white)),
               ),
             );
           }).toList(),
          );
        }
    );

  }


}
