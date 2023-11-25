import 'package:flutter/material.dart';
import 'package:sultan_farm_mobile/Models/size_button_selected.dart';
import 'package:sultan_farm_mobile/Theme.dart';

class SelectedButton extends StatelessWidget {
  final Size size;
  const SelectedButton(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: size.isActive
          ? Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: bluetogreenColor,
              ),
              child: Text(
                size.name,
                style: blackTextStyle.copyWith(
                  color: primary99Color,
                  fontWeight: semiBold,
                  fontSize: 14,
                  letterSpacing: 0.1,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: neutral95Color,
              ),
              child: Text(
                size.name,
                style: blackTextStyle.copyWith(
                  color: dark50Color,
                  fontWeight: semiBold,
                  fontSize: 14,
                  letterSpacing: 0.1,
                ),
              ),
            ),
    );
  }
}
