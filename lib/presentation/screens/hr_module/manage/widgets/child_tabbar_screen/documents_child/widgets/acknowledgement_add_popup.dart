// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';
//
// class AcknowledgementAddPopup extends StatefulWidget {
//   final String labelName;
//   final TextEditingController AcknowledgementnameController;
//   final VoidCallback onSavePressed;
//
//   const AcknowledgementAddPopup({
//     Key? key,
//     required this.labelName,
//     required this.AcknowledgementnameController,
//     required this.onSavePressed,
//   }) : super(key: key);
//
//   @override
//   _AcknowledgementAddPopupState createState() => _AcknowledgementAddPopupState();
// }
//
// class _AcknowledgementAddPopupState extends State<AcknowledgementAddPopup> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         width: AppSize.s400,
//         height: AppSize.s300,
//         decoration: BoxDecoration(
//           color: ColorManager.white,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           children: [
//             Container(
//               height: 34,
//               decoration: BoxDecoration(
//                 color: Color(0xff50B5E5),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(12),
//                   topRight: Radius.circular(12),
//                 ),
//               ),
//               child: Padding(
//                 padding: EdgeInsets.only(left: 10.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       widget.labelName,
//                       style: GoogleFonts.firaSans(
//                         fontSize: FontSize.s14,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(Icons.close,color: Colors.white,),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: MediaQuery.of(context).size.height/40,),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: AppPadding.p3,
//                 horizontal: AppPadding.p20,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Type of the Document',
//                     style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s12,
//                       fontWeight: FontWeight.w700,
//                       color: ColorManager.mediumgrey,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   CICCDropdown(
//                     items: [
//                       DropdownMenuItem(value: 'Type 1', child: Text('Type 1')),
//                       DropdownMenuItem(value: 'Type 2', child: Text('Type 2')),
//                       DropdownMenuItem(value: 'Type 3', child: Text('Type 3')),
//                       DropdownMenuItem(value: 'Type 4', child: Text('Type 4')),
//                     ],
//                   ),
//                   SizedBox(height: AppSize.s20),
//                   GestureDetector(
//                     onTap: () async {
//                       FilePickerResult? result = await FilePicker.platform.pickFiles(
//                         allowMultiple: false,
//                       );
//                       if (result != null) {
//                         PlatformFile file = result.files.first;
//                         print('File picked: ${file.name}');
//                         widget.AcknowledgementnameController.text = file.name;
//                       } else {
//                       }
//                     },
//                     child: AbsorbPointer(
//                       child: SMTextFConst(
//                         controller: widget.AcknowledgementnameController,
//                         keyboardType: TextInputType.text,
//                         text: 'Upload Document',
//                         icon: Icon(Icons.file_upload_outlined,color: Colors.black,),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(bottom: AppPadding.p24),
//               child: Center(
//                 child: CustomElevatedButton(
//                   width: AppSize.s105,
//                   height: AppSize.s30,
//                   text: AppStringEM.submit,
//                   onPressed: () {
//                     widget.onSavePressed();
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

///////////////////////////////////after validation/////////////////////////////////
import 'dart:io';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/text_form_field_const.dart';

class AcknowledgementAddPopup extends StatefulWidget {
  final String labelName;
  final TextEditingController AcknowledgementnameController;
  final VoidCallback onSavePressed;
  final Widget child;

  const AcknowledgementAddPopup({
    Key? key,
    required this.labelName,
    required this.AcknowledgementnameController,
    required this.onSavePressed, required this.child,
  }) : super(key: key);

  @override
  _AcknowledgementAddPopupState createState() => _AcknowledgementAddPopupState();
}

