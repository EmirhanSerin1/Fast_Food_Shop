import 'package:fast_food_shop/providers/quantity.dart';
import 'package:fast_food_shop/providers/search_provider.dart';
import 'package:fast_food_shop/screens/authentication/login/login_screen.dart';
import 'package:fast_food_shop/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => Quantity(),
      ),
      ChangeNotifierProvider(
        create: (_) => SearchProvider(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crazy Fast Food',
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
