import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeartsWidget extends StatefulWidget {
  const HeartsWidget({Key? key}) : super(key: key);

  @override
  HeartsWidgetState createState() => HeartsWidgetState();
}

class HeartsWidgetState extends State<HeartsWidget> {
  int hearts = 7; // القيمة الافتراضية للقلوب
  Timer? timer; // المؤقت لإعادة التحديث

  @override
  void initState() {
    super.initState();
    _loadHearts(); // تحميل عدد القلوب عند بداية الودجت
    _startHeartResetTimer(); // بدء مؤقت إعادة التحديث
  }

  @override
  void dispose() {
    timer?.cancel(); // إيقاف المؤقت عند التخلص من الودجت
    super.dispose();
  }

  // تحميل عدد القلوب من SharedPreferences
  Future<void> _loadHearts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hearts = prefs.getInt('hearts') ?? 7; // استرجاع القلوب أو تعيين القيمة الافتراضية
    });
  }

  // تقليل عدد القلوب وحفظه في SharedPreferences
  Future<void> decreaseHeart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (hearts > 0) {
        hearts--;
        prefs.setInt('hearts', hearts); // حفظ القيمة الجديدة في SharedPreferences
      }
    });
  }

  // إعادة تعيين القلوب إلى 7 كل دقيقة
  void _startHeartResetTimer() {
    timer = Timer.periodic(const Duration(minutes: 1), (_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        hearts = 7; // تعيين القلوب إلى القيمة الافتراضية
        prefs.setInt('hearts', hearts); // حفظ القيمة الافتراضية
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.favorite, color: Colors.red, size: 30),
        const SizedBox(width: 8),
        Text(
          '$hearts',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
