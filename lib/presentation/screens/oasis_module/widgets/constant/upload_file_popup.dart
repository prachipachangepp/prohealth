import 'package:flutter/cupertino.dart';

class UploadFilePopup extends StatefulWidget {
  const UploadFilePopup({super.key});

  @override
  State<UploadFilePopup> createState() => _UploadFilePopupState();
}

class _UploadFilePopupState extends State<UploadFilePopup> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 110,
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

            ],
          ),
        )
      ],
    );
  }
}
