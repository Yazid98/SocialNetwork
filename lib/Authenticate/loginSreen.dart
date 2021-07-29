import 'package:flutter/material.dart';
import 'package:insta_projet_master1/Service/Auth_Service.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController =   TextEditingController();
  TextEditingController _passwordController =   TextEditingController();
  bool circular = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Connexion",
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Text("Connectez vous à votre compte",
                      style: TextStyle(
                          fontSize: 15,
                          color:Colors.grey[700]),)
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      inputFile("Email", _emailController, false),
                      inputFile("Mot de passe", _passwordController, true),
                    ],
                  ),
                ),
                Padding(padding:
                EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration:
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () => signIn(),
                      color: Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        "Se connecter", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Pas de compte chez nous?"),
                    Text(" Inscrivez vous!", style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.png"),
                        fit: BoxFit.fitHeight
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget inputFile(label, TextEditingController controller, bool obscureText)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color:Colors.black87
          ),
        ),
        SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0,
                  horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),

              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  void signIn() async {
    try {
      firebase_auth.UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
      print(userCredential.user!.email);
      setState(() {
        circular = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomeScreen()),
              (route) => false);
    }catch(e){
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      setState(() {
        circular = false;
      });
    }
  }
}

