import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noteworthy/on_generate_route.dart';

import 'firebase_options.dart';
import 'injection_container.dart' as dI;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dI.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteWorthy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      initialRoute: '/',
      onGenerateRoute:OnGenerateRoute.route ,
      routes: {
        "/": (context){
          return Container();
        }
      },
    );
  }
}

