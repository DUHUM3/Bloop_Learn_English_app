import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // إعداد AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 2), // مدة الأنميشن
      vsync: this,
    );

    // إنشاء الأنميشن مع Tween لتحريك الصورة من الجهة اليسرى إلى المنتصف
    _animation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // تشغيل الأنميشن عند بدء التطبيق
    _controller.forward();

    // الانتقال للصفحة التالية بعد 3 ثواني
    Future.delayed(Duration(seconds: 6), () {
      Navigator.pushReplacementNamed(context, '/Home');
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // التأكد من التخلص من الـ controller بعد انتهاء الـ Splash
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B1F23),
      body: Center(
        child: SlideTransition(
          position: _animation, // تطبيق الأنميشن على الصورة
          child: Image.asset(
            'assets/images/icon.gif', // مسار الصورة
            width: 450, // عرض الصورة
            height: 450, // ارتفاع الصورة
          ),
        ),
      ),
    );
  }
}
