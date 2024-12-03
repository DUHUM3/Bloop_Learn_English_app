import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioChoiceQuestion extends StatefulWidget {
  final List<String> answers;
  final List<String> audioFiles;
  final int correctAnswer;
  final VoidCallback onNext;

  AudioChoiceQuestion({
    required this.answers,
    required this.audioFiles,
    required this.correctAnswer,
    required this.onNext,
  });

  @override
  _AudioChoiceQuestionState createState() => _AudioChoiceQuestionState();
}

class _AudioChoiceQuestionState extends State<AudioChoiceQuestion> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.answers
          .asMap()
          .entries
          .map(
            (entry) => ElevatedButton(
              onPressed: () async {
                await _audioPlayer.setAsset(widget.audioFiles[entry.key]);
                await _audioPlayer.play();
                if (entry.key == widget.correctAnswer) {
                  widget.onNext();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0288D1),
              ),
              child: Text(entry.value),
            ),
          )
          .toList(),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
