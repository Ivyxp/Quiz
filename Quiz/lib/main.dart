import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white, // Altera a cor de fundo para branco
        body: QuizScreen(),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _totalScore = 0;

  void _answerQuestion(int score) {
    setState(() {
      _totalScore += score;
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_questionIndex >= _questions.length) {
      return Result(_totalScore,
          _resetQuiz); // Passa o método _resetQuiz para a classe Result
    } else {
      return Quiz(
        questionIndex: _questionIndex,
        answerQuestion: _answerQuestion,
        questions: _questions,
      );
    }
  }

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Time campeao da superliga temporada 21/22?',
      'answers': [
        {'text': 'Praia clube', 'score': 1},
        {'text': 'Osasco', 'score': 0},
        {'text': 'Minas tenis clube', 'score': 0}
      ],
    },
    {
      'questionText': 'Quantas libertadores tem o Corinthias feminino?',
      'answers': [
        {'text': 'Quatro', 'score': 1},
        {'text': 'Duas', 'score': 0},
        {'text': 'Tres', 'score': 0}
      ],
    },
    {
      'questionText': 'O praia clube e um time de volei de?',
      'answers': [
        {'text': 'Rio de janeiro', 'score': 0},
        {'text': 'Salvador', 'score': 0},
        {'text': 'Uberlandia', 'score': 1}
      ],
    }
  ];
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final Function(int) answerQuestion;
  final List<Map<String, Object>> questions;

  Quiz({
    required this.questionIndex,
    required this.answerQuestion,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(questions[questionIndex]['questionText'] as String),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map(
              (answer) => Answer(
                answer['text'] as String,
                () => answerQuestion(answer['score'] as int),
              ),
            )
            .toList(),
      ],
    );
  }
}

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10), // Adiciona um espaçamento interno
        child: Text(
          questionText,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black, // Altera a cor do texto para preto
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final String answerText;
  final Function selectHandler;

  Answer(this.answerText, this.selectHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ElevatedButton(
        onPressed: () => selectHandler(),
        child: Text(answerText),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetQuiz;

  Result(this.totalScore, this.resetQuiz);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your total score is $totalScore',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => resetQuiz(),
            child: Text('Voltar ao Inicio'),
          ),
        ],
      ),
    );
  }
}
