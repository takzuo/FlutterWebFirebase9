import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webbanana/Home/home_page.dart';
import 'package:webbanana/Login/login_page.dart';
import 'package:webbanana/constants.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "laapikey",
        appId: "laappID",
        messagingSenderId: "elmessaginsenderid",
        projectId: "elprojectID",),
  );
  runApp(const MyApp());
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: LoginPage(),
    //home: RegisterPage(),
    //home: OtherPage(),
    //home: HomePage(),
    routes: {
    "/homepage" : (context) => HomePage(),
    "/loginpage" : (context) => LoginPage(),

    },
    );
  }
}

