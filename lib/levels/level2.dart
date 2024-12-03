import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:tb/widgets/AudioChoiceQuestion.dart';
import 'package:tb/widgets/ChoiceQuestion.dart';
import 'package:tb/widgets/FillBlankQuestion.dart';
import 'package:tb/widgets/ReorderQuestion.dart';

class InteractiveExerciseScreen extends StatefulWidget {
  @override
  _InteractiveExerciseScreenState createState() =>
      _InteractiveExerciseScreenState();
}

class _InteractiveExerciseScreenState extends State<InteractiveExerciseScreen> {
  late AudioPlayer _audioPlayer;
  int currentExercise = 0;

  List<Map<String, dynamic>> exercises = [
    {
      'type': 'choice',
      'title': 'اختيار الإجابة الصحيحة',
      'question': 'I ___ English',
      'answers': ['Love', 'Hate', 'Like', 'What'],
      'correct': 1,
      'audio': 'assets/sounds/I hate English.mp3',
    },
    {
      'type': 'reorder',
      'title': 'ترتيب الجملة',
      'question': 'Arrange the sentence:',
      'correctOrder': ['I', 'love', 'learning', 'English'],
      'audio': 'assets/sounds/sound.mp3',
    },
    {
      'type': 'fillBlank',
      'title': 'إكمال الجملة',
      'question': 'Age is not _____',
      'translation': 'العمر ليس مهماً',
      'correct': 'important',
      'audio': '',
    },
   {
  'type': 'reorder',  // نوع السؤال
  'title': 'ترتيب الكلمات',  // عنوان السؤال
  'question': 'رتب الجملة التالية:',  // نص السؤال
  'correctOrder': ['أحب', 'البرمجة', 'في', 'فريق'],  // ترتيب الكلمات الصحيح
  'audio': 'assets/sounds/sound.mp3',  // مسار الصوت (اختياري)
},
{
  'type': 'choice',
  'title': 'اختيار الإجابة الصحيحة',
  'question': 'The boy ___ tird',
  'answers': ['are', 'is', 'am', 'there'],
  'correct': 1, // فهرس الإجابة الصحيحة (الإجابة الصحيحة هي "Paris")
  'audio': '', // يمكنك إضافة مسار صوتي إذا كان هناك
},
//  {
//   'type': 'fillBlank',
//   'title': 'إكمال الجملة',
//   'question': 'The white shirt is _____',
//   'correct': 'dirty',  // يجب أن يكون 'dirty' هي الإجابة الصحيحة
//   'audio': '',
// },

// {
//   'type': 'reorder',  // نوع السؤال
//   'title': 'ترتيب الكلمات',  // عنوان السؤال
//   'question': 'الرجل في الحديقه',  // نص السؤال
//   'correctOrder': ['man', 'in', 'the', 'garden'],  // ترتيب الكلمات الصحيح
//   'audio': 'assets/sounds/sound.mp3',  // مسار الصوت (اختياري)
// },
   {
      'type': 'audioChoice',
      'title': 'اختيار الإجابة الصحيحة بناءً على الصوت',
      'question': 'What is the sound?',
      'answers': ['Dog Sound', 'Cat Sound', 'Bird Sound'],
      'correct': 0,
      'audio': [
        'assets/sounds/dog_bark.mp3',
        'assets/sounds/cat_meow.mp3',
        'assets/sounds/bird_chirp.mp3',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  void nextExercise() {
    if (currentExercise < exercises.length - 1) {
      setState(() {
        currentExercise++;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('تمت التمارين'),
            content: Text('لقد أنهيت التمارين.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('إغلاق'),
              ),
            ],
          );
        },
      );
    }
  }

  // تعديل هنا للتعامل مع القوائم الصوتية بشكل صحيح
  Future<void> playAudio(dynamic audioPath) async {
    try {
      print("Playing audio from: $audioPath"); // إضافة طباعة للسجل للتحقق من المسار
      if (audioPath is List) {
        // في حال كانت القائمة تحتوي على ملفات صوتية متعددة، نختار الأول
        await _audioPlayer.setAsset(audioPath[0]); // اختر العنصر الأول في القائمة
      } else {
        await _audioPlayer.setAsset(audioPath); // إذا كان الصوت مسار واحد فقط
      }
      await _audioPlayer.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (currentExercise + 1) / exercises.length;
    final current = exercises[currentExercise];

    return Scaffold(
      backgroundColor: Color(0xFF1B1F23),
      appBar: AppBar(
        backgroundColor: Color(0xFF2C3A47),
        title: Text('تمارين تفاعلية'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Progress Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.white30,
                    color: Color(0xFF0288D1),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Title of the exercise
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                current['title'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                textAlign: TextAlign.right,
              ),
            ),
            SizedBox(height: 20),

            // Question Container with custom height (longer box)
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: current['type'] == 'fillBlank' 
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,  // Adjust alignment for text
                    children: [
                      Text(
                        current['question'],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        textAlign: TextAlign.left,  // Align text to the left
                      ),
                      SizedBox(height: 10),  // Add some spacing between question and translation
                      Text(
                        current['translation'], // Add translation (العمر ليس مهماً)
                        style: TextStyle(fontSize: 18, color: Colors.white60), // Slightly lighter color for translation
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between text and icon
                    children: [
                      Expanded(
                        child: Text(
                          current['question'],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.left, // Align text to the left
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.volume_up, color: Colors.blue),
                        onPressed: () {
                          playAudio(current['audio']);  // تعديل هنا
                        },
                      ),
                    ],
                  ),
            ),
            SizedBox(height: 20),

            // Handling different question types
            if (current['type'] == 'choice') ...[
              ChoiceQuestion(
                answers: current['answers'],
                onNext: nextExercise,
                correctAnswerIndex: 1,
              ),
            ] else if (current['type'] == 'reorder') ...[
              ReorderQuestion(
                correctOrder: current['correctOrder'],
                onNext: nextExercise,
              ),
            ] else if (current['type'] == 'fillBlank') ...[
              FillBlankQuestion(
                correctAnswer: current['correct'],
                translation: current['translation'],
                onNext: nextExercise,
              ),
            ] else if (current['type'] == 'audioChoice') ...[
              AudioChoiceQuestion(
                answers: current['answers'],
                audioFiles: current['audio'],
                correctAnswer: current['correct'],
                onNext: nextExercise,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
