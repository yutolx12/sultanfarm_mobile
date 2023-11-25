
import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Theme.dart';

class Controller extends StatelessWidget {
  final TextEditingController? controller;
  const Controller({
    super.key, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusColor: greyColor,
        border: OutlineInputBorder(
          
          borderRadius: BorderRadius.circular(10)
        ), focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color:Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: greyColor),
              borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
