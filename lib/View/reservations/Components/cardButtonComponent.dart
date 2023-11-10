import 'package:flutter/material.dart';
import 'package:gourmetbook/View/reservations/Components/customOutlinedButton.dart';
import 'package:gourmetbook/helpers/const.dart';

class CardButtonComponent extends StatelessWidget {
  const CardButtonComponent({
    required this.title,
    required this.isColored,
    required this.onPressed,
    super.key,
  });
  final String title;
  final bool isColored;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      padding: const EdgeInsets.all(
        defaultPadding / 2,
      ),
      constraints: const BoxConstraints(minWidth: 136),
      side: isColored ? null : BorderSide(color: ColorName.grey),
      enableGradient: isColored,
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          color: isColored ? ColorName.white : ColorName.black,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
