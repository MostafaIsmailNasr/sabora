import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../generated/assets.dart';

var searchBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(width: 0, color: Colors.white24));

class MySearchTextFieldForm extends StatefulWidget {
  /*bool obscure;*/
  String hint;
  String assetNamePrefex;
  TextInputType textInput;
  bool isEditable;
  TextEditingController? controller;
  ValueChanged<String>? onFieldSubmitted;
  MySearchTextFieldForm(
      {super.key,
      this.hint = "",
      /* this.obscure = false,*/
      this.assetNamePrefex = "",
      this.isEditable = true,
      this.controller,
      this.onFieldSubmitted,
      this.textInput = TextInputType.text});

  @override
  State<MySearchTextFieldForm> createState() => _MyTextFieldFormState();
}

class _MyTextFieldFormState extends State<MySearchTextFieldForm> {
  final textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      enabled: widget.isEditable,
      //This will obscure text dynamically
      keyboardType: TextInputType.text,

      // initialValue: 'Input text',
      buildCounter: null,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        //labelText: 'Label text',
        helperMaxLines: null,
        helperText: null,
        hintText: widget.hint,
        disabledBorder: searchBorder,
        enabledBorder: searchBorder,
        focusedBorder: searchBorder,
        hintStyle: const TextStyle(color: Colors.black26),
        fillColor: Colors.white,
        prefixIconColor: Colors.white,
        // errorText: 'Error message',
        border: InputBorder
            .none /*OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 0, color: AppColors.gray))*/
        ,

        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SvgPicture.asset(
            Assets.imagesSearch,
          ),
        ),
      ),
    );
  }
}
