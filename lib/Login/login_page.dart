
import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushNamed(context, '/homepage');
      }
    });
    }



  var _emailController = new TextEditingController();
  var _passController = new TextEditingController();
  var _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      body:  formu(),
    )
    ;
  }



  Future<void> _signInWithEmailAndPasword() async {
    try {
      User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passController.text,
      )).user!;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }


  Future<Widget> verify() async {
    return Card(child: Text('lacard'),);

  }



  Widget formu(){
    return Center(
      child: SizedBox(
        height: 250,
        width: 280,
        child: Card(
          //color: Colors.white,
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),

          ),
          child: Padding(padding: EdgeInsets.all(8),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('BananosApp WEB', style: Theme.of(context).textTheme.headline6,),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        labelText: 'Email:',
                        hintText: 'email@email.com'

                    ),

                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (String? value){
                      return (value != null && !value.contains('@')) ? 'Ingresar email correcto' : null;
                    },
                  ),

                  TextFormField(
                    obscureText: true,
                    controller: _passController,
                    decoration: const InputDecoration(
                      labelText: 'Password:',
                    ),
                    autovalidateMode: AutovalidateMode.disabled,
                    validator: (String? value){
                      return (value != null) ? "Ingresar password" : null;
                    },
                  ),

                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      /* ElevatedButton(
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
                            onPressed: (){

                              Navigator.of(context).pushNamed("/registerpage");
                              //_formKey.currentState.validate();
                            },
                            child: Row(children: [
                              Text('CREAR USUARIO')
                            ],)),
*/
                      ElevatedButton(
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
                          onPressed: () async{

                            await _signInWithEmailAndPasword();

                            /* _formKey.currentState.validate();
                              if(_formKey.currentState.validate()){
                                //onAlertWait(context);
                                List<dynamic> results = await
                                Provider.of<Authentication>(context,
                                    listen: false).loginWithErrorMessage(_emailController.text, _passController.text);
                                if(results[0] == "success"){
                                  Provider.of<User>(context, listen: false).setFromMap(results[1]);
                                  Navigator.of(context).pushNamed("/homepage");
                                }else{
                                  onErrorAuth(context, results[0]);
                                }
                              }*/




                          },


                          child: Row(children: [
                            Text('INGRESAR')
                          ],)),
                    ],
                  )

                ],
              ),
            ),
          ),

        ),        ),
    );
  }



}
