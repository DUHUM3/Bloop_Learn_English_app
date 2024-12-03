import 'package:flutter/material.dart';
// استيراد الشاشات المطلوبة
import 'package:tb/levels/level2.dart';

class LevelStepperPage extends StatefulWidget {
  @override
  _LevelStepperPageState createState() => _LevelStepperPageState();
}

class _LevelStepperPageState extends State<LevelStepperPage> {
  int _currentLevel = 0;
  List<bool> _completedLevels = List.filled(10, false);

  // دالة لتحديث حالة إتمام مستوى معين
  void _onLevelComplete(int level) {
    setState(() {
      _completedLevels[level] = true;
      if (level + 1 < _completedLevels.length) {
        _currentLevel = level + 1; // الانتقال تلقائيًا إلى المستوى التالي
      }
    });
  }

  // دالة لفتح الشاشة المناسبة بناءً على المستوى
  void _openLevelScreen(int level) {
    Widget levelScreen;

    switch (level) {
      case 0:
        levelScreen = InteractiveExerciseScreen();
        break;
      default:
        levelScreen = Scaffold(
          body: Center(
            child: Text('لم يتم إعداد شاشة لهذا المستوى بعد.'),
          ),
        );
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => levelScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'مستويات التمرين',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF2C3A47), // لون AppBar
      ),
      backgroundColor: Color(0xFF1B1F23), // لون الخلفية
      body: Theme(
        data: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Color(0xFF0288D1), // لون التحديد
          ),
        ),
        child: Stepper(
          currentStep: _currentLevel,
          onStepTapped: (step) {
            if (step == 0 || _completedLevels[step - 1]) {
              setState(() {
                _currentLevel = step;
              });
              _openLevelScreen(step); // فتح الشاشة المناسبة
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Color(0xFF1B1F23), // خلفية التنبيه
                  title: Text(
                    "تحدي المستوى السابق",
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Text(
                    "من فضلك أكمل المستوى السابق قبل الانتقال إلى المستوى الحالي.",
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "حسنًا",
                        style: TextStyle(color: Color(0xFF0288D1)),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          steps: List.generate(10, (index) {
            return Step(
              title: Row(
                children: [
                  Icon(Icons.flag, color: Color(0xFF0288D1)), // أيقونة مميزة
                  SizedBox(width: 8),
                  Text(
                    'Level ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              content: Column(
                children: [
                  Text(
                    'وصف المستوى ${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Divider(
                    color: _currentLevel >= index
                        ? Color(0xFF0288D1)
                        : Colors.grey,
                    thickness: 2,
                  ), // خط تحت النص
                ],
              ),
              isActive: _currentLevel >= index,
              state: _completedLevels[index]
                  ? StepState.complete
                  : StepState.indexed,
            );
          }),
          controlsBuilder: (BuildContext context, ControlsDetails details) {
            return SizedBox.shrink(); // إخفاء الأزرار
          },
        ),
      ),
    );
  }
}
