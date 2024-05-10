import 'dart:async';
import 'package:flutter/material.dart';
import '/models/questions.dart';
import '/screens/result_screen.dart';
import '/widgets/answer_card.dart';
import '/widgets/next_button.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  int score = 0;
  late DateTime _startTime;
  late List<DateTime> questionStartTimes;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    questionStartTimes = List.filled(questions.length, DateTime.now());
  }

  void pickAnswer(int value) {
    setState(() {
      selectedAnswerIndex = value;
    });
    final question = questions[questionIndex];
    if (selectedAnswerIndex == question.correctAnswerIndex) {
      setState(() {
        score++;
      });
    }
  }

  void goToNextQuestion() {
    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        selectedAnswerIndex = null;
        questionStartTimes[questionIndex] = DateTime.now(); // Update start time of next question
      });
    } else {
      // Calculate total time
      final endTime = DateTime.now();
      final totalTime = endTime.difference(_startTime);

      // Calculate time for each question
      List<int> questionTimes = [];
      for (int i = 0; i < questions.length; i++) {
        DateTime questionEndTime = i == questions.length - 1 ? endTime : questionStartTimes[i + 1];
        Duration questionTime = questionEndTime.difference(questionStartTimes[i]);
        questionTimes.add(questionTime.inSeconds);
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultScreen(
            score: score,
            totalTime: totalTime,
            questionTimes: questionTimes,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    bool isLastQuestion = questionIndex == questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              question.question,
              style: const TextStyle(
                fontSize: 21,
              ),
              textAlign: TextAlign.center,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: question.options.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: selectedAnswerIndex == null
                      ? () => pickAnswer(index)
                      : null,
                  child: AnswerCard(
                    currentIndex: index,
                    question: question.options[index],
                    isSelected: selectedAnswerIndex == index,
                    selectedAnswerIndex: selectedAnswerIndex,
                    correctAnswerIndex: question.correctAnswerIndex,
                  ),
                );
              },
            ),
            // Next Button
            isLastQuestion
                ? RectangularButton(
              onPressed: selectedAnswerIndex != null
                  ? goToNextQuestion
                  : null,
              label: 'Finish',
            )
                : RectangularButton(
              onPressed: selectedAnswerIndex != null
                  ? goToNextQuestion
                  : null,
              label: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
