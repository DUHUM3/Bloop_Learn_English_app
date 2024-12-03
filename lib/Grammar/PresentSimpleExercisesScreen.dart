import 'package:flutter/material.dart';

class InteractiveExercisesPage extends StatefulWidget {
  const InteractiveExercisesPage({super.key});

  @override
  _InteractiveExercisesPageState createState() =>
      _InteractiveExercisesPageState();
}

class _InteractiveExercisesPageState extends State<InteractiveExercisesPage> {
  final List<Question> questions = [
    Question(
      type: QuestionType.chooseCorrectSentence,
      questionText: "1. Which sentence is in Present Simple?",
      options: [
        "A. She is studying now.",
        "B. They play football every weekend.",
        "C. I will call you tomorrow."
      ],
      correctOptionIndex: 1,
    ),
    Question(
      type: QuestionType.fillInTheBlank,
      questionText: "2. Fill in the blank: He ____ (like) pizza.",
      correctAnswer: "likes",
    ),
    Question(
      type: QuestionType.rearrangeSentence,
      questionText: "3. Rearrange the words to make a sentence: plays / John / football / every day.",
      correctAnswer: "John plays football every day.",
    ),
    Question(
      type: QuestionType.correctTheSentence,
      questionText: "4. Correct the sentence: She do not likes apples.",
      correctAnswer: "She does not like apples.",
    ),
  ];

  int currentQuestionIndex = 0;
  List<String?> userAnswers = [];

  @override
  void initState() {
    super.initState();
    userAnswers = List<String?>.filled(questions.length, null);
  }

  void nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      _showScore();
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _showScore() {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (questions[i].isAnswerCorrect(userAnswers[i])) {
        score++;
      }
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2C3A47),
        title: const Text(
          "Your Score",
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          "You got $score out of ${questions.length} correct!",
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "OK",
              style: TextStyle(color: Color(0xFF4FC3F7)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF1B1F23),
      appBar: AppBar(
        title: const Text(
          "Present Simple Exercises",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2C3A47),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: QuestionWidget(
                question: currentQuestion,
                userAnswer: userAnswers[currentQuestionIndex],
                onAnswerChanged: (answer) {
                  setState(() {
                    userAnswers[currentQuestionIndex] = answer;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentQuestionIndex > 0)
                  ElevatedButton(
                    onPressed: previousQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4FC3F7),
                    ),
                    child: const Text("Previous"),
                  ),
                ElevatedButton(
                  onPressed: nextQuestion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4FC3F7),
                  ),
                  child: Text(currentQuestionIndex < questions.length - 1
                      ? "Next"
                      : "Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// أنواع الأسئلة
enum QuestionType {
  chooseCorrectSentence,
  fillInTheBlank,
  rearrangeSentence,
  correctTheSentence,
}

// نموذج السؤال
class Question {
  final QuestionType type;
  final String questionText;
  final List<String>? options; // فقط لاختيار الجملة الصحيحة
  final String correctAnswer;
  final int? correctOptionIndex;

  Question({
    required this.type,
    required this.questionText,
    this.options,
    this.correctOptionIndex,
    this.correctAnswer = '',
  });

  bool isAnswerCorrect(String? answer) {
    if (type == QuestionType.chooseCorrectSentence) {
      return options?[correctOptionIndex ?? -1] == answer;
    }
    return correctAnswer.toLowerCase().trim() ==
        (answer ?? '').toLowerCase().trim();
  }
}

// ويدجت السؤال
class QuestionWidget extends StatelessWidget {
  final Question question;
  final String? userAnswer;
  final ValueChanged<String?> onAnswerChanged;

  const QuestionWidget({super.key, 
    required this.question,
    required this.userAnswer,
    required this.onAnswerChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (question.type == QuestionType.chooseCorrectSentence) {
      return _buildMultipleChoice();
    } else if (question.type == QuestionType.fillInTheBlank) {
      return _buildFillInTheBlank();
    } else if (question.type == QuestionType.rearrangeSentence) {
      return _buildFillInTheBlank();
    } else if (question.type == QuestionType.correctTheSentence) {
      return _buildFillInTheBlank();
    }
    return const SizedBox.shrink();
  }

  Widget _buildMultipleChoice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.questionText,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        ...question.options!.map((option) {
          return RadioListTile<String>(
            value: option,
            groupValue: userAnswer,
            onChanged: onAnswerChanged,
            title: Text(option, style: const TextStyle(color: Colors.white)),
            activeColor: const Color(0xFF4FC3F7),
          );
        }),
      ],
    );
  }

  Widget _buildFillInTheBlank() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question.questionText,
          style: const TextStyle(fontSize: 18, color: Colors.white),
        ),
        TextField(
          onChanged: onAnswerChanged,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            filled: true,
            fillColor: Color(0xFF2C3A47),
            border: OutlineInputBorder(),
            hintText: "Type your answer",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InteractiveExercisesPage(),
    theme: ThemeData.dark(),
  ));
}
