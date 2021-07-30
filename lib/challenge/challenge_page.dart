import 'package:dev_quiz/challenge/challenge_controller.dart';
import 'package:dev_quiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:dev_quiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:dev_quiz/result/result_page.dart';
import 'package:dev_quiz/shared/models/question_model.dart';
import 'package:dev_quiz/shared/widgets/next_button/next_button_widget.dart';

import 'package:flutter/material.dart';

class ChallengePage extends StatefulWidget {
  final String title;
  final List<QuestionModel> questions;

  ChallengePage({
    Key? key,
    required this.title,
    required this.questions,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  //criação de controle para manter o stado de algumas variáveis
  final controller = ChallangeController();
  //componente do flutter para mudanças de página
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      //quando ouver a ação de mudança de página, o controle receberá a página atual
      controller.currentPage = pageController.page!.toInt() + 1;
    });
    super.initState();
  }

  void nextPage() {
    if (controller.currentPage < widget.questions.length)
      pageController.nextPage(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
  }

  void onSelected(bool value) {
    if (value) controller.rightAnswer++;
    nextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        // define o tamanho da appbar
        preferredSize: Size.fromHeight(86),
        //utiliza uma área segura do appbar
        child: SafeArea(
            top: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //BackButton(),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.close)),
                // boa prática para evitar que a tela seja recarregada ao utilizar o pageController
                ValueListenableBuilder<int>(
                  // o que será ouvido:
                  valueListenable: controller.currentPageNotifier,
                  // devolve um builder (contexto, valor, child)
                  builder: (context, value, _) => QuestionIndicatorWidget(
                    currentPage: value,
                    length: widget.questions.length,
                  ),
                ),
              ],
            )),
      ),
      // componente flutter para mudança de páginas
      body: PageView(
        // trava a possiblidade de scroll
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions
            .map(
              (e) => QuizWidget(question: e, onSelected: onSelected),
            )
            .toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => Row(
              // definir espaçamento em torna, mais longo q spaceEvenly
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (value < widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.white(
                      label: "Pular",
                      onTap: nextPage,
                    ),
                  ),
                if (value == widget.questions.length)
                  Expanded(
                    child: NextButtonWidget.green(
                      label: "Confirmar",
                      onTap: () {
                        //sobreescreve a página atual para dps retornar ao início
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(
                              title: widget.title,
                              rights: controller.rightAnswer,
                              length: widget.questions.length,
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
