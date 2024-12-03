import 'package:flutter/material.dart';

class ReorderQuestion extends StatefulWidget {
  final List<String> correctOrder;
  final VoidCallback onNext;

  ReorderQuestion({required this.correctOrder, required this.onNext});

  @override
  _ReorderQuestionState createState() => _ReorderQuestionState();
}

class _ReorderQuestionState extends State<ReorderQuestion> {
  List<String> shuffledWords = [];
  List<String> userReorderedWords = [];

  @override
  void initState() {
    super.initState();
    shuffledWords = List.from(widget.correctOrder)..shuffle(); // خلط الكلمات
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // منطقة لإسقاط العناصر المرتبة من قبل المستخدم بشكل خط
        Container(
          width: double.infinity, // جعل المربع بعرض الشاشة
          height: 80, // تحديد ارتفاع المربع
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.blue, width: 2),
              bottom: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
          child: DragTarget<String>(
            onAccept: (data) {
              setState(() {
                userReorderedWords.add(data);
                shuffledWords.remove(data);
              });
            },
            onWillAccept: (data) => true, // السماح بقبول السحب
            builder: (context, candidateData, rejectedData) {
              return Wrap(
                alignment: WrapAlignment.start,
                spacing: 8.0,
                children: userReorderedWords
                    .map((word) => GestureDetector(
                          onLongPress: () {
                            setState(() {
                              userReorderedWords.remove(word);
                              shuffledWords.add(word); // إعادة الكلمة لقائمة الكلمات المختلطة
                            });
                          },
                          child: Chip(
                            label: Text(word, style: TextStyle(fontSize: 18)),
                            backgroundColor: Colors.green,
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ),
        SizedBox(height: 20),
        // عرض الكلمات التي يمكن سحبها
        Wrap(
          spacing: 8.0,
          children: shuffledWords
              .map(
                (word) => Draggable<String>(
                  data: word,
                  feedback: Material(
                    color: Colors.transparent,
                    child: Chip(
                      label: Text(word, style: TextStyle(fontSize: 18)),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  childWhenDragging: Opacity(
                    opacity: 0.5,
                    child: Chip(
                      label: Text(word, style: TextStyle(fontSize: 18)),
                      backgroundColor: Colors.blue,
                    ),
                  ),
                  child: Chip(
                    label: Text(word, style: TextStyle(fontSize: 18)),
                    backgroundColor: Colors.blue,
                  ),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 20),
        // زر للتحقق من الإجابة
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0288D1)),
          onPressed: () {
            if (userReorderedWords.join(' ') == widget.correctOrder.join(' ')) {
              widget.onNext(); // إذا كانت الإجابة صحيحة، التوجه للتمرين التالي
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
