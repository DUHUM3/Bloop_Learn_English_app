import 'package:flutter/material.dart';
import 'package:tb/Grammar/PresentSimpleScreen.dart';

class TensesOverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1F23),
      appBar: AppBar(
        title: Text(
          "Tenses Overview",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2C3A47),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Beginner Section
          _sectionTitle("Beginner"),
          _tenseCard(
            context,
            "Present Simple",
            "Basic daily habits and facts.",
            Colors.green,
            PresentSimpleLesson(), // تحديد الصفحة المستهدفة
          ),
          _tenseCard(
            context,
            "Past Simple",
            "Describing completed actions.",
            Colors.green,
            PastSimplePage(), // تحديد الصفحة المستهدفة
          ),
          _tenseCard(
            context,
            "Future Simple",
            "Talking about future plans.",
            Colors.green,
            PresentSimpleLesson(), // تحديد الصفحة المستهدفة
          ),

          const SizedBox(height: 20),

          // Intermediate Section
          _sectionTitle("Intermediate"),
          _tenseCard(
            context,
            "Present Continuous",
            "Actions happening now.",
            Colors.orange,
            PresentSimpleLesson(),
          ),
          _tenseCard(
            context,
            "Past Continuous",
            "Actions happening in the past.",
            Colors.orange,
            PresentSimpleLesson(),
          ),
          _tenseCard(
            context,
            "Future Continuous",
            "Actions ongoing in the future.",
            Colors.orange,
            PresentSimpleLesson(),
          ),

          const SizedBox(height: 20),

          // Advanced Section
          _sectionTitle("Advanced"),
          _tenseCard(
            context,
            "Present Perfect",
            "Actions with relevance to now.",
            Colors.red,
            PresentSimpleLesson(),
          ),
          _tenseCard(
            context,
            "Past Perfect",
            "Actions completed before another past action.",
            Colors.red,
            PresentSimpleLesson(),
          ),
          _tenseCard(
            context,
            "Future Perfect",
            "Actions completed before a specific future point.",
            Colors.red,
            PresentSimpleLesson(),
          ),
        ],
      ),
    );
  }

  // Title for each section
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Card for each tense
  Widget _tenseCard(
      BuildContext context, String tense, String description, Color color, Widget targetPage) {
    return Card(
      color: color.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        title: Text(
          tense,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
        ),
        subtitle: Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.white70),
        ),
        trailing: Icon(Icons.arrow_forward, color: color),
        onTap: () {
          // Navigate to the specified page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
      ),
    );
  }
}

// Mock Pages for Each Tense
class PresentSimplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _mockLessonPage("Present Simple");
  }
}

class PastSimplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _mockLessonPage("Past Simple");
  }
}

class FutureSimplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _mockLessonPage("Future Simple");
  }
}

// You can create additional classes for each tense page following the above structure

// Mock lesson page (Reusable for all tenses)
Widget _mockLessonPage(String tense) {
  return Scaffold(
    appBar: AppBar(
      title: Text(tense),
      backgroundColor: const Color(0xFF2C3A47),
    ),
    body: Center(
      child: Text(
        "Details about $tense.",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    ),
  );
}
