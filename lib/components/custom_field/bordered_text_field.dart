import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metweet/utils/themes.dart';

class BorderedFormField extends StatelessWidget {
  final String hint;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool obscureText;
  final TextEditingController? textEditingController;
  final String? initialValue;
  final int? maxLine;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  BorderedFormField({
    required this.hint,
    this.textEditingController,
    this.initialValue,
    this.focusNode,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.onFieldSubmitted,
    this.maxLine,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.validator,
    this.suffixIcon,
    this.inputFormatters,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      cursorColor: Colors.white,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      controller: textEditingController,
      initialValue: initialValue,
      focusNode: focusNode,
      maxLines: maxLine,
      style: TextStyle(
        fontSize: 14,
        color: Colors.white,
      ),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding:
            EdgeInsets.only(left: 12, bottom: 12, top: 12, right: 12),
        labelText: hint,
        labelStyle: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        suffixIcon: suffixIcon,
      ),
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
    );
  }
}
