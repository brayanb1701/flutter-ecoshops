import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecoshops/services/services.dart';
import 'package:flutter_ecoshops/src/pages/loading_screen.dart';
import 'package:flutter_ecoshops/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_ecoshops/theme.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsService()),
        ChangeNotifierProvider(create: (_) => CategoriesService()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => OrderService()),
        ChangeNotifierProvider(create: (_) => EntrepreneurshipService()),
      ],
      child: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MyApp();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return MaterialApp(
            home: LoadingScreen(),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecoshops",
      theme: theme(),
      //ThemeData(
      //textTheme:
      //  GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
      //),
      debugShowCheckedModeBanner: false,

      //Routing
      //initialRoute: "products",
      initialRoute: "login",
      routes: getApplicationRoutes(),
    );
  }
}
