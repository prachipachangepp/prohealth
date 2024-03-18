import 'package:flutter/material.dart';

///prachi
class ImpexTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String labelText;
  final int maxLines;
  final TextInputAction textInputAction;
  final void Function(String) onSubmitted;
  final bool autofocus;

  const ImpexTextField(
      {required this.controller,
      required this.obscureText,
      required this.keyboardType,
      required this.labelText,
      this.maxLines = 1,
      required this.textInputAction,
      required this.onSubmitted,
      this.autofocus = false});

  @override
  _ImpexTextFieldState createState() => _ImpexTextFieldState();
}

class _ImpexTextFieldState extends State<ImpexTextField> {
  FocusNode _focusNode = FocusNode();
  // Paint paint;

  InputDecoration buildTextInputDecoration(
    String labelText,
    TextEditingController controller,
  ) {
    return InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 3, vertical: 20),

      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.grey,
        height: 0.8,
        // background: paint,
      ),
      fillColor: Colors.transparent,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xffB1B1B1),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0xffB1B1B1),
          width: 2.0,
        ),
      ),
      // suffixIcon: InkWell(
      //   onTap: () => controller.clear(),
      //   child: Icon(Icons.cancel),
      // ),
      // prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 35,
      child: TextField(
        cursorHeight: 14,
        textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.center,
        focusNode: _focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        decoration:
            buildTextInputDecoration(widget.labelText, widget.controller),
        keyboardType: widget.keyboardType,
        autofocus: widget.autofocus,
        onSubmitted: widget.onSubmitted,
        onTap: () => setState(() {
          FocusScope.of(context).requestFocus(_focusNode);
        }),
        style: TextStyle(
          fontSize: 14, // Adjust the font size to your desired value
        ),
      ),
    );
    // Container(
    //   height: 20,
    //   width: 70,
    //   child: ListView(
    //     shrinkWrap: true,
    //     physics: ClampingScrollPhysics(),
    //     children: <Widget>[
    //       // Container(height: 12),
    //       TextField(
    //         textAlign: TextAlign.start,
    //         textAlignVertical: TextAlignVertical.center,
    //         focusNode: _focusNode,
    //         controller: widget.controller,
    //         obscureText: widget.obscureText ?? false,
    //         maxLines: widget.maxLines,
    //         textInputAction: widget.textInputAction,
    //         decoration:
    //             buildTextInputDecoration(widget.labelText, widget.controller),
    //         keyboardType: widget.keyboardType,
    //         autofocus: widget.autofocus,
    //         onSubmitted: widget.onSubmitted,
    //         onTap: () => setState(() {
    //           FocusScope.of(context).requestFocus(_focusNode);
    //         }),
    //       ),
    //     ],
    //   ),
    // );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
