import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Authenticate/loginSreen.dart';
import 'Authenticate/signUpScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.blueAccent,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Bienvenue",
                      style:
                      TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Bienvenue dans notre super application développé en flutter !",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/welcome.png")
                      )
                  ),
                ),

                Column(
                    children: <Widget>[
                      //The Login Button
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        //defining the shape
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Colors.black
                            ),
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: Text(
                          "Connexion",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      //SignUp Button
                      SizedBox(height: 20,),
                      MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen() ));

                          },
                          color: Color(0xff0095ff),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            "Inscription",
                            style:
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          )
                      )

                    ]
                )

              ],
            ),
          ),
        ),

      )
    );
  }
}
