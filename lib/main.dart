import 'package:flutter/material.dart';
import 'package:tb/Grammar/AllGrammarScreen.dart';
import 'package:tb/Grammar/PresentSimpleScreen.dart';
import 'package:tb/Reading/HomeScreen.dart';
import 'package:tb/Screens/HomeScreen.dart';
import 'package:tb/Screens/LevelScreen.dart';
import 'package:tb/Screens/QuizScreen.dart';
import 'package:tb/Screens/SplashScreen.dart';

void main() => runApp(MyApp(
  
));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/Home': (context) => HomeScreen(),
        '/level': (context) => LevelStepperPage(),
        '/quiz': (context) => QuizScreen(),
        '/PresentSimple': (context) => TensesOverviewPage(),
        '/reading': (context) => StoryPage(),


      },
    );
  }
}
