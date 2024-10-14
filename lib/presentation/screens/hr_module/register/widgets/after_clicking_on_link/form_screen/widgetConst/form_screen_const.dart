import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/hr_resources/hr_theme_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/app/services/base64/encode_decode_base64.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/top_row.dart';

class SignatureFormScreen extends StatefulWidget {
  final String documentName;
  final VoidCallback onPressed;
  final String htmlFormData;
  final int employeeId;
  final int htmlFormTemplateId;
  const SignatureFormScreen({super.key, required this.documentName, required this.onPressed,
    required this.htmlFormData, required this.employeeId, required this.htmlFormTemplateId});

  @override
  State<SignatureFormScreen> createState() => _SignatureFormScreenState();
}

class _SignatureFormScreenState extends State<SignatureFormScreen> {
  bool isLoading = false;
  dynamic pdfFile;
  @override
  void initState() {
    // TODO: implement initState

     pdfFile =  PdfGenerator.generatePdfFromHtmlString(widget.htmlFormData);
    print("Pdf String ${pdfFile}");
    // pdfFile = PdfGenerator.convertToBase64(pdfBytes);
    // print('Generated pdfBytes ${pdfFile}');
    super.initState();
  }
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
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: (){

                      }, icon: Icon(Icons.arrow_back)),
                  Text(widget.documentName,style: FormHeading.customTextStyle(context),),
                  Container(
                    height: 30,
                    width: 140,
                    child: isLoading ? Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),): CustomIconButton(
                      icon: Icons.arrow_forward_rounded,
                      text: 'Confirm',
                      onPressed: () async{
                        setState(() {
                          isLoading = true;
                        });
                        try{
                          await htmlFormTemplateSignature(context: context,
                            formHtmlTempId: widget.htmlFormTemplateId,
                            htmlName: widget.documentName,
                            documentFile: pdfFile,
                            employeeId: widget.employeeId,
                            signed: true,);
                        }finally{
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
            SizedBox(height: 50,),
         Container(
           height: MediaQuery.of(context).size.height/1.5,
           width: MediaQuery.of(context).size.height/2,
           child: Html(
             data: '''${widget.htmlFormData}''',
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
