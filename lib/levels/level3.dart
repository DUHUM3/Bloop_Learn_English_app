//  import 'package:flutter/material.dart';

// void main() => runApp(Level3());

// class Level3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FillBlankScreen(),
//     );
//   }
// }

// class FillBlankScreen extends StatefulWidget {
//   @override
//   _FillBlankScreenState createState() => _FillBlankScreenState();
// }

// class _FillBlankScreenState extends State<FillBlankScreen> {
//   String selectedOption = '';
//   String correctAnswer = 'is';

//   void checkAnswer() {
//     if (selectedOption == correctAnswer) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('إجابة صحيحة! ممتاز 🎉')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('إجابة خاطئة! حاول مرة أخرى.')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         title: Text('املأ ', style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Text(
//               'املأ الفراغ',
//               style: TextStyle(color: Colors.yellow, fontSize: 22),
//             ),
//             SizedBox(height: 20),
//             Container(
//               padding: EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[800],
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'The boy ______ tired.',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             Column(
//               children: [
//                 buildOption('are'),
//                 buildOption('is'),
//                 buildOption('am'),
//               ],
//             ),
//             Spacer(),
//             ElevatedButton(
//               onPressed: checkAnswer,
//               child: Text('متابعة'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.green,
//                 padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//               ),
//             ),
//             SizedBox(height: 10),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildOption(String text) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedOption = text;
//         });
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 8),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         decoration: BoxDecoration(
//           color: selectedOption == text ? Colors.green : Colors.grey[700],
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               text,
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
