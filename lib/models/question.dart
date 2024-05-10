class Question {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;
  final Duration individualTime;

  const Question({
    required this.correctAnswerIndex,
    required this.question,
    required this.options,
    this.individualTime = const Duration(seconds: 0),
  });
}
