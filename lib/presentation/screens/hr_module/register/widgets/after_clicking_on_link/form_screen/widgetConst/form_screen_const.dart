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
      // WebView( initialUrl: Uri.dataFromString(widget.htmlFormData, mimeType: 'text/html').toString(),
      //   javascriptMode: JavascriptMode.unrestricted,),
            Html(
  data: '''${widget.htmlFormData}''',
  // data:
  //     '''<!DOCTYPE html>\n<html lang=\"en\">\n\n<head>\n<meta charset=\"UTF-8\">\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n<title>Employment Application Form</title>\n<style>\nbody {\nfont-family: 'Helvetica', sans-serif;\nmargin: 0;\npadding: 0;\nbackground-color: #989797;\n}\n\n.container {\nwidth: 70%;\nmargin: 50px auto;\nbackground-color: #fff;\npadding: 50px;\nborder: 1px solid #ddd;\nbox-shadow: 0 0 10px rgba(0, 0, 0, 0.1);\nposition: relative;\n}\n\n.blue-line {\nwidth: 100%;\nheight: 12px;\nbackground-color: #0056b3;\nmargin-bottom: 10px;\n}\n\n.blue-header {\nwidth: 100%;\nheight: 8px;\nbackground-color: #0056b3;\nmargin-bottom: 20px;\n}\n\nh2 {\ntext-align: center;\ntext-transform: uppercase;\nfont-weight: 700;\nmargin-bottom: 30px;\n}\n\nh3 {\ntext-align: left;\ntext-transform: uppercase;\nfont-weight: 700;\nmargin-bottom: 30px;\ncolor: #0056b3;\n}\n\n.logo {\ntext-align: center;\nmargin-bottom: 20px;\n}\n\n.header-section {\ndisplay: flex;\njustify-content: space-between;\nalign-items: center;\npadding-bottom: 20px;\n}\n\n.header-left {\nfont-family: 'Helvetica', sans-serif;\nfont-size: 24px;\ncolor: #212122;\nfont-weight: lighter;\n}\n\n.header-right img {\nwidth: 50px;\nheight: 50px;\n}\n\n.page-break {\npage-break-after: always;\n}\n\n.signature-date-container {\ndisplay: flex;\njustify-content: space-between;\nalign-items: flex-end;\nmargin: 20px 0;\n}\n\n.signature-container,\n.date-container {\ndisplay: flex;\nflex-direction: column;\nflex: 1;\n}\n\n.signature-container img {\nmax-width: 150px;\ndisplay: block;\nmargin-bottom: 10px;\n}\n\n.date-container input {\npadding: 5px;\nborder: none;\nbackground: transparent;\noutline: none;\nfont-size: 16px;\ntext-align: right;\n}\n\n.horizontal-line {\nwidth: 100%;\nheight: 1px;\nbackground-color: grey;\nmargin: 10px 0;\n}\n\n.field-label {\nfont-size: 12px;\ncolor: grey;\ntext-align: right;\n}\n\n.date-container {\nalign-items: flex-end;\n}\n\n.bottom-line {\nwidth: 100%;\nheight: 2px;\nbackground-color: skyblue;\n}\n</style>\n</head>\n\n<body>\n<div class=\"container\">\n<div class=\"header-section\">\n<div class=\"header-left\">PRO HEALTH HOME INC.</div>\n<div class=\"header-right\">\n<img src=\"https://via.placeholder.com/50\" alt=\"Hospital Icon\">\n</div>\n</div>\n\n<h2>ON-CALL/WEEKEND STAFFING</h2>\n\n<div class=\"blue-header\"></div>\n<h3>PURPOSE</h3>\n<p>To define the on-call system for assuring 24-hour coverage of services </p>\n<h3>POLICY</h3>\n<p>Patient care needs are the highest priority; therefore, weekend and evening staffing will be scheduled accordingly. Clinical personnel are expected to perform visits on an as-needed basis, including weekends and holidays. There will on-call staff available after-hours Monday through Friday, and 24 hours a day on weekends and holidays. Staff on-call will be:</p>\n<ol type=\"1\">\n<li>Administrative call by a Senior Management staff member</li>\n<li>Clinical call by a registered nurse (It’s optional for all registered nurses to participate in an on-call rotation) </li>\n</ol>\n<h3>PROCEDURE</h3>\n<ol type=\"1\">\n<li>On admission, each patient will be made aware of the organization’s 24-hour availability. </li>\n<li>The on-call schedule will be developed on a monthly basis by the Clinical Director or designee. The schedule will be forwarded to the answering service and on-call staff.</li>\n<li>The on-call schedule can be reached by calling the home health number. After hours, this number will be forwarded to a professional answering service.</li>\n<li>The on-call nurse will be issued a pager and/or a cellular phone to allow for mobility.</li>\n<li>Reports will be given to the on-call nurse daily Monday through Friday.</li>\n</ol>\n\n<div class=\"signature-date-container\">\n<div class=\"signature-container\">\n<img id=\"signature-placeholder\" src=\"{url}\" alt=\"Signature Placeholder\">\n</div>\n<div class=\"date-container\">\n<input type=\"text\" id=\"date\" value=\"{date}\" readonly>\n</div>\n</div>\n\n<div class=\"horizontal-line\"></div>\n<div class=\"signature-date-container\">\n<div class=\"signature-container\">\n<label for=\"signature\">Signature</label>\n</div>\n<div class=\"date-container\">\n<label for=\"date\">Today's Date</label>\n</div>\n</div>\n\n<div class=\"bottom-line\"></div>\n</div>\n</body>\n\n</html>''',
  style: {
    'body': Style(
      backgroundColor: Color(0xFF989797),
    ),
    'h2': Style(
      textAlign: TextAlign.center,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    'h3': Style(
      color: Color(0xFF0056b3),
      fontWeight: FontWeight.bold,
    ),
    'p': Style(
      margin: Margins.symmetric(vertical: 10),
      fontSize: FontSize.medium,
    ),
    '.signature-container img': Style(
      width: Width(150),
    ),
    '.header-right img': Style(
      width: Width(50),
      height: Height(50),
    ),
  },
),
          ],
        ),
      ),
    );
  }
}
