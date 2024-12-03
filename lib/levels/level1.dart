// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';

// class HeartsWidget extends StatefulWidget {
//   final int hearts; // إضافة المتغير هنا ليكون قابل للتمرير

//   const HeartsWidget({Key? key, required this.hearts}) : super(key: key);

//   @override
//   _HeartsWidgetState createState() => _HeartsWidgetState();
// }

// class _HeartsWidgetState extends State<HeartsWidget> {
//   late int hearts; // استخدام المتغير الممرر من الويدجت
//   late DateTime lastUpdatedTime; // وقت آخر تحديث
//   String message = ''; // لعرض الرسالة في حال مرور 4 ساعات

//   @override
//   void initState() {
//     super.initState();
//     hearts = widget.hearts; // تعيين القيمة من الويدجت
//     _loadHearts(); // تحميل عدد القلوب من SharedPreferences عند بدء التطبيق
//   }

//   // تحميل عدد القلوب ووقت آخر تعديل من SharedPreferences
//   Future<void> _loadHearts() async {
//     final prefs = await SharedPreferences.getInstance();

//     // تحميل عدد القلوب من SharedPreferences
//     setState(() {
//       hearts = prefs.getInt('hearts') ?? 7; // في حالة عدم وجود قيمة، تأخذ القيمة الافتراضية 7
//     });

//     // تحميل وقت آخر تعديل
//     final lastTime = prefs.getString('lastUpdatedTime');
//     if (lastTime != null) {
//       lastUpdatedTime = DateTime.parse(lastTime);
//     } else {
//       lastUpdatedTime = DateTime.now(); // تعيين الوقت الحالي إذا لم يكن هناك وقت مسجل
//     }

//     // التحقق من مرور 4 ساعات منذ آخر تحديث
//     _checkHeartsExpiration();
//   }

//   // حفظ عدد القلوب ووقت آخر تعديل في SharedPreferences
//   Future<void> _saveHearts() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setInt('hearts', hearts); // حفظ القيمة
//     prefs.setString('lastUpdatedTime', DateTime.now().toIso8601String()); // حفظ وقت التحديث
//   }

//   // زيادة عدد القلوب
//   void _increaseHearts() {
//     setState(() {
//       hearts++;
//     });
//     _saveHearts(); // حفظ القيمة بعد التعديل
//   }

//   // التحقق من مرور 4 ساعات وتحديث القلوب إذا لزم الأمر
//   void _checkHeartsExpiration() {
//     final now = DateTime.now();
//     final difference = now.difference(lastUpdatedTime);

//     // إذا كانت الفترة أقل من 4 ساعات، لا نعيد تعيين القلوب
//     if (difference.inHours >= 4) {
//       setState(() {
//         hearts = 7; // إعادة تعيين القلوب إلى 7 بعد مرور 4 ساعات
//         message = 'It has been more than 4 hours. Your hearts have been reset to 7.';
//       });
//       _saveHearts(); // حفظ القيم الجديدة
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.favorite, color: Colors.red),
//             SizedBox(width: 5),
//             Text(
//               '$hearts', // عرض عدد القلوب
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         if (message.isNotEmpty)
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               message, 
//               style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
//             ),
//           ),
//         if (hearts > 0) 
//           ElevatedButton(
//             onPressed: _increaseHearts, // زيادة القلوب عند الضغط
//             child: Text("Increase Hearts"),
//           ),
//       ],
//     );
//   }
// }

// // شاشة التمارين
// class Level1 extends StatefulWidget {
//   final Function onLevelComplete; // معلمة لتحديد متى يكتمل المستوى

//   Level1({required this.onLevelComplete});

//   @override
//   _Level1State createState() => _Level1State();
// }