class _AcknowledgementAddPopupState extends State<AcknowledgementAddPopup> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDocumentType;
  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  XFile? filePath;
  var finalPath;
  // PlatformFile? fileName;

  Future<WebFile> saveFileFromBytes(dynamic bytes, String fileName) async {
    // Get the directory to save the file.
    final blob = html.Blob(bytes);
    final url = html.Url.createObjectUrlFromBlob(blob);
    

    // Create the file.
    //final anchor = html.AnchorElement(href: url)..setAttribute("download", fileName)..click();
    final file = html.File([blob],fileName);
    // Write the bytes to the file.
    print(file.toString());
    return WebFile(file, url);
  }

  Future<XFile> convertBytesToXFile(Uint8List bytes, String fileName) async {
    // Create a Blob from the bytes
    final blob = html.Blob([bytes]);

    // Create an object URL from the Blob
    final url = html.Url.createObjectUrlFromBlob(blob);

    // Create a File from the Blob
    final file = html.File([blob], fileName);

    print("XFILE ${url}");

    // Return the XFile created from the object URL
    return XFile(url);
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s300,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Container(
              height: 34,
              decoration: BoxDecoration(
                color: Color(0xff50B5E5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.labelName,
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, color: Colors.white,),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 40,),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppPadding.p3,
                horizontal: AppPadding.p20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Type of the Document',
                      style: GoogleFonts.firaSans(
                        fontSize: FontSize.s12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                    SizedBox(height: 3),
                    widget.child,
                    // DropdownButtonFormField<String>(
                    //   value: _selectedDocumentType,
                    //   items: [
                    //
                    //   ],
                    //   onChanged: (value) {
                    //     setState(() {
                    //       _selectedDocumentType = value;
                    //     });
                    //   },
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please select the document type';
                    //     }
                    //     return null;
                    //   },
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(8),
                    //       borderSide: BorderSide(color: Color(0xffB1B1B1)),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: AppSize.s20),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          allowMultiple: false,
                        );
                        if (result != null) {
                          try{
                            Uint8List? bytes = result.files.first.bytes;
                            XFile xlfile = XFile(result.xFiles.first.path);
                            print("::::XFile ${xlfile.toString()}");
                            XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                             WebFile webFile = await saveFileFromBytes(result.files.first.bytes, result.files.first.name);
                             html.File file = webFile.file;
                             print("XFILE ${xFile}");
                             filePath = xlfile;
                             print("L::::::${filePath}");
                              fileName = result.files.first.name;

                            print('File picked: ${fileName}');
                            //print(String.fromCharCodes(file));
                            finalPath;
                            setState(() {
                              widget.AcknowledgementnameController.text = fileName;
                              _documentUploaded = true;
                            });
                          }catch(e){
                            print(e);
                          }
                        }
                        // if(file != null ){
                        //
                        // }
                      },
                      child: AbsorbPointer(
                        child: SMTextFConst(
                          controller: widget.AcknowledgementnameController,
                          keyboardType: TextInputType.text,
                          text: 'Upload Document',
                          icon: Icon(Icons.file_upload_outlined, color: Colors.black,),
                        ),
                      ),
                    ),
                    if (!_documentUploaded)
                      Text(
                        'Please upload a document',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: AppPadding.p24),
              child: Center(
                child: CustomElevatedButton(
                  width: AppSize.s105,
                  height: AppSize.s30,
                  text: AppStringEM.submit,
                  onPressed: () async{
                    if (_formKey.currentState!.validate() && widget.AcknowledgementnameController.text.isNotEmpty) {
                      try{
                        //File filePath = File(finalPath!);
                        await uploadHttpDocuments(context: context, employeeDocumentMetaId: 2, employeeDocumentTypeSetupId: 6,
                            employeeId: 8, documentName: widget.AcknowledgementnameController.text,
                            documentFile: filePath!);
                      }catch(e){
                        print(e);
                      }
                      print("Code ${widget.AcknowledgementnameController.text}");
                      // widget.onSavePressed();
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _documentUploaded = widget.AcknowledgementnameController.text.isNotEmpty;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WebFile{
final html.File file;
final String url;
WebFile(this.file,this.url);

void dispose()
{
  print("File $file");
  html.Url.revokeObjectUrl(url);
}}