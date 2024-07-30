import 'package:anotacao_firebase/route/appRoutes.dart';
import 'package:flutter/material.dart';

import '../database/databaseOperations.dart';
import '../utils/customFormField.dart';

class NovaAnotacao extends StatefulWidget {
  const NovaAnotacao({super.key});

  @override
  State<NovaAnotacao> createState() => _NovaAnotacaoState();
}

class _NovaAnotacaoState extends State<NovaAnotacao> {


  TextEditingController controller_titulo = TextEditingController();
  TextEditingController controller_corpo = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Criar nova anotação', style: TextStyle(color: Colors.white),
      ),
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.only(left: 16,right: 16, top: 50),
            child: Column(
              children: [
                CustomTextFormField(campo: 'Título', controlador: controller_titulo),
                SizedBox(height: 10,),
                CustomTextFormField(campo: 'Corpo da Anotação', controlador: controller_corpo, isBody: true,),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: () {
                  DatabaseOperations().createNovaAnotacao(controller_titulo.text, controller_corpo.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nova anotação criada!!')));
                  Navigator.pushNamed(context, AppRoutes.homePage);
                },
                    child: Text('Cadastrar', style: TextStyle(color: Colors.white), ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 60),
                      backgroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),),
                )
              ],
            ),
          ),
        ),
      ),
    );

  }
}