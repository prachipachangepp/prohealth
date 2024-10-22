import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/hr_resources/hr_theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/app/services/base64/encode_decode_base64.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
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
  String? pdfBase64Url;
  bool isLoading = false;
  String? pdfFile;

   // String htmlContent = """${widget.htmlFormData}""";

  late PDFViewController pdfViewController;
  //late String dynamicHtmlData;

  int currentPage = 0;
  int totalPages = 0;
  bool isReady = false;
  String errorMessage = '';
  static const String viewType = 'html-viewer';
  String _uniqueKey = UniqueKey().toString(); // Unique key for re-rendering
   @override void didUpdateWidget(SignatureFormScreen oldWidget) { super.didUpdateWidget(oldWidget); // If HTML content changes, update the unique key to force re-render
  if (widget.htmlFormData != oldWidget.htmlFormData) { setState(() { _uniqueKey = UniqueKey().toString(); }); } }
  @override
  void initState() {
    super.initState();
    // pdfFile = widget.htmlFormData;
    // Register a view factory to create an iframe with the HTML content
    // setState((){
    //   dynamicHtmlData = widget.htmlFormData;
    // });
    // Register the view factory
    ui.platformViewRegistry.registerViewFactory(      'html-viewer-$_uniqueKey', // Use unique key in viewType
           (int viewId) {        final element = html.IFrameElement()
             ..srcdoc = widget.htmlFormData
             ..style.border = 'none'
             ..style.width = '100%'
             ..style.height = '600px';
      return element;      },    );
  }
  void toggleBack(){
    Navigator.pop(context);
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.pop(context);
                        // showDialog(context: context,
                        //     barrierDismissible: false,
                        //     builder: (BuildContext context){
                        //   return DeletePopup(onCancel: () { Navigator.pop(context); },
                        //     onDelete: () {
                        //       Navigator.pop(context);
                        //       toggleBack();
                        //     },
                        //     title: 'Cancel',
                        //     btnText: 'Yes',
                        //     text: 'Are you sure  you want to cancel this form?',);
                        // });
                      },
                      icon: Icon(Icons.arrow_back)),
                  Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p150),
                    child: Text(
                      widget.documentName,
                      style: FormHeading.customTextStyle(context),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 140,
                        child:  CustomButtonTransparent(
                          text: 'Cancel',
                          onPressed: () {
                            Navigator.pop(context);
                            // showDialog(context: context, builder: (BuildContext context){
                            //   return DeletePopup(onCancel: () { Navigator.pop(context); },
                            //     onDelete: () {
                            //     Navigator.pop(context);
                            //     toggleBack();
                            //     },
                            //     title: 'Cancel',
                            //     btnText: 'Yes',
                            //     text: ' Are you sure  you want to cancel this form?',);
                            // });

                            // widget.onPressed();
                          },
                        ),
                      ),
                      SizedBox(width: 10,),
                      Container(
                        height: 30,
                        width: 140,
                        child: isLoading ?
                        Center(child: SizedBox(
                          height:25,
                            width:25,
                            child: CircularProgressIndicator(color: ColorManager.blueprime,)),)
                            :CustomIconButton(
                          //icon: Icons.arrow_forward_rounded,
                          text: 'Confirm',
                          onPressed: () async{
                            pdfFile = await PdfGenerator.htmlToBase64Pdf(widget.htmlFormData);
                            print("Pdf byte ${pdfFile}");
                            setState(() {
                              isLoading = true;
                            });
                            try{
                              await htmlFormTemplateSignature(context: context,
                                formHtmlTempId: widget.htmlFormTemplateId,
                                htmlName: widget.documentName,
                                documentFile: pdfFile!,
                                employeeId: widget.employeeId,
                                signed: true,);
                            }finally{
                              setState(() {
                                isLoading = false;
                                Navigator.pop(context);
                                // toggleBack();
                              });
                            }
                            // showDialog(context: context, builder: (BuildContext context){
                            //   return
                            //     StatefulBuilder(
                            //       builder: (BuildContext context, void Function(void Function()) setState) {
                            //         return DeletePopup(
                            //           loadingDuration: isLoading,
                            //           onCancel: () { Navigator.pop(context); },
                            //           onDelete: () async{
                            //             setState(() {
                            //               isLoading = true;
                            //             });
                            //             try{
                            //               await htmlFormTemplateSignature(context: context,
                            //                 formHtmlTempId: widget.htmlFormTemplateId,
                            //                 htmlName: widget.documentName,
                            //                 documentFile: pdfFile!,
                            //                 employeeId: widget.employeeId,
                            //                 signed: true,);
                            //             }finally{
                            //               setState(() {
                            //                 isLoading = false;
                            //                 Navigator.pop(context);
                            //                 toggleBack();
                            //               });
                            //             }
                            //           },
                            //           title: 'Signed',
                            //           btnText: 'Yes',
                            //           text: 'Do you really want to Sign document?',);
                            //       },
                            //     );
                            // });

                            // widget.onPressed();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                child: HtmlElementView(viewType: 'html-viewer-$_uniqueKey')
              //HtmlElementView(viewType: viewType)
            ),
          ],
        ),
      ),
    );
  }
}
class PdfGenerator {
  // Convert HTML to a Base64-encoded PDF
  // static Future<String> htmlToBase64Pdf(String htmlContent) async {
  //   try {
  //     // Step 1: Generate PDF from HTML
  //     final dynamic pdfBytes = (await Printing.convertHtml(
  //       format: PdfPageFormat.a4,
  //       html: htmlContent,
  //     ));
  //
  //     // Step 2: Convert the generated PDF bytes to Base64
  //     final String base64Pdf = base64Encode(pdfBytes);
  //
  //     // Return the Base64-encoded PDF
  //     return base64Pdf;
  //   } catch (e) {
  //     print("Error generating PDF: $e");
  //     return "";
  //   }
  // }
  // Convert HTML string to a Base64-encoded PDF
  static Future<String> htmlToBase64Pdf(String htmlContent) async {
    try {
      // String strippedHtml = _removeCss(htmlContent);
      // String scaledHtml = _scaleHtmlToFitPage(htmlContent);
      final completer = Completer<String>();


      // JavaScript function to convert HTML to PDF and return Base64
      js.context.callMethod('htmlToPdf', [
        htmlContent,
        js.allowInterop((base64Pdf) {
          completer.complete(base64Pdf);
        })
      ]);

      final base64Pdf = completer.future;
      print(base64Pdf);
      return base64Pdf;
    } catch (e) {
      print(e);
      return "";
    }
  }
  // static String _scaleHtmlToFitPage(String htmlContent) {
  //   return '''
  //   <div style="width: 100%; height: 100vh; overflow: hidden; transform: scale(0.75); transform-origin: top left;">
  //     $htmlContent
  //   </div>
  //   ''';
  // }
}

///
/// class PdfGenerator {
//   // Convert HTML string to a Base64-encoded PDF
//   static Future<String> htmlToBase64Pdf(String htmlContent) async {
//     try {
//       final completer = Completer<String>();
//
//       // Add inline styles to body to enforce no margins
//       final modifiedHtml = '''
//       <html>
//         <head>
//           <style>
//             html, body {
//               margin: 0 !important;
//               padding: 0 !important;
//               width: 100%;
//               height: 100%;
//               overflow: hidden;
//             }
//           </style>
//         </head>
//         <body>
//           $htmlContent
//         </body>
//       </html>
//       ''';
//
//       // Call the JavaScript function with the modified HTML content
//       js.context.callMethod('htmlToPdf', [
//         modifiedHtml,
//         js.allowInterop((base64Pdf) {
//           completer.complete(base64Pdf);
//         })
//       ]);
//
//       final base64Pdf = await completer.future;
//       print(base64Pdf);
//       return base64Pdf;
//     } catch (e) {
//       print(e);
//       return "";
//     }
//   }
// }