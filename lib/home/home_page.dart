import 'package:dev_quiz/challenge/challenge_page.dart';
import 'package:dev_quiz/core/app_colors.dart';
import 'package:dev_quiz/home/home_controller.dart';
import 'package:dev_quiz/home/home_state.dart';
import 'package:dev_quiz/home/widgets/app_bar/app_bar_widget.dart';
import 'package:dev_quiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:dev_quiz/home/widgets/level_button/level_button_widget.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

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

    // a cada alteração no controller, é disparada uma solicitação de atualização.
    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state != HomeState.success) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarWidget(
        user: controller.user!,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LevelButtonWidget(label: "Fácil"),
                LevelButtonWidget(label: "Médio"),
                LevelButtonWidget(label: "Difícil"),
                LevelButtonWidget(label: "Perito"),
              ],
            ),
            SizedBox(height: 24),
            // cuidado ao erros ao tentar expandir componentes, forçar também os pais a expandir
            Expanded(
              child: GridView.count(
                // espaço entre os componentes
                crossAxisSpacing: 16,
                // espaçamento entre os itens baixo
                mainAxisSpacing: 16,
                //força a quantidade de itens dps do outro
                crossAxisCount: 2,
                children: controller.quizzes!
                    .map((e) => QuizCardWidget(
                          title: e.title,
                          progressLabel:
                              "${e.questionAnswered} de ${e.questions.length}",
                          progressValue:
                              e.questionAnswered / e.questions.length,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChallengePage(
                                  title: e.title,
                                  questions: e.questions,
                                ),
                              ),
                            );
                          },
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
