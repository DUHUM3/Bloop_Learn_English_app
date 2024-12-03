import 'package:flutter/material.dart';

class FillBlankQuestion extends StatelessWidget {
  final String correctAnswer;
  final String translation;
  final VoidCallback onNext;

  FillBlankQuestion({required this.correctAnswer, required this.translation, required this.onNext});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'أدخل الإجابة',
            hintStyle: TextStyle(color: Colors.white), // تغيير لون النص المساعد
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white), // تغيير لون الحدود عند التحديد
            ),
          ),
          style: TextStyle(color: Colors.white), // تغيير لون النص داخل الحقل
        ),
        SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0288D1),
            foregroundColor: Colors.white, // تغيير لون نص الزرار
          ),
          onPressed: () {
            if (controller.text.trim() == correctAnswer) {
              onNext();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('إجابة خاطئة')),
              );
            }
          },
          child: Text('تحقق من الإجابة'),
        ),
      ],
    );
  }
}
