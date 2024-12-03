import 'package:flutter/material.dart';
import 'package:tb/Grammar/PresentSimpleExercisesScreen.dart';

class PresentSimpleLesson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1F23),
      appBar: AppBar(
        title: Text(
          "Present Simple",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2C3A47),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title Section
                  Center(
                    child: Column(
                      children: [
                        Text(
                          "Present Simple Tense",
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4FC3F7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Explanation Section
                  _sectionHeader("Explanation"),
                  const SizedBox(height: 10),
                  BulletPoint(
                      text: "General facts, e.g., The sun rises in the east."),
                  BulletPoint(
                      text: "Daily habits, e.g., She drinks coffee every morning."),
                  BulletPoint(
                      text: "Schedules, e.g., The train leaves at 8 PM."),

                  const SizedBox(height: 20),

                  // Form Section
                  _sectionHeader("Form"),
                  const SizedBox(height: 10),
                  BulletPoint(
                      text:
                          "Affirmative: Subject + Base Verb (+s/es for he/she/it).\nExample: He plays football."),
                  BulletPoint(
                      text:
                          "Negative: Subject + Do/Does not + Base Verb.\nExample: They do not (don't) like pizza."),
                  BulletPoint(
                      text:
                          "Question: Do/Does + Subject + Base Verb?\nExample: Does she work here?"),

                  const SizedBox(height: 20),

                  // Examples Section
                  _sectionHeader("Examples"),
                  const SizedBox(height: 10),
                  _exampleRow(
                      icon: Icons.sunny, text: "I eat breakfast every day."),
                  _exampleRow(
                      icon: Icons.school, text: "She studies English every evening."),
                  _exampleRow(
                      icon: Icons.train, text: "The train leaves at 7 PM."),
                ],
              ),
            ),
          ),

          // Start Exercises Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InteractiveExercisesPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4FC3F7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              ),
              icon: Icon(Icons.play_arrow, color: Colors.white, size: 28),
              label: Text(
                "Start Exercises",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Section Header Widget
  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4FC3F7),
      ),
    );
  }

  // Example Row Widget
  Widget _exampleRow({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF4FC3F7), size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Bullet Point Widget
class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
