// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../constants.dart';
class CustomFormTextField  extends StatefulWidget {
  String? hint;
  IconData? suffix;
  IconData? prefix;
  Function(String)? onChanged;
  CustomFormTextField({super.key, required this.hint,this.suffix,this.prefix,this.isObscureText = false,this.onChanged});
  late bool isObscureText;


  @override
  State<CustomFormTextField> createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  bool isPasswordShown = false;
  bool get isPasswordShownGetter => isPasswordShown;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return  Padding(
      padding: EdgeInsets.all(mediaQuery.size.width * 0.02),
      child: TextFormField(
        validator: (data)
        {
          if(data!.isEmpty)
            {
              return "This field must not be empty";
            }
          return null;
        },
        onChanged: widget.onChanged,
        obscureText:widget.isObscureText ? !isPasswordShown : false,
        style: const TextStyle(color:kPrimaryColor),
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: widget.hint ,
          hintStyle: const TextStyle(color: kPrimaryColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: kPrimaryColor,
                  width: 1,
            )
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                  color: kPrimaryColor,
                width: 2,
              )
          ),
          suffixIcon: widget.isObscureText
              ? IconButton(
            icon: Icon(
              isPasswordShown
                  ? Icons.visibility
                  : Icons.visibility_off,
              color:kPrimaryColor,
            ),
            onPressed: () {
              setState(() {
                isPasswordShown = !isPasswordShown;
              });
            },
          )
              : null,
          prefixIcon: Icon(widget.prefix),
          prefixIconColor: kPrimaryColor

        ),
      ),
    );
  }
}
