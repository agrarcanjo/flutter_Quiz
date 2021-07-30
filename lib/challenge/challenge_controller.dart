import 'package:flutter/cupertino.dart';

class ChallangeController {
  //controlador de stato para o challange
  final currentPageNotifier = ValueNotifier<int>(1);
  int get currentPage => currentPageNotifier.value;
  set currentPage(int value) => currentPageNotifier.value = value;

  int rightAnswer = 0;
}
