import 'package:DevQuiz/Pages/home/home_repository.dart';
import 'package:DevQuiz/Pages/home/home_state.dart';
import 'package:DevQuiz/shared/models/quiz_model.dart';
import 'package:DevQuiz/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class HomeController {
  final ValueNotifier<HomeState> stateNotifier =
      ValueNotifier<HomeState>(HomeState.empty);

  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  final ValueNotifier<List<QuizModel>?> quizzesNotifier =
      ValueNotifier<List<QuizModel>?>(null);

  set quizzes(List<QuizModel>? state) => quizzesNotifier.value = state;
  List<QuizModel>? get quizzes => quizzesNotifier.value;

  UserModel? user;
  List<QuizModel>? allQuizzes;

  final repository = HomeRepository();

  void getUser() async {
    state = HomeState.loading;

    await Future.delayed(Duration(seconds: 2));

    user = await repository.getUser();
    state = HomeState.success;
  }

  void getQuizzes() async {
    state = HomeState.loading;

    await Future.delayed(Duration(seconds: 2));

    allQuizzes = await repository.getQuizzes();
    quizzes = allQuizzes;

    state = HomeState.success;
  }

  void filterQuisse(Level level) {
    quizzes = allQuizzes!.where((element) => element.level == level).toList();
  }
}
