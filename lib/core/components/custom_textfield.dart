import 'package:flutter/material.dart';
import '/core/constants/constants.dart';

class CustomTextfield extends StatelessWidget {
  final String hint;
  final Function(String val) onChanged;
  Function()? onTap;
  String initialValue;
  TextInputType keyboardType;
  String? Function(String? string)? validator;

  CustomTextfield(
      {Key? key,
      this.validator,
      required this.hint,
      required this.onChanged,
      this.onTap,
      this.initialValue = '',
      this.keyboardType = TextInputType.text})
      : super(key: key);

  final _border = OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        onChanged: onChanged,
        validator: validator,
        cursorColor: kGrey1,
        onTap: onTap,
        decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintText: hint,
            hintStyle: const TextStyle(color: kGrey1),
            enabledBorder: _border,
            border: _border),
      ),
    );
  }
}
