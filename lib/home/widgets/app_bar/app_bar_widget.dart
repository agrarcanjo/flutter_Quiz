import 'package:dev_quiz/core/app_gradients.dart';
import 'package:dev_quiz/core/app_text_styles.dart';
import 'package:dev_quiz/home/widgets/score_card/score_card_widget.dart';
import 'package:dev_quiz/shared/models/user_model.dart';

import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  final UserModel user;

  AppBarWidget({required this.user})
      : super(
          preferredSize: Size.fromHeight(250),
          child: Container(
            height: 250,
            //deixa os componentes um em cima do outro
            child: Stack(
              children: [
                Container(
                  height: 160,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.maxFinite,
                  // define uma caixa de fundo de cor
                  decoration: BoxDecoration(gradient: AppGradients.linear),
                  child: Row(
                    // espaçamento entre itens children e container
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // possibilidade de criar textos em cascata
                      Text.rich(
                        TextSpan(
                          text: "Olá, ",
                          style: AppTextStyles.title,
                          children: [
                            TextSpan(
                              text: user.name,
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
                            image: NetworkImage(user.photoUrl),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  //cria um alinhamento do componente começando pelo param
                  alignment: Alignment(0.0, 1.0),
                  child: ScoreCardWidget(percent: user.score / 100),
                ),
              ],
            ),
          ),
        );
}
