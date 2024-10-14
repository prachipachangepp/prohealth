import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prohealth/app/resources/hr_resources/hr_theme_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/top_row.dart';

class SignatureFormScreen extends StatefulWidget {
  final String documentName;
  final VoidCallback onPressed;
  final String htmlFormData;
  const SignatureFormScreen(
      {super.key,
      required this.documentName,
      required this.onPressed,
      required this.htmlFormData});

  @override
  State<SignatureFormScreen> createState() => _SignatureFormScreenState();
}

class _SignatureFormScreenState extends State<SignatureFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: TopRowConstant(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: IconButton(
                        onPressed: () {}, icon: Icon(Icons.arrow_back)),
                  ),
                  Text(
                    widget.documentName,
                    style: FormHeading.customTextStyle(context),
                  ),
                  Container(
                    height: 30,
                    width: 140,
                    child: CustomIconButton(
                      icon: Icons.arrow_forward_rounded,
                      text: 'Confirm',
                      onPressed: () async {
                        widget.onPressed();
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Html(
              data: widget.htmlFormData.toString(),
              // style: {
              //   "p": Style(
              //     fontSize: FontSize(12.0),
              //     color: Color(0xff686464),
              //     fontWeight: FontWeight.w400,
              //   ),
              //   "li": Style(
              //     fontSize: FontSize(12.0),
              //     color: Color(0xff686464),
              //     fontWeight: FontWeight.w400,
              //   ),
              // },
            ),
          ],
        ),
      ),
    );
  }
}
