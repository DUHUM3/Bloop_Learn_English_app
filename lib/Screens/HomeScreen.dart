import 'dart:math'; // لإضافة Random
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // لإضافة SharedPreferences

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentLanguage = 'English'; // اللغة الحالية
  bool isLanguageDropdownOpen = false; // للتحكم في إظهار شريط اللغة
  int hearts = 7; // عدد القلوب الافتراضي

  @override
  void initState() {
    super.initState();
    _loadHearts(); // تحميل عدد القلوب عند بدء الصفحة
  }

  // تحميل عدد القلوب من SharedPreferences
  Future<void> _loadHearts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      hearts = prefs.getInt('hearts') ??
          7; // استرجاع عدد القلوب المخزن أو تعيين القيمة الافتراضية
    });
  }

  // تحديث عدد القلوب وحفظه في SharedPreferences
  Future<void> _decreaseHeart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (hearts > 0) {
        hearts--;
        prefs.setInt('hearts', hearts); // حفظ القيمة الجديدة
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // قائمة الصور للاختيار منها عشوائيًا
    List<String> images = [
      'assets/images/girlrun.gif',
      'assets/images/girlrun2.gif',
      'assets/images/boywalk.gif',
      'assets/images/boyswime.gif',
      'assets/images/boyjump.gif',
    ];

    // اختيار صورة عشوائية من القائمة
    String randomImage = images[Random().nextInt(images.length)];

    return Scaffold(
      backgroundColor: const Color(0xFF1B1F23), // خلفية أغمق
      appBar: AppBar(
        title: const Text(
          "Learn English",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2C3A47), // لون متناغم مع الخلفية
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          // الشريط الشفاف مع اختيار اللغة
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2C3A47),
                  Color(0xFF1B1F23)
                ], // تدرج لوني مع الخلفية
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLanguageDropdownOpen = !isLanguageDropdownOpen;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Icons.language, color: Colors.white),
                      const SizedBox(width: 10),
                      Text(
                        currentLanguage,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // عرض عدد القلوب هنا
                Row(
                  children: [
                    Icon(Icons.favorite, color: Colors.red), // أيقونة القلب
                    const SizedBox(width: 8),
                    Text(
                      '$hearts', // عرض عدد القلوب
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isLanguageDropdownOpen)
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF2C3A47).withOpacity(0.9), // خلفية داكنة قليلاً
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  _buildLanguageOption("English"),
                  _buildLanguageOption("Arabic"),
                ],
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner مع الصورة العشوائية
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(randomImage), // الصورة العشوائية
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // زر التنقل
                    const Text(
                      "Choose your activity:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // إضافة الأنشطة الجديدة
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavigationCard(
                          context,
                          icon: Icons.text_snippet,
                          title: "Grammar",
                          onTap: () {
                            Navigator.pushNamed(context, '/PresentSimple');
                          },
                        ),
                        _buildNavigationCard(
                          context,
                          icon: Icons.book,
                          title: "Reading",
                          onTap: () {
                            Navigator.pushNamed(context, '/reading');
                          },
                        ),
                        _buildNavigationCard(
                          context,
                          icon: Icons.mic,
                          title: "Speaking",
                          onTap: () {
                            Navigator.pushNamed(context, '/speaking');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavigationCard(
                          context,
                          icon: Icons.create,
                          title: "Writing",
                          onTap: () {
                            Navigator.pushNamed(context, '/writing');
                          },
                        ),
                        _buildNavigationCard(
                          context,
                          icon: Icons.headphones,
                          title: "Listening",
                          onTap: () {
                            Navigator.pushNamed(context, '/listening');
                          },
                        ),
                        _buildNavigationCard(
                          context,
                          icon: Icons.fitness_center,
                          title: "Exercises",
                          onTap: () {
                            Navigator.pushNamed(context, '/level');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // قسم التقدم
                    const Text(
                      "Your Progress:",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.5,
                      backgroundColor: Colors.grey[300],
                      color: const Color(0xFF4FC3F7),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "50% completed",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    // قسم الاقتباس التحفيزي
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                            color: Color(0xFF0288D1),
                            width: 2), // لون الحواف الأزرق
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(
                              0xFF1B1F23), // تغيير لون الخلفية إلى 0xFF1B1F23
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/learningtowgther.png',
                              width: 40,
                              height: 40,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Learning a new language is like growing a new soul.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color:
                                      Colors.white, // تغيير لون النص إلى الأبيض
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ويدجت لاختيار اللغة
  Widget _buildLanguageOption(String language) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentLanguage = language;
          isLanguageDropdownOpen = false; // إغلاق الشريط بعد الاختيار
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Text(
          language,
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }

  // ويدجت لعرض بطاقات الأنشطة
  Widget _buildNavigationCard(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFF2C3A47),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
              color: const Color(0xFF0288D1), width: 2), // حدود باللون الأزرق
        ),
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.all(16),
          width: 100,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: const Color(0xFF0288D1),
                  size: 40), // الأيقونة باللون الأزرق
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
