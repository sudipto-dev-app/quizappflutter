import 'package:flutter/material.dart';
import 'package:quizappflutter/models/questions.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final Duration totalTime;
  final List<int> questionTimes;

  const ResultScreen({
    super.key,
    required this.score,
    required this.totalTime,
    required this.questionTimes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Your Score: $score',
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w500,
            ),
          ),const SizedBox(height: 10,),
          Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: CircularProgressIndicator(
            strokeWidth: 10,
            value: score / 9,
            color: Colors.green,
            backgroundColor: Colors.white,
          ),
        ),
        Column(
          children: [
            Text(
              score.toString(),
              style: const TextStyle(fontSize: 80),
            ),
            const SizedBox(height: 10),
            Text(
              '${(score / questions.length * 100).round()}%',
              style: const TextStyle(fontSize: 25),
            )
          ],
        ),
      ],
          ),
          const SizedBox(height: 20,),
          Text(
            'Total Time: ${totalTime.inSeconds} seconds',
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: questionTimes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Question ${index + 1} Time: ${questionTimes[index]} seconds'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
