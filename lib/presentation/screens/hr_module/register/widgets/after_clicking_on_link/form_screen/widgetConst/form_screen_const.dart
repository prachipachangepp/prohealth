import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;
import 'package:pdf/pdf.dart';

import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/hr_resources/hr_theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/top_row.dart';

class SignatureFormScreen extends StatefulWidget {
  final String documentName;
  final VoidCallback onPressed;
  final String htmlFormData;
  final int employeeId;
  final int htmlFormTemplateId;
  final bool isDisable;
  const SignatureFormScreen(
      {
        super.key,
      required this.documentName,
      required this.onPressed,
      required this.htmlFormData,
      required this.employeeId,
      required this.htmlFormTemplateId,
      required this.isDisable});

  @override
  State<SignatureFormScreen> createState() => _SignatureFormScreenState();
}

class _SignatureFormScreenState extends State<SignatureFormScreen> {
  String? pdfBase64Url;
  bool isLoading = false;
  String? pdfFile;
  late PDFViewController pdfViewController;

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
    base64Converter();
    ui.platformViewRegistry.registerViewFactory('html-viewer-$_uniqueKey', // Use unique key in viewType
           (int viewId) {        final element = html.IFrameElement()
             ..srcdoc = widget.htmlFormData
             ..style.border = 'none'
             ..style.width = '100%'
             ..style.height = '600px';
      return element;
      },);
  }
  void toggleBack(){
    Navigator.pop(context);
  }
   void base64Converter() async {
     pdfFile = await PdfGenerator.htmlToBase64Pdf(widget.htmlFormData);
   }



  //
  // Future<String> _generatePdfAndConvertToBase64() async {
  //   final pdf = pw.Document(); // Create PDF page with HTML content (or any content)
  //   pdf.addPage(pw.MultiPage(
  //     pageFormat: PdfPageFormat.a4, // A4 page size
  //     margin: pw.EdgeInsets.zero,
  //     build: (context) =>
  //   [
  //
  //     pw.Center(child: pw.Text("PDF with HTML content"),),
  //     pw.SizedBox(height: 20), pw.Paragraph(
  //     text: widget.htmlFormData,),
  //   ],
  //   ),); // Convert the PDF document to bytes
  //   final pdfBytes = await pdf.save(); // Encode bytes to Base64
  //   String base64String = base64Encode(
  //       pdfBytes); // Output the Base64 string to console (for example purposes)
  //   print("Base64 PDF String: $base64String");
  //   return base64String;
  // }
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
                  widget.isDisable
                      ? SizedBox(width: 140,)
                      : Row(
                    children: [
                      widget.isDisable?SizedBox(width: 140,):Container(
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

                          //  pdfFile = await _generatePdfAndConvertToBase64();
                          // pdfFile = await PdfGenerator.htmlToBase64Pdf(widget.htmlFormData);
                            ///
                          //.replaceAll('\\n', '').replaceAll('\\t', '').trim());
//                             pdfFile = await PdfGenerator.htmlToBase64Pdf("""
//                             <!DOCTYPE html>
// <html lang="en">
//
// <head>
//     <meta charset="UTF-8">
//     <meta name="viewport" content="width=device-width, initial-scale=1.0">
//     <title>i-9 paper version</title>
//     <style>
//         body {
//             font-family: 'Helvetica', sans-serif;
//             margin: 0;
//             padding: 0;
//         }
//
//
//         .container {
//             width: 85%;
//             height: 100
//             margin: 50px auto;
//             background-color: #fff;
//             padding: 50px;
//             border: 1px solid #ddd;
//             box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
//             position: relative;
//         }
//
//         .header {
//             display: flex;
//             justify-content: space-between;
//             align-items: center;
//             text-align: center;
//             padding: 0;
//         }
//
//         .header img {
//             height: 100%;
//             max-height: 100px;
//             /* Adjust max height according to the design */
//             object-fit: contain;
//             /* Ensures the image maintains its aspect ratio */
//         }
//
//         .header .center-text {
//             flex: 1;
//             text-align: center;
//             line-height: 1.2;
//         }
//
//         .header .right-text {
//             text-align: center;
//             line-height: 0.8;
//         }
//
//         .header h2,
//         .header p {
//             margin: 5px 0;
//         }
//
//         .f {
//             font-size: 23px;
//             font-weight: normal;
//         }
//
//         .s {
//             margin-left: 12px;
//         }
//
//         .m {
//             margin-left: 150px;
//
//         }
//
//         .c {
//             text-align: center;
//         }
//
//         .top_center {
//
//             text-align: center;
//             vertical-align: text-top;
//         }
//
//         .marginpadding {
//             margin: 10px;
//             padding: 0;
//         }
//
//         .thick-line {
//             border-bottom: 5px solid black;
//             /* Thick black line */
//             width: 100%;
//             margin-bottom: 2px;
//             /* No extra margin */
//         }
//
//         /* Normal line covering the full width */
//         .normal-line {
//             border-bottom: 2px solid black;
//             /* Normal line */
//             width: 100%;
//             margin-bottom: 25px;
//             /* No extra margin */
//         }
//
//         .blue-box {
//             background-color: #0056b3;
//
//             /* Sets the background color to blue */
//             color: white;
//             /* Sets the text color to white */
//             padding: 2px;
//             /* Adds some padding inside the box */
//             border-radius: 0;
//             /* Optional: Adds rounded corners */
//             text-align: left;
//             /* Optional: Centers the text */
//             font-size: 14px;
//             /* Adjusts the text size */
//             width: 100%;
//             border: 1px solid grey;
//             box-sizing: border-box;
//         }
//
//         .blue-box p {
//             margin: 0;
//             padding: 0;
//         }
//
//         .first-table {
//             width: 100%;
//             /* Full width of the container */
//             border-collapse: collapse;
//             /* Remove space between borders */
//             table-layout: auto;
//             /* Allow columns to adjust to their content */
//         }
//
//         /* Table cell styling for the first table */
//         .first-table th,
//         .first-table td {
//             border: 1px solid grey;
//             /* Thin border around cells */
//             padding: 5px;
//             /* Padding inside cells */
//             text-align: left;
//             /* Left align text */
//         }
//
//         /* Styles for the second table */
//         .second-table {
//             width: 100%;
//             /* Full width of the container */
//             border-collapse: collapse;
//             /* Remove space between borders */
//             table-layout: auto;
//             /* Allow columns to adjust to their content */
//             margin: 0;
//             /* Margin above the second table */
//         }
//
//         /* Table cell styling for the second table */
//         .second-table th,
//         .second-table td {
//             border: none;
//             padding: 0;
//             margin: 0;
//             /* More padding for cells */
//             text-align: center;
//
//         }
//
//         .third-table {
//             width: 80%;
//             /* Full width of the container */
//             border-collapse: collapse;
//             /* Remove space between borders */
//             table-layout: auto;
//             /* Allow columns to adjust to their content */
//         }
//
//         /* Table cell styling for the first table */
//         .third-table th,
//         .third-table td {
//             border: 1px solid grey;
//             /* Thin border around cells */
//             padding: 5px;
//             /* Padding inside cells */
//             text-align: left;
//             /* Left align text */
//         }
//
//         /* Styling for field names and values */
//         .field-container {
//             display: flex;
//             /* Flexbox for layout */
//             flex-direction: column;
//             font-size: 14px;
//         }
//
//         .field-value {
//             margin-top: 5px;
//         }
//
//         .digit-box {
//             display: inline-block;
//             width: 20px;
//             height: 30px;
//             border: 1px solid grey;
//             text-align: center;
//             line-height: 30px;
//             font-family: monospace;
//             margin: 0;
//         }
//
//         .digit-box.connected {
//             margin-right: -5px;
//             margin-bottom: -5px;
//             /* Overlap the border by adjusting the margin */
//         }
//
//         /* Style for the separator dashes */
//         .dash {
//             display: inline-block;
//             margin: 0 5px;
//             margin-left: 10px;
//
//             /* Adjust spacing for the dash */
//         }
//
//         .short_underline {
//             border-bottom: 1px solid black;
//             padding: 0 40px;
//             /* Adds a little padding around the text */
//             margin-left: 80px;
//         }
//
//         .long_underline {
//             border-bottom: 1px solid black;
//             padding: 0 100px;
//             /* Adds a little padding around the text */
//             margin-left: 80px;
//         }
//
//         .row {
//             display: flex;
//             width: 100%;
//         }
//
//         .column {
//             width: 50%;
//             padding: 5px;
//             box-sizing: border-box;
//             border: 1px solid grey;
//         }
//
//         .image-section img {
//             max-width: 10%;
//             text-align: left;
//             vertical-align: top;
//             padding: 0;
//         }
//
//         .text-section {
//             display: flex;
//             align-items: flex-start;
//         }
//
//         .text-section input {
//             border: none;
//             /* Remove border */
//             outline: none;
//             /* Remove the focus outline */
//             width: 50%;
//             /* Makes the input take the full width of its container */
//             padding: 0;
//             box-sizing: border-box;
//             font-size: inherit;
//             /* Match the text size with surrounding text */
//             background-color: transparent;
//             /* Makes the background transparent */
//             color: inherit;
//             /* Matches the color of surrounding text */
//         }
//
//         .text-section input::placeholder {
//             color: grey;
//             /* Style the placeholder text */
//         }
//
//         .box {
//             display: flex;
//             border: 2px solid grey;
//             width: 100%;
//             height: auto;
//             /* Adjust height to accommodate content */
//         }
//
//         .section1 {
//             width: 31%;
//             display: flex;
//             flex-direction: column;
//             border-right: 2px solid grey;
//         }
//
//         .subsection {
//             border-bottom: 2px solid grey;
//             padding: 0;
//         }
//
//         .subsection:last-child {
//             border-bottom: none;
//             /* Remove the last bottom border */
//         }
//
//         .section2 {
//             width: 3%;
//             display: flex;
//             align-items: center;
//             justify-content: center;
//             border-right: 2px solid grey;
//         }
//
//         .section3 {
//             width: 66%;
//             display: flex;
//             flex-direction: column;
//         }
//
//         /* Top section divided into 3 subsections */
//         .top-section {
//             display: flex;
//             height: 33%;
//             /* Adjust as needed */
//             border-bottom: 2px solid grey;
//         }
//
//         .subsection-1,
//         .subsection-3 {
//             width: 49%;
//             padding: 0;
//             border-right: 2px solid grey;
//             display: flex;
//             flex-direction: column;
//         }
//
//         .subsection-2 {
//             width: 2%;
//             padding: 10px;
//             border-right: 2px solid grey;
//             display: flex;
//             align-items: center;
//             justify-content: center;
//         }
//
//
//         /* Bottom section with two boxes */
//         .bottom-section {
//             display: flex;
//             height: 67%;
//             /* Adjust as needed */
//         }
//
//         .box1 {
//             width: 55%;
//             border-right: 2px solid grey;
//             padding: 0;
//             display: flex;
//             align-items: center;
//             justify-content: center;
//         }
//
//         .inner-box {
//             width: 80%;
//             height: 80%;
//             border: 2px solid grey;
//             display: flex;
//             align-items: left;
//             vertical-align: top;
//             margin: 0;
//             padding: 5px;
//         }
//
//
//         .box2 {
//             width: 45%;
//             padding: 0;
//             display: flex;
//             align-items: center;
//             justify-content: center;
//         }
//
//         .rows {
//             border-bottom: 1px solid grey;
//             padding: 5px 0;
//         }
//
//         .rows:last-child {
//             border-bottom: none;
//         }
//
//         .centermargin {
//             text-align: center;
//             margin-bottom: 90px;
//             margin-top: 10px;
//         }
//
//         .specialrow {
//             display: flex;
//             justify-content: center;
//             /* Center-aligns the entire row */
//             width: 100%;
//         }
//
//         .section {
//             text-align: center;
//             padding: 0;
//             font-weight: bold;
//             margin: 0;
//         }
//
//         .sub-1 {
//             width: 31%;
//             /* 1st section */
//         }
//
//         .sub-2 {
//             width: 3%;
//             /* 2nd section */
//         }
//
//         .sub-3 {
//             width: 31.5%;
//             /* 3rd section */
//         }
//
//         .underline {
//             border-bottom: 1px solid black;
//             padding: 0 80px;
//
//             /* Adds a little padding around the text */
//         }
//
//         .greyrow {
//             display: flex;
//             justify-content: space-between;
//             /* Aligns text at opposite corners */
//             background-color: grey;
//             /* Grey background */
//             padding: 2px 5px;
//         }
//
//         .left-text {
//             text-align: left;
//             /* Align text to the left */
//         }
//
//         .right-text {
//             text-align: right;
//             /* Align text to the right */
//         }
//
//         .lastbox {
//             display: flex;
//             width: 100%;
//             /* Full width */
//             border: 1px solid grey;
//             /* Grey border */
//             box-sizing: border-box;
//         }
//
//         .lastnewsection-1 {
//             width: 32%;
//             /* 1st section: 32% */
//             padding-top: 10px;
//             text-align: center;
//             /* Center the header */
//             display: flex;
//             flex-direction: column;
//             box-sizing: border-box;
//         }
//
//         .lastnewsection-2 {
//             width: 4%;
//             /* 2nd section: 4% */
//             background-color: grey;
//             /* Grey background */
//             padding: 0;
//             text-align: center;
//             padding-top: 60px;
//             font-weight: bold;
//         }
//
//         .lastnewsection-3 {
//             width: 64%;
//             padding-top: 10px;
//             text-align: center;
//             /* Center the header */
//             display: flex;
//             flex-direction: column;
//             box-sizing: border-box;
//         }
//
//         /* Header in newsection-3 */
//         .lastheader {
//             display: flex;
//             justify-content: space-between;
//             text-align: center;
//             font-weight: bold;
//             /* Center align the headers */
//         }
//
//         .lastheader .lastsubsection {
//             padding: 10px;
//             text-align: center;
//             /* Ensure each header section is centered */
//         }
//
//         .lastheader .lastsubsection-1,
//         .lastheader .lastsubsection-2 {
//             width: 45%;
//             /* Equal length subsections */
//         }
//
//         .lastheader .lastsubsection-3 {
//             width: 10%;
//             /* Smaller subsection */
//         }
//
//         .lastequal-sections {
//             display: flex;
//             width: 100%;
//             height: 100%;
//             margin: 0;
//             box-sizing: border-box;
//         }
//
//         .lastequal-sections .lastsection {
//             width: 50%;
//             /* Fully joined equal sections */
//             border: 1px solid grey;
//             /* Grey border */
//             padding: 0;
//             box-sizing: border-box;
//             text-align: left;
//         }
//
//         /* Ordered List styles inside each section */
//         .lastnewsection-1 ol,
//         .lastnewsection-3 ol,
//         .lastsection ol {
//             padding: 0;
//             margin: 0;
//             list-style-position: outside;
//             text-align: left;
//             padding-left: 25px;
//             line-height: 1.5em;
//         }
//
//         .liunder {
//             width: 100%;
//             padding: 0;
//             margin: 0;
//             border-bottom: 1px solid grey;
//
//         }
//
//         .lastnewsection-1 li:last-child,
//         .lastsection li:last-child {
//             border-bottom: none;
//             /* Remove the bottom border for the last item */
//         }
//
//         /* Ensure headers are centered */
//         .lastheader-text {
//             font-weight: bold;
//             text-align: center;
//             padding-bottom: 2px;
//         }
//
//         .page-break {
//             page-break-after: always;
//         }
//
//         .bottom-line {
//             width: 100%;
//             height: 2px;
//             margin: 0;
//             /* Removes any margin */
//             padding: 0;
//             /* Ensures no padding */
//             background-color: skyblue;
//             /* Sky blue color for the line */
//         }
//
//         .footer {
//             color: black;
//             /* Keeps the text black */
//             padding: 10px 20px;
//             /* Adds padding inside the footer */
//             width: 100%;
//             /* Makes sure the footer takes up the full width of the page */
//             display: flex;
//             justify-content: space-between;
//             /* Aligns content to the left and right */
//             box-sizing: border-box;
//             margin: 0;
//             /* Ensures no margin between footer and bottom-line */
//             padding-top: 0;
//             /* Ensures no extra padding above */
//         }
//
//         .footer-left,
//         .footer-right {
//             font-size: 14px;
//             /* Adjust the text size */
//         }
//
//         .footer-right {
//             text-align: right;
//             /* Ensures the right text is aligned properly */
//         }
//     </style>
// </head>
//
// <body>
//
//     <div class="container">
//         <header class="header">
//             <!-- Left corner: Image -->
//             <div class="left">
//                 <img src="{url}" alt="Logo">
//             </div>
//
//             <!-- Middle: Long text -->
//             <div class="center-text">
//                 <h2>Employment Eligibility Verification</h2>
//                 <h2>Department of Homeland Security</h2>
//                 <p class="f">U.S. Citizenship and Immigration Services</p>
//             </div>
//
//             <!-- Right corner: Small text -->
//             <div class="right-text">
//                 <h2>USCIS</h2>
//                 <h2>Form l-g</h2>
//                 <p>OMB No. 1615-0047 </p>
//                 <p>Expires 10/30/2022</p>
//             </div>
//         </header>
//
//
//
//         <!-- Thick black line below the header -->
//         <div class="thick-line"></div>
//
//         <!-- Normal line below the thick line -->
//         <div class="normal-line"></div>
//         <p>➢ <strong>START HERE: Read instructions carefully before comlpeting this form. The instructions must be
//                 available,
//                 either in paper or electronically, during completion of this form. Employers are liable for errors in
//                 the
//                 completion of this form.</strong></p>
//         <p><strong>ANTI-DISCRIMINATION NOTICE: </strong>It is illegal to discriminate against work-authorized
//             individuals. Employers <strong>CANNOT</strong>specify whichdocument(s) an employee may present to establish
//             employment authorization and identity. The refusal to hire or continue to employ an individual because the
//             documentation presented has a future expiration date may also constitute illegal discrimination.</p>
//
//         <div class="blue-box"> <span><strong>SECTION 1. Employee Information and Attestation
//                 </strong><em>(Employees must complete and
//                     sign Section 1 of Form 1-9 no later
//                     than the </strong>first day of employment</strong>, but not before accepting a job
//                     offer.)</em></span>
//         </div>
//
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Last Name <em>(Family Name)</em></span>
//                         <span class="field-value">{lastname}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>First Name <em> (Given Name)</em></span>
//                         <span class="field-value">{firstname}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Middle Initial</span>
//                         <span class="field-value">{middlename}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Other Last Names Used <em> (if any)</em></span>
//                         <span class="field-value">{otherLastName}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Address <em>(Street Number and Name)</em></span>
//                         <span class="field-value">{address}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Apt. Number</span>
//                         <span class="field-value">{aptNumber}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>City or Town</span>
//                         <span class="field-value">{City}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>State</span>
//                         <span class="field-value">{State}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Zip Code</span>
//                         <span class="field-value">{Zipcode}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Date of Birth <em>(mm/dd/yyyy)</em></span>
//                         <span class="field-value">{dateOfBirth}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>U.S. Social Security Number</span>
//                         <span class="field-value">
//                             <table class="second-table">
//                                 <tr>
//                                     <td>
//                                         {SSNNbr}
//                                     </td>
//                                 </tr>
//                             </table>
//                         </span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Employee's E-mail Address</span>
//                         <span class="field-value">{email}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Employee's Telephone Number</span>
//                         <span class="field-value">{primaryPhoneNbr}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//
//
//
//
//         <p><strong>I am aware that federal law provides for imprisonment and/or fines for false statements or use of
//                 false
//                 documents in connection with the completion of this form.
//             </strong></p>
//
//         <p><strong> I attest, under penalty of perjury, that I am (Check one of the following boxes):</strong></p>
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>{citizenship}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <em>Aliens authorized to work must provide only one of the following document numbers to
//                             complete Form 1-9:
//                         </em>
//                         <p class="s">{alienInfo}</p>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span class="top_center">QR Code-Section 1
//                             Do Not <br>Write in This Space</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//
//         <br>
//
//         <div class="row">
//             <div class="column image-section">
//                 <p>Signature of Employee: <img src="{url}" alt="signature image" /></p>
//             </div>
//             <div class="column text-section">
//                 <p>Today's Date <em>(mm/dd/yyyy)</em>:<input type="text" placeholder="{date}" /></p>
//             </div>
//         </div>
//         <br>
//         <div class="blue-box">
//             <p>Prepare and/or Translator Certification (check one):</p>
//             <p><input type="checkbox">I did not use a preparer or translator. <input type="checkbox">A preparer(s)
//                 and/or translator(s) assisted the employee in completing
//                 Section 1.</p>
//             <p><em>(Fields below must be completed and signed when prepares and/or translators assist an employee in
//                     completing Section 1.)</em></p>
//         </div>
//         <p><strong>I attest, under penalty or perjury, that I have assisted in the completion of Section 1 of this form
//                 and that to
//                 the best of my knowledge the information is true and correct.</strong></p>
//
//         <div class="row">
//             <div class="column image-section">
//                 <p>Signature of Preparer or Translator: <img src="{url}"
//                         alt="sigature image of preparer or translator" /></p>
//             </div>
//             <div class="column text-section">
//                 <p>Today's Date <em>(mm/dd/yyyy)</em>>:<input type="text" placeholder="{date}" /></p>
//             </div>
//         </div>
//         <div class="row">
//             <div class="column text-section">
//                 <p>Last Name <em>(Family Name)</em>:<input type="text" placeholder="{lastname}" /></p>
//             </div>
//             <div class="column text-section">
//                 <p>First Name <em>(Given Name)</em>:<input type="text" placeholder="{firstname}" /></p>
//             </div>
//         </div>
//
//
//
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Address <em>(Street Number and Name)</em></span>
//                         <span class="field-value">{address}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>City or Town</span>
//                         <span class="field-value">{City}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>State</span>
//                         <span class="field-value">{State}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Zip Code</span>
//                         <span class="field-value">{Zipcode}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <p class="c"><em>Employees Completes Next Page</em></p>
//         <br>
//         <br>
//
//         <div class="bottom-line"></div>
//         <div class="footer">
//             <div class="footer-left">
//                 Form I-9 10/21/2019
//             </div>
//             <div class="footer-right">
//                 Page 1 of 3
//             </div>
//         </div>
//
//     </div>
//     <div class="page-break"></div>
//
//     <div class="container">
//         <header class="header">
//             <!-- Left corner: Image -->
//             <div class="left">
//                 <img src="{url}" alt="Logo">
//             </div>
//
//             <!-- Middle: Long text -->
//             <div class="center-text">
//                 <h2>Employment Eligibility Verification</h2>
//                 <h2>Department of Homeland Security</h2>
//                 <p class="f">U.S. Citizenship and Immigration Services</p>
//             </div>
//
//             <!-- Right corner: Small text -->
//             <div class="right-text">
//                 <h2>USCIS</h2>
//                 <h2>Form l-g</h2>
//                 <p>OMB No. 1615-0047 </p>
//                 <p>Expires 10/30/2022</p>
//             </div>
//         </header>
//         <!-- Thick black line below the header -->
//         <div class="thick-line"></div>
//
//         <!-- Normal line below the thick line -->
//         <div class="normal-line"></div>
//         <div class="blue-box">
//             <p><strong>SECTION 2. Employer or Authorized Representative Review and Verification
//                 </strong></p>
//             <p><em>(Employees or their authorized
//                     representative must complete and sign Section 2 within 3 business days of the employee’s first day
//                     of
//                     employment. You must physically examine one document from List A OR a combination of one document
//                     from List B
//                     and one document from List C as listed on the “Lists of Acceptable Documents.”)</em></p>
//         </div>
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span><strong>Employee Infor from Section 1</strong></span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Last Name <em>(Family Name)</em></span>
//                         <span class="field-value">{lastname}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>First Name <em>(Given Name)</em></span>
//                         <span class="field-value">{firstname}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>M.I.</span>
//                         <span class="field-value">{middlename}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Citizenship/Immigration Status</span>
//                         <span class="field-value">{citizenship}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <br>
//         <div class="specialrow">
//             <div class="section sub-1">List A<br>Identity and Employment Authorization
//             </div>
//             <div class="section sub-2">OR</div>
//             <div class="section sub-3">List B <br>
//                 Identity</div>
//             <div class="section sub-2">AND</div>
//             <div class="section sub-3">List C <br>
//                 Employment Authorization</div>
//         </div>
//         <div class="box">
//             <!-- Section 1: Three subsections with four rows each -->
//             <div class="section1">
//                 <div class="subsection">
//                     <div class="rows">Document Title
//                         <br><span>{documentTitle}</span>
//                     </div>
//                     <div class="rows">Issuing Authority
//                         <br><span>{issuingAuthority}</span>
//                     </div>
//                     <div class="rows">Document Number
//                         <br><span>{documentNumber}</span>
//                     </div>
//                     <div class="rows">Expiration Date <em>(if any) (mm//dd/yyyy)</em>
//                         <br><span>{expirationDate}</span>
//                     </div>
//                 </div>
//                 <div class="subsection">
//                     <div class="rows">Document Title
//                         <br><span>{documentTitle}</span>
//                     </div>
//                     <div class="rows">Issuing Authority
//                         <br><span>{issuingAuthority}</span>
//                     </div>
//                     <div class="rows">Document Number
//                         <br><span>{documentNumber}</span>
//                     </div>
//                     <div class="rows">Expiration Date <em>(if any) (mm//dd/yyyy)</em>
//                         <br><span>{expirationDate}</span>
//                     </div>
//                 </div>
//                 <div class="subsection">
//                     <div class="rows">Document Title
//                         <br><span>{documentTitle}</span>
//                     </div>
//                     <div class="rows">Issuing Authority
//                         <br><span>{issuingAuthority}</span>
//                     </div>
//                     <div class="rows">Document Number
//                         <br><span>{documentNumber}</span>
//                     </div>
//                     <div class="rows">Expiration Date <em>(if any) (mm//dd/yyyy)</em>
//                         <br><span>{expirationDate}</span>
//                     </div>
//                 </div>
//             </div>
//             <div class="section2"></div>
//             <div class="section3">
//                 <div class="top-section">
//                     <div class="subsection-1">
//                         <div class="rows">Document Title
//                             <br><span>{documentTitle}</span>
//                         </div>
//                         <div class="rows">Issuing Authority
//                             <br><span>{issuingAuthority}</span>
//                         </div>
//                         <div class="rows">Document Number
//                             <br><span>{documentNumber}</span>
//                         </div>
//                         <div class="rows">Expiration Date <em>(if any) (mm//dd/yyyy)</em>
//                             <br><span>{expirationDate}</span>
//                         </div>
//                     </div>
//                     <div class="subsection-2"></div>
//                     <div class="subsection-3">
//                         <div class="rows">Document Title
//                             <br><span>{documentTitle}</span>
//                         </div>
//                         <div class="rows">Issuing Authority
//                             <br><span>{issuingAuthority}</span>
//                         </div>
//                         <div class="rows">Document Number
//                             <br><span>{documentNumber}</span>
//                         </div>
//                         <div class="rows">Expiration Date <em>(if any) (mm//dd/yyyy)</em>
//                             <br><span>{expirationDate}</span>
//                         </div>
//                     </div>
//                 </div>
//                 <div class="bottom-section">
//                     <div class="box1">
//                         <div class="inner-box">Additional Information</div>
//                     </div>
//                     <div class="box2 centermargin">
//                         <div class="inner-box">QR Code – Section 1 <br>Do Not Write in This Space </div>
//                     </div>
//                 </div>
//             </div>
//         </div>
//         <br>
//         <p><strong>Certification: I attest, under penalty of perjury, that (1) I have
//                 examined the document(s) presented by the above-named employee, (2) the above-listed document(s) appear
//                 to
//                 be genuine and to relate to the employee named, and (3) to the best of my knowledge the employee is
//                 authorized
//                 to work in the United States.</strong></p>
//         <p><strong>The employee’s first day of employment <em> (mm/dd/yyyy): <span class="underline">{date}</span> (See
//                     instructions for exemptions)</em></strong></p>
//         <br>
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Signature of Employer or Authorized Representative</span>
//                         <span class="field-value">{url}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Today’s Date <em> (mm/dd/yyyy)</em></span>
//                         <span class="field-value">{date}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Title of Employer or Authorized Representative</span>
//                         <span class="field-value">{title}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Last Name of Employer or Authorized Representative</span>
//                         <span class="field-value">{lastname}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>First Name of Employer or Authorized Representative</span>
//                         <span class="field-value">{firstname}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Employer’s Business or Organization Name</span>
//                         <span class="field-value">{businessOrgName}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Employer’s Business or Organization Address <em>(Street Number and Name)</em></span>
//                         <span class="field-value">{businessOrgAddress}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>City or Town</span>
//                         <span class="field-value">{companyCity}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>State</span>
//                         <span class="field-value">{companyState}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Zip code</span>
//                         <span class="field-value">{companyZipcode}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <br>
//         <div class="blue-box"> <span><strong>Section 3. Reverification and Rehires</strong><em>(To be completed and
//                     signed by employer or authorized representative.) </em></span>
//         </div>
//         <div class="greyrow">
//             <div class="left-text"><strong>A. </strong>New Name <em>(if applicable)</em></div>
//             <div class="right-text"><strong>B. </strong>Date of Rehire <em>(if applicable)</em></div>
//         </div>
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Last Name <em>(Family Name)</em></span>
//                         <span class="field-value">{lastname}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>First Name <em> (Given Name)</em></span>
//                         <span class="field-value">{firstname}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Middle Initial</span>
//                         <span class="field-value">{middlename}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Date <em> (mm/dd/yyyy)</em></span>
//                         <span class="field-value">{date}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <br>
//
//         <div class="greyrow">
//             <div class="left-text">If the employee’s previous grant of employment authorization has expired, provide the
//                 information for the document or receipt that establishes continuing employment authorization in the
//                 space provided below.</div>
//         </div>
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Document Title</span>
//                         <span class="field-value">{title}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Document Number</span>
//                         <span class="field-value">{documentNumber}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Expiration Date <em>(if any) (mm/dd/yyyy)</em></span>
//                         <span class="field-value">{date}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <p><strong>I attest, under penalty of perjury, that to the best of my knowledge,
//                 this
//                 employee is authorized to work in the United States, and if the employee presented document(s) I have
//                 examined
//                 appear to be genuine and to relate to the individual.</strong></p>
//
//
//         <table class="first-table">
//             <tr>
//                 <td>
//                     <div class="field-container">
//                         <span>Signature of Employer or Authorized Representative</span>
//                         <span class="field-value">{url}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Today’s Date <em>(mm/dd/yyyy)</em></span>
//                         <span class="field-value">{date}</span>
//                     </div>
//                 </td>
//                 <td>
//                     <div class="field-container">
//                         <span>Name of Employer or Authorized Representative</span>
//                         <span class="field-value">{name}</span>
//                     </div>
//                 </td>
//             </tr>
//         </table>
//         <br>
//         <br>
//
//         <div class="bottom-line"></div>
//         <div class="footer">
//             <div class="footer-left">
//                 Form I-9 10/21/2019
//             </div>
//             <div class="footer-right">
//                 Page 2 of 3
//             </div>
//         </div>
//
//     </div>
//     <div class="page-break"></div>
//
//     <div class="container">
//         <br>
//         <div class="thick-line"></div>
//         <div class="normal-line"></div>
//
//         <h2 class="top_center marginpadding">LIST OF ACCEPTABLE DOCUMENTS</h2>
//         <p class="top_center marginpadding"><strong>All documents must be UNEXPIRED</strong></p>
//         <p class="top_center marginpadding">Employees may present one selectio from List A
//             <br>or a combination of one selection from List B and one selection from List C.
//         </p>
//         <br>
//         <div class="lastbox">
//             <div class="lastnewsection-1">
//                 <!-- Centered Header for newsection-1 -->
//                 <div class="lastheader-text">List A<br>Documents that Establish<br>Both Identity and<br>Employment
//                     Authorization</div>
//                 <!-- Ordered list for newsection-1 -->
//                 <div class="liunder"></div>
//                 <ol start="1">
//                     <li>U.S. Passport or U.S. Passport Card</li>
//                 </ol>
//                 <div class="liunder"></div>
//                 <ol start="2">
//                     <li>Permanent Resident Card or Alien Registration Receipt Card (Form I-551)</li>
//                 </ol>
//                 <div class="liunder"></div>
//                 <ol start="3">
//                     <li>Foreign passport that contains a
//                         temporary I-551 stamp or temporary I-551 printed notation on a machine-readable immigrant visa
//                     </li>
//                 </ol>
//                 <div class="liunder"></div>
//                 <ol start="4">
//                     <li>Employment Authorization Document that contains a
//                         photograph (Form I-766) </li>
//                 </ol>
//                 <div class="liunder"></div>
//                 <ol start="5">
//                     <li>For
//                         a nonimmigrant alien authorized to work for a specific employer because of his or her status:
//                         <ol type="a">
//                             <li> Foreign passport; and</li>
//                             <li>Form I-94 or Form I-94A that has the following:</li>
//                             <ol type="(1)">
//                                 <li>The same name as the passport; and</li>
//                                 <li>An endorsement of the alien’s nonimmigrant status as long as that period of
//                                     endorsement has not yet
//                                     expired and the
//                                     proposed employment is not in conflict with any restrictions or limitation
//                                     identified on the
//                                     form.</li>
//                             </ol>
//                         </ol>
//                     </li>
//                 </ol>
//                 <div class="liunder"></div>
//                 <ol start="6">
//                     <li>Passport from the Federated States of Micronesia (FSM) or the Republic of the Marshall Islands
//                         (RMI) with Form I-94 or Form I-94A indicating nonimmigrant admission under the Compact of Free
//                         Association
//                         Between the United States and the FSM or RMI</li>
//                 </ol>
//             </div>
//             <div class="lastnewsection-2">OR</div>
//             <div class="lastnewsection-3">
//                 <div class="lastheader">
//                     <div class="lastsubsection lastsubsection-1">List B <br>Documents and Establish<br>Identity</div>
//                     <div class="lastsubsection lastsubsection-3">AND</div>
//                     <div class="lastsubsection lastsubsection-2">List C<br>Documents that Establish<br>Employment
//                         Authorization</div>
//                 </div>
//
//                 <!-- Two fully joined equal sections with ordered lists -->
//                 <div class="lastequal-sections">
//                     <div class="lastsection">
//                         <div class="liunder"></div>
//                         <ol start="1">
//                             <li>Driver’s license or ID card issued by a State or outlying possession of the United
//                                 States provided it contains a
//                                 photograph or information such as name, date of birth, gender, height, eye color, and
//                                 address</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="2">
//                             <li> ID card issued
//                                 by federal, state or local government agencies or entities, provided it contains a
//                                 photograph or information
//                                 such as name, date of birth, gender, height, eye color, and address</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="3">
//                             <li>School ID card with a photograph</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="4">
//                             <li>Voter’s registration card</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="5">
//                             <li> U.S. Military card or draft record</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="6">
//                             <li>Military dependent’s ID card</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="7">
//                             <li>U.S. Coast Guard Merchant Mariner Card</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="8">
//                             <li>Native American tribal document</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="9">
//                             <li>Driver’s license issued by a Canadian government authority</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <p class="c"><strong>For persons under age 18 who are unable to present a document
//                                 listed above:</strong></p>
//                         <div class="liunder"></div>
//                         <ol start="10">
//                             <li>School record or report card</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="11">
//                             <li>Clinic, doctor, or hospital record</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="12">
//                             <li>Day-care or nursery
//                                 school record</li>
//                         </ol>
//                     </div>
//                     <div class="lastsection">
//                         <div class="liunder"></div>
//                         <ol start="1">
//                             <li>A Social
//                                 Security Account Number card, unless the card includes one of the following
//                                 restrictions: (1) NOT VALID FOR
//                                 EMPLOYMENT (2) VALID FOR WORK ONLY WITH INS AUTHORIZATION (3) VALID FOR WORK ONLY WITH
//                                 DHS AUTHORIZATION</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="2">
//                             <li>Certification of report of birth issued
//                                 by the Department of State (Forms DS-1350, FS-545, FS-240)</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="3">
//                             <li>Original or certified copy of birth certificate issued by a State, county, municipal
//                                 authority, or territory of the United States bearing an official seal</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="4">
//                             <li>Native American tribal document</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="5">
//                             <li>U.S. Citizen ID Card (Form I-197)</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="6">
//                             <li>Identification Card for Use of Resident Citizen in the United States (Form I-179)</li>
//                         </ol>
//                         <div class="liunder"></div>
//                         <ol start="7">
//                             <li>Employment authorization document
//                                 issued by the Department of Homeland Security</li>
//                         </ol>
//                     </div>
//                 </div>
//             </div>
//         </div>
//         <p class="top_center marginpadding"><strong>Examples of many of these documents appear in the Handbook for
//                 Employers (M-274). </strong></p>
//         <br>
//         <p class="top_center marginpadding"><strong>Refer to the Instructions for more information about acceptable
//                 receipts.</strong></p>
//         <br>
//         <br>
//         <div class="bottom-line"></div>
//         <div class="footer">
//             <div class="footer-left">
//                 Form I-9 10/21/2019
//             </div>
//             <div class="footer-right">
//                 Page 3 of 3
//             </div>
//         </div>
//
//     </div>
//     <div class="page-break"></div>
//
//
//
// </body>
//
// </html>""");
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:100,),
              child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: HtmlElementView(viewType: 'html-viewer-$_uniqueKey')
                //HtmlElementView(viewType: viewType)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// class PdfGenerator {
//   static Future<String> htmlToBase64Pdf(String htmlContent) async {
//     try {
//       // Generate PDF from HTML using proper margins and page size
//       final pdf = pw.Document();
//
//       pdf.addPage(
//         pw.Page(
//           pageFormat: PdfPageFormat.a4.copyWith(
//             marginBottom: 20, // Adjust margins if needed
//             marginLeft: 20,
//             marginRight: 20,
//             marginTop: 20,
//           ),
//           build: (pw.Context context) {
//             return pw.Center(
//               child: pw.Text(
//                 htmlContent,//'PDF Content\n\n', // Just for test, will replace with actual HTML.
//                 style: pw.TextStyle(fontSize: 14),
//               ),
//             );
//           },
//         ),
//       );
//
//       // Convert PDF to Uint8List
//       Uint8List pdfBytes = await pdf.save();
//
//       // Convert Uint8List to Base64 String
//       String base64Pdf = base64Encode(pdfBytes);
//       return base64Pdf;
//     } catch (e) {
//       print("Error generating PDF: $e");
//       return '';
//     }
//   }
// }
///code by sir
class PdfGenerator {
  static Future<String> htmlToBase64Pdf(String htmlContent) async {
    try {
      final completer = Completer<String>();

      // Wrap the HTML content with styles that support multi-page rendering
      final formattedHtmlContent = '''
      <html>
        <head>
          <style>
            @page {
              size: A4; /* Define A4 page size */
              margin: 20mm; /* Set page margins */
            }

            body {
              margin: 0;
              padding: 0;
              font-family: 'Times New Roman', serif;
              -webkit-print-color-adjust: exact; /* Ensure colors render correctly */
            }

            .pdf-content {
              width: 860; 
              margin: 0;
              padding: 5mm;
              font-family: 'Times New Roman', serif;
              word-wrap: break-word; /* Prevent text overflow */
            }

            /* Ensure content flows correctly across pages */
            .page-break {
              page-break-before: always;
              break-before: page;
            }
          </style>
        </head>
        <body>
          <div class="pdf-content">
            $htmlContent
          </div>
        </body>
      </html>
      ''';

      // JavaScript function to convert HTML to PDF and return Base64
      js.context.callMethod('htmlToPdf', [
        formattedHtmlContent,
        js.allowInterop((base64Pdf) {
          completer.complete(base64Pdf);
        })
      ]);

      final base64Pdf = await completer.future;
      print(base64Pdf);
      return base64Pdf;
    } catch (e) {
      print("Error generating PDF: $e");
      return "";
    }
  }
}

// class PdfGenerator {
//   static Future<String> htmlToBase64Pdf(String htmlContent) async {
//     try {
//       final completer = Completer<String>();
//
//       // Wrap the HTML content in a styled container for consistent rendering
//       final formattedHtmlContent = '''
//       <html>
//         <head>
//           <style>
//             @page {
//               size: A4; /* Define page size */
//               margin: 20mm; /* Set margins */
//             }
//
//             body {
//               margin: 0; /* Reset body margin */
//               padding: 0;
//               font-family: 'Times New Roman', serif;
//             }
//
//             .pdf-content {
//               width: 870px;
//               height: 1080px;
//               margin: 0;
//               padding: 5mm; /* Add padding inside the content */
//               font-family: 'Times New Roman', serif;
//               word-wrap: break-word; /* Prevent text overflow issues */
//             }
//           </style>
//         </head>
//         <body>
//           <div class="pdf-content">
//             $htmlContent
//           </div>
//         </body>
//       </html>
//       ''';
//
//       // JavaScript function to convert HTML to PDF and return Base64
//       js.context.callMethod('htmlToPdf', [
//         formattedHtmlContent,
//         js.allowInterop((base64Pdf) {
//           completer.complete(base64Pdf);
//         })
//       ]);
//
//       final base64Pdf = await completer.future;
//       print(base64Pdf);
//       return base64Pdf;
//     } catch (e) {
//       print("Error generating PDF: $e");
//       return "";
//     }
//   }
// }
///
// class PdfGenerator {
//   static Future<String> htmlToBase64Pdf(String htmlContent) async {
//     try {
//       final completer = Completer<String>();
//       // JavaScript function to convert HTML to PDF and return Base64
//       js.context.callMethod('htmlToPdf', [
//         htmlContent,
//         js.allowInterop((base64Pdf) {
//           completer.complete(base64Pdf);
//         })
//       ]);
//
//       final base64Pdf = completer.future;
//       print(base64Pdf);
//       return base64Pdf;
//     } catch (e) {
//       print(e);
//       return "";
//     }
//   }
// }
///
// class PdfGenerator {
//   // Convert HTML string to a Base64-encoded PDF
//   static Future<String> htmlToBase64Pdf(String htmlContent) async {
//     try {
//       final completer = Completer<String>();
//
//       // Wrap HTML with A4-specific styles
//       final modifiedHtml = '''
//       <html>
//       <head>
//         <style>
//           @page {
//             size: A4; /* Set to A4 size */
//             margin: 0; /* Remove all margins */
//           }
//           html, body {
//             margin: 0;
//             padding: 0;
//             width: 300mm; /* A4 width */
//             height: 297mm; /* A4 height */
//             box-sizing: border-box;
//           }
//         </style>
//       </head>
//       <body>
//         $htmlContent
//       </body>
//       </html>
//       ''';
//
//       // JavaScript function to convert the modified HTML to PDF
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
//       print('Error: $e');
//       return "";
//     }
//   }
// }
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
///flutter html to pdf package
// class PdfGenerator {
//   // Convert HTML to PDF and return a Base64 string
//   static Future<String> htmlToBase64Pdf(String htmlContent) async {
//     try {
//       // Get the directory to store the PDF temporarily
//       final Directory tempDir = await getTemporaryDirectory();
//       final String tempPath = tempDir.path;
//       final String pdfFileName = "generated_pdf";
//
//       // Generate the PDF from HTML
//       final File pdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
//         htmlContent,
//         tempPath,
//         pdfFileName,
//       );
//
//       // Convert the PDF file to bytes
//       final pdfBytes = await pdfFile.readAsBytes();
//
//       // Convert bytes to Base64 string
//       final base64Pdf = base64Encode(pdfBytes);
//
//       print('Base64 PDF: $base64Pdf'); // Debug output
//       return base64Pdf;
//     } catch (e) {
//       print('Error generating PDF: $e');
//       return "";
//     }
//   }
// }


// class SignatureFormScreen extends StatefulWidget {
//   final String htmlFormData;
//   final String documentName;
//   final String htmlFormTemplateId;
//   final String employeeId;
//
//   SignatureFormScreen({
//     required this.htmlFormData,
//     required this.documentName,
//     required this.htmlFormTemplateId,
//     required this.employeeId,
//   });
//
//   @override
//   _SignatureFormScreenState createState() => _SignatureFormScreenState();
// }
//
// class _SignatureFormScreenState extends State<SignatureFormScreen> {
//   String? pdfBase64Url;
//   bool isLoading = false;
//   String? pdfFile;
//   late PDFViewController pdfViewController;
//
//   int currentPage = 0;
//   int totalPages = 0;
//   bool isReady = false;
//   String errorMessage = '';
//
//   static const String viewType = 'html-viewer';
//   String _uniqueKey = UniqueKey().toString(); // Unique key for re-rendering
//
//   @override
//   void didUpdateWidget(SignatureFormScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (widget.htmlFormData != oldWidget.htmlFormData) {
//       setState(() {
//         _uniqueKey = UniqueKey().toString(); // Force re-render on HTML change
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _registerHtmlViewFactory(); // Register the HTML view factory
//   }
//
//   void _registerHtmlViewFactory() {
//     // Register the view factory to create an iframe with the HTML content
//     ui.platformViewRegistry.registerViewFactory(
//       'html-viewer-$_uniqueKey',
//           (int viewId) {
//         final element = html.IFrameElement()
//           ..srcdoc = widget.htmlFormData
//           ..style.border = 'none'
//           ..style.width = '100%'
//           ..style.height = '600px';
//         return element;
//       },
//     );
//   }
//
//   void toggleBack() {
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const PreferredSize(
//         preferredSize: Size.fromHeight(kToolbarHeight),
//         child: TopRowConstant(),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     splashColor: Colors.transparent,
//                     hoverColor: Colors.transparent,
//                     highlightColor: Colors.transparent,
//                     onPressed: () => Navigator.pop(context),
//                     icon: Icon(Icons.arrow_back),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 150),
//                     child: Text(
//                       widget.documentName,
//                       style: FormHeading.customTextStyle(context),
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       _buildCancelButton(),
//                       SizedBox(width: 10),
//                       isLoading
//                           ? Center(
//                         child: SizedBox(
//                           height: 25,
//                           width: 25,
//                           child: CircularProgressIndicator(
//                             color: ColorManager.blueprime,
//                           ),
//                         ),
//                       )
//                           : CustomIconButton(
//                         text: 'Confirm',
//                         onPressed: () async {
//                           pdfFile = await PdfGenerator.htmlToBase64Pdf(widget.htmlFormData);
//                           print("PDF byte: $pdfFile");
//
//                           setState(() => isLoading = true);
//
//                           try {
//                             await htmlFormTemplateSignature(context: context,
//                               formHtmlTempId: widget.htmlFormTemplateId,
//                               htmlName: widget.documentName,
//                               documentFile: pdfFile!,
//                               employeeId: widget.employeeId,
//                               signed: true,);
//                           } finally {
//                             setState(() {
//                               isLoading = false;
//                               Navigator.pop(context);
//                             });
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 50),
//             Container(
//               color: Colors.white,
//               height: MediaQuery.of(context).size.height,
//               child: HtmlElementView(viewType: 'html-viewer-$_uniqueKey'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCancelButton() {
//     return Container(
//       height: 30,
//       width: 140,
//       child: CustomButtonTransparent(
//         text: 'Cancel',
//         onPressed: () => Navigator.pop(context),
//       ),
//     );
//   }
// }
//
// class PdfGenerator {
//   // Convert HTML string to a Base64-encoded PDF
//   // You can now use the Base64 string however you want (e.g., send it via API)  }
//
//   static Future<String> htmlToBase64Pdf(String htmlContent) async {
//     try {
//       final completer = Completer<String>();
//
//       // Wrap HTML content with A4-specific styles
//       final modifiedHtml = '''
//       <html>
//       <head>
//         <style>
//           @page {
//             size: A4;
//             margin: 0;
//           }
//           html, body {
//             margin: 0;
//             padding: 0;
//             width: 100%;
//             height: 100%;
//             box-sizing: border-box;
//             overflow: hidden;
//           }
//         </style>
//       </head>
//       <body>
//         $htmlContent
//       </body>
//       </html>
//       ''';
//
//       // JavaScript call to convert HTML to Base64 PDF
//       html.window.callMethod('htmlToPdf', [
//         modifiedHtml,
//         html.allowInterop((String base64Pdf) {
//           completer.complete(base64Pdf);
//         }),
//       ]);
//
//       return await completer.future;
//     } catch (e) {
//       print('Error: $e');
//       return "";
//     }
//   }
// }
