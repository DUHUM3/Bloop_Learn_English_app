import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> questions = [
    // أسئلة سهلة
    {
      "question": "Translate: Apple",
      "options": ["Orange", "تفاحة", "مانجو", "أناناس"],
      "answer": 1,
      "level": "easy",
    },
    {
      "question": "What is the plural of 'book'?",
      "options": ["Books", "Book's", "Booke", "Book"],
      "answer": 0,
      "level": "easy",
    },
    // أسئلة متوسطة
    {
      "question": "Translate: I am happy.",
      "options": ["أنا سعيد", "أنا حزين", "أنا مريض", "أنا مشغول"],
      "answer": 0,
      "level": "medium",
    },
    {
      "question": "Choose the correct verb: He _____ to school.",
      "options": ["go", "goes", "gone", "going"],
      "answer": 1,
      "level": "medium",
    },
    // أسئلة صعبة
    {
      "question": "Choose the synonym for 'beautiful':",
      "options": ["Ugly", "Attractive", "Happy", "Lazy"],
      "answer": 1,
      "level": "hard",
    },
    {
      "question": "What is the meaning of 'phenomenon'?",
      "options": ["حدث", "ظاهرة", "نتيجة", "تجربة"],
      "answer": 1,
      "level": "hard",
    },
  ];

  int currentQuestionIndex = 0;
  int score = 0;

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == questions[currentQuestionIndex]['answer']) {
      score++;
      setState(() {
        currentQuestionIndex++;
      });
      if (currentQuestionIndex >= questions.length) {
        Navigator.pushReplacementNamed(context, '/result', arguments: score);
      }
    } else {
      // إذا كانت الإجابة خاطئة، نعرض رسالة في أسفل الشاشة باستخدام SnackBar مع زر "فهمت"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Incorrect Answer ❌",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              Text(
                "The correct answer is: ${questions[currentQuestionIndex]['options'][questions[currentQuestionIndex]['answer']]}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Color(0xFF2C3A47), // نفس خلفية الـ AppBar
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4), // مدة عرض الرسالة
          action: SnackBarAction(
            label: 'Understood',  // نص الزر
            textColor: Colors.white,
            onPressed: () {
              // عند الضغط على الزر، نقوم بإغلاق الرسالة
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1F23), // خلفية أغمق قليلاً
      appBar: AppBar(
        title: const Text(
          "English Quiz",
          style: TextStyle(color: Colors.white), // تغيير لون النص إلى الأبيض
        ),
        backgroundColor: const Color(0xFF2C3A47), // لون شريط التطبيق
      ),
      body: currentQuestionIndex < questions.length
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // شريط التقدم
                  LinearProgressIndicator(
                    value: (currentQuestionIndex + 1) / questions.length,
                    backgroundColor: Colors.grey[300],
                    color: questions[currentQuestionIndex]['level'] == 'easy'
                        ? const Color(0xFF4FC3F7)
                        : (questions[currentQuestionIndex]['level'] == 'medium'
                            ? Colors.orange
                            : Colors.red),
                  ),
                  const SizedBox(height: 20),
                  // عرض المستوى
                  Text(
                    "Level: ${questions[currentQuestionIndex]['level'].toUpperCase()}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(height: 20),
                  // عرض السؤال
                  Text(
                    "Question ${currentQuestionIndex + 1}: ${questions[currentQuestionIndex]['question']}",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  // خيارات الإجابة
                  Expanded(
                    child: ListView.builder(
                      itemCount:
                          questions[currentQuestionIndex]['options'].length,
                      itemBuilder: (context, index) => Card(
                        color: const Color(0xFF4FC3F7), // لون الإجابات مثل الأيقونات
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5, // لإضافة الظل
                        child: ListTile(
                          title: Text(
                            questions[currentQuestionIndex]['options'][index],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          onTap: () => _answerQuestion(index),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
