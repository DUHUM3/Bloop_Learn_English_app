import 'package:flutter/material.dart';
// import 'package:tb/Screens/widgets/ErrorMessage.dart';

class ChoiceQuestion extends StatefulWidget {
  final List<String> answers;
  final int correctAnswerIndex; // فهرس الإجابة الصحيحة
  final VoidCallback onNext;

  ChoiceQuestion({
    required this.answers,
    required this.correctAnswerIndex,
    required this.onNext,
  });

  @override
  _ChoiceQuestionState createState() => _ChoiceQuestionState();
}

class _ChoiceQuestionState extends State<ChoiceQuestion> {
  bool isCorrect = false; // لحفظ حالة الإجابة (صحيحة أو خاطئة)
  String message = '';

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == widget.correctAnswerIndex) {
      setState(() {
        isCorrect = true;
        message = 'إجابة صحيحة!';
      });
      widget.onNext(); // الانتقال إلى السؤال التالي إذا كانت الإجابة صحيحة

      // عرض SnackBar مع رسالة الإجابة الصحيحة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('إجابة صحيحة!')),
      );
    } else {
      setState(() {
        isCorrect = false;
        message = 'إجابة خاطئة! حاول مجدداً.';
      });

      // عرض SnackBar مع رسالة الإجابة الخاطئة
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('إجابة خاطئة! حاول مجدداً.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end, // محاذاة الأزرار للأسفل
      children: [
        // عرض الإجابات كأزرار في صف واحد
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // توزيع الأزرار بشكل متساوٍ
          children: widget.answers.map((answer) {
            int index = widget.answers.indexOf(answer);
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0288D1),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              onPressed: () => checkAnswer(index), // تحقق من الإجابة عند الضغط
              child: Text(answer, textAlign: TextAlign.center),
            );
          }).toList(),
        ),
        SizedBox(height: 20), // إضافة مسافة بين الأزرار وأي عنصر آخر أسفلها
      ],
    );
  }
}
