import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String campo;
  final TextEditingController controlador;
  final bool isBody;

  const CustomTextFormField({super.key, required this.campo, required this.controlador, this.isBody = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controlador,
        maxLines: isBody ? null : 1, // Se for o campo do corpo, permita várias linhas
        decoration: InputDecoration(
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey)
          ),
          hintText: campo,
          label: Text('$campo'),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
