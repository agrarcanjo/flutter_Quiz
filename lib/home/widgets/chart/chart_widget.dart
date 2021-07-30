import 'package:dev_quiz/core/app_colors.dart';
import 'package:dev_quiz/core/app_text_styles.dart';

import 'package:flutter/material.dart';

// precisa manter o estado em animações
class ChartWidget extends StatefulWidget {
  final double percent;

  const ChartWidget({
    Key? key,
    required this.percent,
  }) : super(key: key);

  @override
  _ChartWidgetState createState() => _ChartWidgetState();
}

//criar uma classe privada extendendo para conseguir acesso ao AnimationController
class _ChartWidgetState extends State<ChartWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  void _initAnimation() {
    //chama a exportação com o tempo de duração
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    //animação para definir o início e fim
    _animation =
        Tween<double>(begin: 0.0, end: widget.percent).animate(_controller);
    //existem vários tipos como reverse
    _controller.forward();
  }

  @override
  void initState() {
    // faz com que seja iniciada a validação com o início de tela
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      //chamando a animação em tela
      child: AnimatedBuilder(
        // e definindo a animação
        animation: _animation,
        // stack de componentes uma em cima da outra
        builder: (context, _) => Stack(
          children: [
            Center(
              child: Container(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  value: _animation.value,
                  backgroundColor: AppColors.chartSecondary,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.chartPrimary),
                ),
              ),
            ),
            Center(
              child: Text(
                //atento ao valor de inteiro crescendo
                "${(_animation.value * 100).toInt()}%",
                style: AppTextStyles.heading,
              ),
            )
          ],
        ),
      ),
    );
  }
}
