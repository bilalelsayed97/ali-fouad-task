// ignore_for_file: must_be_immutable

import 'package:ali_fouad_test/core/utility/colors_data.dart';
import 'package:ali_fouad_test/core/utility/strings_data.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintName;
  final String labelTxt;
  final TextInputType inputType;
  final bool isEnable;
  final bool isRead;
  final int inputLines;
  final int? length;
  final Color color;
  final bool isPass;
  final double? height;
  final double? fontSize;
  late bool passwordVisibility;
  late bool? focus;
  final bool prefixShow;
  final Function(String)? onChanged;
  final Function(CountryCode)? onChangedCode;
  final Function(String)? onSubmit;
  final String? Function(String?)? validatorFun;
  final Function()? onTapped;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;

  CustomTextField(
      {Key? key,
      this.controller,
      this.hintName,
      required this.labelTxt,
      this.isPass = false,
      this.passwordVisibility = false,
      this.inputType = TextInputType.text,
      this.isEnable = true,
      this.isRead = false,
      this.inputLines = 1,
      this.length,
      this.color = ColorsData.whiteColor,
      this.onChanged,
      this.onSubmit,
      this.onTapped,
      this.height,
      this.fontSize,
      this.validatorFun,
      this.focus,
      this.inputFormatters,
      this.prefixShow = false,
      this.onChangedCode,
      this.initialValue})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      controller: widget.controller,
      obscureText: widget.isPass ? !widget.passwordVisibility : false,
      enabled: widget.isEnable,
      readOnly: widget.isRead,
      autofocus: widget.focus ?? false,
      maxLength: widget.length,
      keyboardType: widget.inputType,
      maxLines: widget.inputLines,
      validator: widget.validatorFun ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${widget.hintName}';
            }
            return null;
          },
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmit,
      onTap: widget.onTapped,
      onTapOutside: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontFamily: StringsData.boldText,
          fontSize: 16,
          color: ColorsData.primaryColor),
      decoration: InputDecoration(
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.black54),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: ColorsData.primaryColor),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: ColorsData.redColor),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: ColorsData.redColor),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: ColorsData.greyColor),
        ),
        constraints: widget.height == null
            ? null
            : BoxConstraints(maxHeight: widget.height!),
        suffixIcon: widget.isPass
            ? IconButton(
                icon: Icon(
                  widget.passwordVisibility
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: Colors.black45,
                  size: 26,
                ),
                onPressed: () {
                  setState(() {
                    widget.passwordVisibility = !widget.passwordVisibility;
                  });
                },
              )
            : null,
        prefixIcon: widget.prefixShow == true
            ? SizedBox(
                height: 50,
                width: 80,
                child: CountryCodePicker(
                  onChanged: widget.onChangedCode,
                  initialSelection: 'AE',
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  alignLeft: true,
                  showFlag: true,
                  showFlagMain: true,
                  showFlagDialog: true,
                  padding: EdgeInsets.zero,
                ),
              )
            : null,
        label: Center(
          child: Padding(
            padding: EdgeInsets.only(left: widget.isPass ? 26 : 0),
            child: Text(
              widget.labelTxt,
              style: const TextStyle(
                  fontFamily: StringsData.boldText,
                  fontSize: 18,
                  color: Colors.black45),
            ),
          ),
        ),
        fillColor: widget.color,
        filled: true,
        counter: const SizedBox(),
      ),
      inputFormatters: widget.inputFormatters,
    );
  }
}
