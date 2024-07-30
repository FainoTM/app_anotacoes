import 'package:anotacao_firebase/pages/cadastroAnotacao.dart';
import 'package:flutter/cupertino.dart';
import 'package:anotacao_firebase/homePage.dart';

class AppRoutes{

  static const homePage = '/lib/homePage';
  static const novaAnotacao = 'pages/cadastroAnotacao';

  static Map<String, WidgetBuilder> define(){
    return {
      homePage: (BuildContext context) => const HomePage(),
      novaAnotacao: (BuildContext context) => const NovaAnotacao(),
    };
  }
}