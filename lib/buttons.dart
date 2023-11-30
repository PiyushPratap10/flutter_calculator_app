import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});
  final void Function(String str) onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(text);
      },
      child: Card(
        shape: const CircleBorder(eccentricity: 1.0),
        elevation: 5,

        color: Theme.of(context).primaryColorDark,
        child: Container(
          height: 65,
          width: 65,
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
