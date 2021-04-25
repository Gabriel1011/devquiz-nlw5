import 'package:DevQuiz/Pages/challenge/challenge_controller.dart';
import 'package:DevQuiz/Pages/challenge/widgets/next_button/next_button_widget.dart';
import 'package:DevQuiz/Pages/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:DevQuiz/Pages/challenge/widgets/quiz/quiz_widget.dart';
import 'package:DevQuiz/Pages/result/result_page.dart';
import 'package:flutter/material.dart';

import 'package:DevQuiz/shared/models/question_model.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  final String title;

  ChallengePage({
    Key? key,
    required this.questions,
    required this.title,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });

    super.initState();
  }

  nextPage() => controller.currentPage < widget.questions.length
      ? pageController.nextPage(
          duration: Duration(milliseconds: 1),
          curve: Curves.linear,
        )
      : null;

  void onSelected(bool value) {
    if (value) controller.awnserRight++;

    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
              ValueListenableBuilder(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: controller.currentPage,
                  length: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map(
              (question) => QuizWidget(
                question: question,
                onSelected: onSelected,
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ValueListenableBuilder(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => Row(
              children: [
                if (value != widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.white(
                      label: "Pular",
                      onTap: nextPage,
                    ),
                  ),
                if (value == widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.green(
                      label: "Finalizar",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResultPage(
                              title: widget.title,
                              length: widget.questions.length,
                              lenghtIsRight: controller.awnserRight,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
