import 'package:flutter/material.dart';
import '/core/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints.expand(
            width: double.infinity, height: itemHeight),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(text,
              style: const TextStyle(color: Colors.white, fontSize: 18.0)),
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),
      ),
    );
  }
}
