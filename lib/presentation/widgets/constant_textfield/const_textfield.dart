import 'package:flutter/material.dart';

///prachi to do textfield constant widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double? width;
  final double? height;
  final double cursorHeight;
  final String labelText;
  final TextStyle labelStyle;
  final double labelFontSize;
  final Icon? suffixIcon;
  final IconData? prefixIcon;
  final FocusNode focusNode;

  CustomTextField({
    this.width,
    this.height,
    required this.cursorHeight,
    required this.labelText,
    required this.labelStyle,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    required this.focusNode,
    required this.labelFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 250,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 130),
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: cursorHeight,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3, top: 5, left: 2),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              labelText: labelText,
              labelStyle: labelStyle.copyWith(fontSize: labelFontSize),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(left: 14),
                child: suffixIcon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///drop down text field prachi to do

class CustomDropdownTextField extends StatefulWidget {
  final String? value;
  final List<String> items;
  final String labelText;
  final TextStyle? labelStyle;
  final double? labelFontSize;
  final void Function(String?)? onChanged;
  final double? width;
  final double? height;

  const CustomDropdownTextField({
    Key? key,
    this.value,
    required this.items,
    required this.labelText,
    this.labelStyle,
    this.labelFontSize,
    this.onChanged,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _CustomDropdownTextFieldState createState() =>
      _CustomDropdownTextFieldState();
}

class _CustomDropdownTextFieldState extends State<CustomDropdownTextField> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        width: 250,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: DropdownButtonFormField<String>(
            icon: Icon(Icons.arrow_drop_down_sharp, color: Color(0xff50B5E5)),
            value: _selectedValue,
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedValue = newValue;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }
            },
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: 3, top: 5, left: 2),
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              labelText: widget.labelText,
              labelStyle:
                  widget.labelStyle?.copyWith(fontSize: widget.labelFontSize),
            ),
          ),
        ),
      ),
    );
  }
}

//
// class CustomDropdownTextField extends StatelessWidget {
//   final String? value;
//   final List<String> items;
//   final String labelText;
//   final TextStyle? labelStyle;
//   final double? labelFontSize;
//   final void Function(String?)? onChanged;
//   final double? width;
//   final double? height;
//
//   const CustomDropdownTextField({
//     Key? key,
//     this.value,
//     required this.items,
//     required this.labelText,
//     this.labelStyle,
//     this.labelFontSize,
//     this.onChanged,
//     this.width,
//     this.height,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 200,
//       height: 38,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: DropdownButtonFormField<String>(
//           icon: Icon(Icons.arrow_drop_down_sharp),
//           value: value,
//           items: items.map((String value) {
//             return DropdownMenuItem<String>(
//               value: value,
//               child: Text(value),
//             );
//           }).toList(),
//           onChanged: onChanged,
//           isExpanded: true,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.only(bottom: 3, top: 5, left: 2),
//             border: OutlineInputBorder(),
//             labelText: labelText,
//             labelStyle: labelStyle?.copyWith(fontSize: labelFontSize),
//           ),
//         ),
//       ),
//     );
//   }
// }

// ///prachi
// class ImpexTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final bool obscureText;
//   final TextInputType keyboardType;
//   final String labelText;
//   final int maxLines;
//   final TextInputAction textInputAction;
//   final void Function(String) onSubmitted;
//   final bool autofocus;
//
//   const ImpexTextField(
//       {required this.controller,
//       required this.obscureText,
//       required this.keyboardType,
//       required this.labelText,
//       this.maxLines = 1,
//       required this.textInputAction,
//       required this.onSubmitted,
//       this.autofocus = false});
//
//   @override
//   _ImpexTextFieldState createState() => _ImpexTextFieldState();
// }
//
// class _ImpexTextFieldState extends State<ImpexTextField> {
//   FocusNode _focusNode = FocusNode();
//   // Paint paint;
//
//   InputDecoration buildTextInputDecoration(
//     String labelText,
//     TextEditingController controller,
//   ) {
//     return InputDecoration(
//       contentPadding: EdgeInsets.symmetric(horizontal: 3, vertical: 20),
//
//       labelText: labelText,
//       labelStyle: TextStyle(
//         color: Colors.grey,
//         height: 0.8,
//         // background: paint,
//       ),
//       fillColor: Colors.transparent,
//       filled: true,
//       enabledBorder: OutlineInputBorder(
//         borderSide: const BorderSide(
//           color: Color(0xffB1B1B1),
//           width: 1.0,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: const BorderSide(
//           color: Color(0xffB1B1B1),
//           width: 2.0,
//         ),
//       ),
//       // suffixIcon: InkWell(
//       //   onTap: () => controller.clear(),
//       //   child: Icon(Icons.cancel),
//       // ),
//       // prefixIcon: prefixIcon == null ? null : Icon(prefixIcon),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 160,
//       height: 35,
//       child: TextField(
//         cursorHeight: 14,
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
//         style: TextStyle(
//           fontSize: 14, // Adjust the font size to your desired value
//         ),
//       ),
//     );
//     // Container(
//     //   height: 20,
//     //   width: 70,
//     //   child: ListView(
//     //     shrinkWrap: true,
//     //     physics: ClampingScrollPhysics(),
//     //     children: <Widget>[
//     //       // Container(height: 12),
//     //       TextField(
//     //         textAlign: TextAlign.start,
//     //         textAlignVertical: TextAlignVertical.center,
//     //         focusNode: _focusNode,
//     //         controller: widget.controller,
//     //         obscureText: widget.obscureText ?? false,
//     //         maxLines: widget.maxLines,
//     //         textInputAction: widget.textInputAction,
//     //         decoration:
//     //             buildTextInputDecoration(widget.labelText, widget.controller),
//     //         keyboardType: widget.keyboardType,
//     //         autofocus: widget.autofocus,
//     //         onSubmitted: widget.onSubmitted,
//     //         onTap: () => setState(() {
//     //           FocusScope.of(context).requestFocus(_focusNode);
//     //         }),
//     //       ),
//     //     ],
//     //   ),
//     // );
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
// }
