import 'package:DevQuiz/challenge/challenge_page.dart';
import 'package:DevQuiz/core/app_colors.dart';
import 'package:DevQuiz/home/home_state.dart';
import 'package:DevQuiz/home/widgets/appbar/appbar_widget.dart';
import 'package:DevQuiz/home/widgets/level_button/level_button_widget.dart';
import 'package:DevQuiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:flutter/material.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();

    controller.getUser();
    controller.getQuizzes();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return controller.state == HomeState.success
        ? page()
        : Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
              ),
            ),
          );
  }

  page() {
    return Scaffold(
      appBar: AppBarWidget(
        user: controller.user!,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LevelButtonWidget(label: "Fácil"),
                LevelButtonWidget(label: "Médio"),
                LevelButtonWidget(label: "Díficil"),
                LevelButtonWidget(label: "Perito"),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              padding: EdgeInsets.all(16),
              children: controller.quizzes!
                  .map(
                    (quiz) => QuizCardWidget(
                      title: quiz.title,
                      completed:
                          "${quiz.questionAwnsered}/${quiz.questions.length}",
                      porcent: quiz.questionAwnsered / quiz.questions.length,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChallengePage(
                                questions: quiz.questions, title: quiz.title),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
