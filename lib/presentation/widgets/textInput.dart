import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/config/app_colors.dart';

class MyTextFieldForm extends StatefulWidget {
  /*bool obscure;*/
  String hint;
  String assetNamePrefex;
  String assetNameSuffex;

  bool isPass;
  Color? fillColor;
  TextInputType textInput;
  bool isEditable;
  int? minLines;
  FocusNode? focusNode;
  int? maxLines;
  TextEditingController? textEditingController;
  FormFieldValidator? validator;
  MyTextFieldForm(
      {super.key,
      this.hint = "",
      /* this.obscure = false,*/
      this.assetNamePrefex = "",
        this.assetNameSuffex="",
      this.isPass = false,
        this.fillColor,
        this.focusNode,
        this.minLines,
        this.maxLines,
      this.isEditable = true,
      this.textInput = TextInputType.text,
      this.textEditingController,
      this.validator});

  @override
  State<MyTextFieldForm> createState() => _MyTextFieldFormState();
}

class _MyTextFieldFormState extends State<MyTextFieldForm> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      focusNode: widget.focusNode,
      controller: widget.textEditingController,
      enabled: widget.isEditable,
      obscureText: _obscured && widget.isPass,
      //This will obscure text dynamically
      keyboardType: widget.textInput,
      maxLength: widget.textInput == TextInputType.phone ? 11 : null,
      // initialValue: 'Input text',
      buildCounter: null,
      minLines:widget.maxLines,
      maxLines: widget.maxLines,
      validator: widget.validator,
      decoration: InputDecoration(
        //labelText: 'Label text',
        //helperMaxLines: null,
        errorStyle: TextStyle(color: Colors.red),
        helperText: null,
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.black26),
        // errorText: 'Error message',
        fillColor: widget.fillColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: AppColors.gray)),
        suffixIcon: widget.isPass
            ? IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _obscured ? Icons.visibility : Icons.visibility_off,
                  color:  AppColors.primary,
                ),
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _toggleObscured();
                  });
                },
              )
            : null,

        prefixIcon: widget.assetNamePrefex.isNotEmpty
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: SvgPicture.asset(
                  widget.assetNamePrefex,color: AppColors.secoundry,
                ),
              )
            : null,
        suffix:widget.assetNameSuffex.isNotEmpty
      ? Container(
      //padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SvgPicture.asset(
        widget.assetNameSuffex,
      ),
    )
        : null,
      ),
    );
  }
}
