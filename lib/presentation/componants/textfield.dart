import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_lampa/core/utils/responsive.dart';

class DefaultTextField extends StatefulWidget {
  DefaultTextField({
    Key? key,
    this.controller,
    required this.keyboardType,
    this.label,
    this.hintText,
    this.suffixIcon,
    this.border,
    this.minlines,
    this.maxlines,
    this.onChange,
    required this.validate,
    this.focusNode,
    this.inputFormatter = const [],
    this.contentPadding,
    this.readOnly = false,
    this.enable,
    this.prefixIcon,
    this.borderColor = Colors.white,
    this.fillColor = Colors.white,
    this.textColor = Colors.white,
    this.hintColor = Colors.white,
    this.suffixIconColor = Colors.white,
    this.underlineInputBorder = Colors.white,
    this.textSize = 14.0,
  }) : super(key: key);
  bool? enable;
  bool readOnly;
  TextInputType keyboardType;
  Widget? suffixIcon;
  TextEditingController? controller;
  String? label;
  String? hintText;
  Color? fillColor;
  Color? borderColor;
  String? Function(String?) validate;
  FocusNode? focusNode;
  List<TextInputFormatter> inputFormatter;
  InputBorder? border;
  int? minlines;
  Widget? prefixIcon;
  int? maxlines;
  Color? textColor;
  double? textSize;
  Color? hintColor;
  Color? suffixIconColor;
  Color? underlineInputBorder;
  EdgeInsetsGeometry? contentPadding;
  Function(String)? onChange;
  @override
  _DefaultTextFieldState createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  bool? isPass;
  bool? visible;
  @override
  void initState() {
    isPass =
        widget.keyboardType == TextInputType.visiblePassword ? true : false;
    visible = isPass;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
          style: TextStyle(color: widget.textColor, fontSize: widget.textSize),
          enabled: widget.enable ?? true,
          onChanged: widget.onChange,
          focusNode: widget.focusNode,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: visible!,
          minLines: widget.minlines,
          maxLines: widget.maxlines ?? 1,
          inputFormatters: widget.inputFormatter,
          readOnly: widget.readOnly,
          //  autofocus: false,

          //style: TextStyle(color: AppColors.primiry),
          decoration: InputDecoration(
            filled: false,
            fillColor: widget.fillColor,
            prefixIcon: widget.prefixIcon != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.prefixIcon!,
                    ],
                  )
                : null,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            // fillColor: whiteColor70,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: widget.hintColor, fontSize: 13.fs),
            suffixIcon: widget.suffixIcon ??
                (isPass!
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible!;
                          });
                        },
                        icon: Icon(
                          visible! ? Icons.visibility : Icons.visibility_off,
                          color: widget.suffixIconColor,
                        ),
                      )
                    : widget.suffixIcon),

            labelText: widget.label,
            // enabledBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(
            //       color: widget.underlineInputBorder ?? Colors.white),
            // ),
            // focusedBorder: UnderlineInputBorder(
            //   borderSide: BorderSide(
            //       color: widget.underlineInputBorder ?? Colors.white),
            // ),
            border: widget.border ?? UnderlineInputBorder(),
            //  border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(10.0),
            //     ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.blue),
            //   borderRadius: BorderRadius.all(Radius.circular(35.0)),
            // ),
          ),
          validator: widget.validate),
    );
  }
}
