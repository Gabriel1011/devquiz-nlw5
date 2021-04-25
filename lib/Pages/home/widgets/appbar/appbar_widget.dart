import 'package:DevQuiz/Pages/home/widgets/score_card/score_card_widget.dart';
import 'package:DevQuiz/core/app_gradients.dart';
import 'package:DevQuiz/core/core.dart';
import 'package:DevQuiz/shared/models/user_model.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  final UserModel user;

  AppBarWidget({required this.user})
      : super(
          preferredSize: Size.fromHeight(250),
          child: Container(
            height: 250,
            child: Stack(
              children: [
                Container(
                  height: 161,
                  width: double.maxFinite,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.linear,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: "Olá, ",
                          style: AppTextStyles.title,
                          children: [
                            TextSpan(
                              text: "Gabriel",
                              style: AppTextStyles.titleBold,
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://media-exp1.licdn.com/dms/image/C4E03AQFyYEkXb8Duuw/profile-displayphoto-shrink_200_200/0/1610278222081?e=1624492800&v=beta&t=lJ8nHdN4qPONqhvXQBdkutnZUWhXAuaTETKHVw02CNY"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment(0.0, 1.0),
                  child: ScoreCardWidget(percent: user.score / 100),
                ),
              ],
            ),
          ),
        );
}