// class _Level1State extends State<Level1> {
//   final List<Map<String, dynamic>> _questions = [
//     {
//       'question': 'What is the capital of France?',
//       'options': ['Paris', 'London', 'Berlin', 'Madrid'],
//       'correctAnswer': 'Paris',
//       'type': 'multipleChoice',
//     },
//     {
//       'question': '_____ is the largest planet in our solar system.',
//       'correctAnswer': 'Jupiter',
//       'type': 'fillInTheBlank',
//     },
//     {
//       'question': 'The Earth is flat. (True/False)',
//       'correctAnswer': 'False',
//       'type': 'trueFalse',
//     },
//     {
//       'question': 'Arrange the words to form a correct sentence: "is / My / name / John"',
//       'correctAnswer': 'My name is John',
//       'type': 'wordScramble',
//     },
//   ];

//   int _currentQuestionIndex = 0;
//   String _selectedAnswer = '';
//   String _resultMessage = '';
//   TextEditingController _textController = TextEditingController();

//   // دالة للتحقق من الإجابة
//   void _checkAnswer(String answer) async {
//     final prefs = await SharedPreferences.getInstance();
//     int hearts = prefs.getInt('hearts') ?? 7; // استرجاع عدد القلوب

//     setState(() {
//       if (answer == _questions[_currentQuestionIndex]['correctAnswer']) {
//         _resultMessage = 'Correct!';
//       } else {
//         _resultMessage = 'Incorrect! Try again.';
//         if (hearts > 0) {
//           hearts--; // خصم قلب عند الإجابة غير الصحيحة
//           prefs.setInt('hearts', hearts); // حفظ القلوب بعد التعديل
//         }
//       }

//       // الانتقال للسؤال التالي بعد فترة
//       Future.delayed(Duration(seconds: 2), () {
//         setState(() {
//           if (_currentQuestionIndex < _questions.length - 1) {
//             _currentQuestionIndex++;
//             _selectedAnswer = '';
//             _resultMessage = '';
//             _textController.clear();
//           } else {
//             // إتمام المستوى الأول
//             widget.onLevelComplete(); // إتمام المستوى الأول
//             Navigator.pop(context); // العودة إلى شاشة المستويات
//           }
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final question = _questions[_currentQuestionIndex];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Level 1 - English Exercises'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             HeartsWidget(hearts: 7), // تمرير القيمة الثابتة للقلوب هنا
//             SizedBox(height: 20),
//             Text(
//               'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             Text(
//               question['question'],
//               style: TextStyle(fontSize: 22),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             if (question['type'] == 'multipleChoice') 
//               ...question['options'].map<Widget>((option) {
//                 return RadioListTile<String>(
//                   title: Text(option),
//                   value: option,
//                   groupValue: _selectedAnswer,
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedAnswer = value!;
//                     });
//                   },
//                 );
//               }).toList(),

//             if (question['type'] == 'fillInTheBlank') 
//               TextField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   hintText: 'Type your answer here',
//                 ),
//               ),

//             if (question['type'] == 'trueFalse') 
//               Row(
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _checkAnswer('True');
//                       },
//                       child: Text('True'),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         _checkAnswer('False');
//                       },
//                       child: Text('False'),
//                     ),
//                   ),
//                 ],
//               ),

//             if (question['type'] == 'wordScramble') 
//               TextField(
//                 controller: _textController,
//                 decoration: InputDecoration(
//                   hintText: 'Type the correct sentence',
//                 ),
//               ),

//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 String answer = '';
//                 if (question['type'] == 'multipleChoice' && _selectedAnswer.isNotEmpty) {
//                   answer = _selectedAnswer;
//                 } else if (question['type'] == 'fillInTheBlank' && _textController.text.isNotEmpty) {
//                   answer = _textController.text;
//                 } else if (question['type'] == 'trueFalse') {
//                   return;
//                 } else if (question['type'] == 'wordScramble' && _textController.text.isNotEmpty) {
//                   answer = _textController.text;
//                 }

//                 if (answer.isNotEmpty) {
//                   _checkAnswer(answer);
//                 }
//               },
//               child: Text('Submit'),
//             ),
//             SizedBox(height: 20),
//             Text(
//               _resultMessage,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: _resultMessage == 'Correct!' ? Colors.green : Colors.red,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
