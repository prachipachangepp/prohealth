import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/hr_resources/hr_theme_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/top_row.dart';

class SignatureFormScreen extends StatefulWidget {
  final String documentName;
  final VoidCallback onPressed;
  final String htmlFormData;
  final int employeeId;
  final int htmlFormTemplateId;
  const SignatureFormScreen(
      {super.key,
      required this.documentName,
      required this.onPressed,
      required this.htmlFormData,
      required this.employeeId,
      required this.htmlFormTemplateId});

  @override
  State<SignatureFormScreen> createState() => _SignatureFormScreenState();
}

class _SignatureFormScreenState extends State<SignatureFormScreen> {
  bool isLoading = false;
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
                  IconButton(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back)),
                  Text(
                    widget.documentName,
                    style: FormHeading.customTextStyle(context),
                  ),
                  Container(
                    height: 30,
                    width: 140,
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            ),
                          )
                        : CustomIconButton(
                            icon: Icons.arrow_forward_rounded,
                            text: 'Confirm',
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              try {
                                await htmlFormTemplateSignature(
                                  context: context,
                                  formHtmlTempId: widget.htmlFormTemplateId,
                                  htmlName: widget.documentName,
                                  documentFile: widget.htmlFormData,
                                  employeeId: widget.employeeId,
                                  signed: true,
                                );
                              } finally {
                                setState(() {
                                  isLoading = false;
                                  Navigator.pop(context);
                                });
                              }
                              // widget.onPressed();
                            },
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Html(data: """

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employment Application Form</title>
</head>

<body>
    <div>
        <!-- Header Section with Company Name and Icon -->
        <div>
            <div>PRO HEALTH HOME INC.</div>
            <div>
                <!-- Placeholder for icon; replace src with your desired icon URL -->
                <img src="https://via.placeholder.com/50" alt="Hospital Icon">
            </div>
        </div>

        <h2>CONFIDENTIALITY STATEMENT (HIPPA)</h2>
        <hr color='blue' width='2' />
        <p>In order to protect the right of patients to privacy, communication in any form regarding patient’s protected
            health care information shall be confidential. All patient information is to be held in strictest confidence
            and shall not be disclosed or discussed except in the course of professional responsibilities.</p>
        <p>This includes communication between patients and their families/caregivers, between health professionals, and the
            information contained in patients’ health care records maintained by the Agency and all OASIS information.</p>
        <p>I understand the ethics of confidentiality of patient information and agree to adhere to the above standard.</p>
        <p>I understand that violation of the confidentiality standard may be cause for termination.</p>

        <div>
            <!-- Signature section -->
            <div>
                <!-- Placeholder for signature image from backend -->
                <img id="signature-placeholder"
                    src="https://cdn.pixabay.com/photo/2022/01/11/21/48/link-6931554_960_720.png"
                    alt="Signature Placeholder" width='100' height='100'>
                   
            </div>

            <!-- Date section -->
            <div>
                <input type="text" id="date" value="10-07-2024" readonly>
            </div>
        </div>

        <!-- Field labels for Signature and Today's Date -->
        <div>
            <div>
                <label for="signature"><strong>Employee Signature</strong></label>
            </div>
            <div>
                <label for="date"><strong>Date</strong></label>
            </div>
        </div>
    </div>
</body>

</html>
""",
              style: customStyles,
                  //'${widget.htmlFormData}',
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
            ),
          ],
        ),
      ),
    );
  }
}

final Map<String, Style> customStyles = {
  "body": Style(
    margin: Margins.zero,
    padding: HtmlPaddings.symmetric(horizontal: 40),
    backgroundColor: Color(0xff989797),
    fontFamily: 'Helvetica',
  ),
  ".container": Style(
    width: Width(70, Unit.percent),
    margin: Margins.symmetric(vertical: 50.0),
    padding: HtmlPaddings.all(50),
    backgroundColor: Colors.white,
    border: Border.all(color: Color(0xffdddddd), width: 1.0),
    textShadow: [
      BoxShadow(color: Colors.black12, blurRadius: 10.0),
    ],
    //position: Position.relative,
  ),
  ".blue-line": Style(
    width: Width(100, Unit.percent),
    height: Height(12, Unit.px),
    backgroundColor: Color(0xff0056b3),
    margin: Margins.only(bottom: 10.0),
  ),
  ".blue-header": Style(
    width: Width(100, Unit.percent),
    height: Height(8, Unit.px),
    backgroundColor: Color(0xff0056b3),
    margin: Margins.only(bottom: 20.0),
  ),
  "h2": Style(
    textAlign: TextAlign.center,
    textTransform: TextTransform.uppercase,
    fontWeight: FontWeight.w700,
    margin: Margins.only(bottom: 30.0),
  ),
  ".header-section": Style(
    display: Display.inlineBlock,
    textAlign: TextAlign.center,
  //  justifyContent: MainAxisAlignment.spaceBetween,
    alignment: Alignment.center,
    padding: HtmlPaddings.only(bottom: 20.0),
  ),
  ".header-left": Style(
    fontFamily: 'Helvetica',
    fontSize: FontSize(24.0),
    color: Color(0xff212122),
    fontWeight: FontWeight.w300,
  ),
  ".header-right img": Style(
    width: Width(50, Unit.px),
    height: Height(50, Unit.px),
  ),
  ".signature-date-container": Style(
    display: Display.listItem,
  //  justifyContent: MainAxisAlignment.spaceBetween,
    alignment: Alignment.bottomRight,
    margin: Margins.symmetric(vertical: 20.0),
  ),
  ".signature-container img": Style(
    width: Width(100, Unit.px),
    display: Display.block,
    margin: Margins.only(bottom: 10.0),
  ),
  ".date-container input": Style(
    padding: HtmlPaddings.all(5.0),
    border: Border.all(),
    backgroundColor: Colors.transparent,
    //outline: Outline.none,
    fontSize: FontSize(16.0),
    textAlign: TextAlign.start,
  ),
  ".horizontal-line": Style(
    width: Width(100, Unit.percent),
    height: Height(1, Unit.px),
    backgroundColor: Colors.grey,
    margin: Margins.symmetric(vertical: 10.0),
  ),
  ".bottom-line": Style(
    width: Width(100, Unit.percent),
    height: Height(2, Unit.px),
    backgroundColor: Colors.blue,
  ),
  ".page-break": Style(
    //pageBreakAfter: PageBreak.after,
  ),
};
