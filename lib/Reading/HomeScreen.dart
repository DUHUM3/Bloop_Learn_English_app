import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // لإدارة ملفات assets
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart'; // للوصول إلى مجلد التخزين المؤقت

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoryPage(),
    );
  }
}

class StoryPage extends StatelessWidget {
 final List<Map<String, String>> stage1Stories = [
  {
    'image': 'assets/images/Short Stories In English for Beginners Book.jpg',
    'title': 'القصة الأولى - المرحلة 1',
    'pdf': 'assets/storys/Short Stories In English for Beginners Book.pdf'
  },
  {
    'image': 'assets/images/the boy.jpg',
    'title': 'القصة الثانية - المرحلة 1',
    'pdf': 'assets/storys/the boy.pdf'
  },
  {
    'image': 'assets/images/Girl_Meets_Boy.jpg',
    'title': 'القصة الثالثة - المرحلة 1',
    'pdf': 'assets/storys/Girl_Meets_Boy.pdf'
  },
];


  final List<Map<String, String>> stage2Stories = [
    {
      'image': 'assets/images/story3.jpg',
      'title': 'القصة الأولى - المرحلة 2',
      'pdf': 'assets/storys/story3.pdf'
    },
    {
      'image': 'assets/images/story4.jpg',
      'title': 'القصة الثانية - المرحلة 2',
      'pdf': 'assets/storys/story4.pdf'
    },
  ];

  final List<Map<String, String>> stage3Stories = [
    {
      'image': 'assets/images/story5.jpg',
      'title': 'القصة الأولى - المرحلة 3',
      'pdf': 'assets/storys/story5.pdf'
    },
    {
      'image': 'assets/images/story6.jpg',
      'title': 'القصة الثانية - المرحلة 3',
      'pdf': 'assets/storys/story6.pdf'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
      appBar: AppBar(
  title: Text(
    'الرئيسية',
    style: TextStyle(color: Colors.white), // تحديد اللون الأبيض للنص
  ),
  centerTitle: false, // محاذاة النص إلى اليسار
  backgroundColor: Color(0xFF2C3A47),
  bottom: TabBar(
    indicatorColor: Colors.white, // اللون عند التحديد
    labelColor: Colors.white, // اللون عند التحديد
    unselectedLabelColor: Colors.grey, // اللون عند عدم التحديد
    tabs: [
      Tab(text: 'المرحلة 1'),
      Tab(text: 'المرحلة 2'),
      Tab(text: 'المرحلة 3'),
    ],
  ),
),
 
        body: TabBarView(
          children: [
            StoryGrid(
                stories: stage1Stories,
                backgroundColor: Color(0xFF1B1F23)), // القصص الخاصة بالمرحلة 1
            StoryGrid(
                stories: stage2Stories,
                backgroundColor: Color(0xFF1B1F23)), // القصص الخاصة بالمرحلة 2
            StoryGrid(
                stories: stage3Stories,
                backgroundColor: Color(0xFF1B1F23)), // القصص الخاصة بالمرحلة 3
          ],
        ),
      ),
    );
  }
}

class StoryGrid extends StatelessWidget {
  final List<Map<String, String>> stories;
  final Color backgroundColor; // إضافة متغير اللون

  const StoryGrid({required this.stories, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor, // استخدام اللون المخصص لكل مرحلة
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return GestureDetector(
            onTap: () async {
              final tempPath = await _getTemporaryPdfPath(story['pdf']!);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewerPage(pdfPath: tempPath),
                ),
              );
            },
            child: StoryCard(
              image: story['image']!,
              title: story['title']!,
            ),
          );
        },
      ),
    );
  }

  Future<String> _getTemporaryPdfPath(String assetPath) async {
    try {
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/${assetPath.split('/').last}');
      final byteData = await rootBundle.load(assetPath);
      await tempFile.writeAsBytes(byteData.buffer.asUint8List());
      return tempFile.path;
    } catch (e) {
      print('Error copying PDF to temp directory: $e');
      throw Exception('Failed to load PDF file');
    }
  }
}

class StoryCard extends StatelessWidget {
  final String image;
  final String title;

  const StoryCard({required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF2C3A47),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class PDFViewerPage extends StatelessWidget {
  final String pdfPath;

  const PDFViewerPage({required this.pdfPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عرض القصة'),
        backgroundColor: Color(0xFF2C3A47),
      ),
      body: PDFView(
        filePath: pdfPath,
      ),
    );
  }
}
