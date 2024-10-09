import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/legal_documents/legal_document_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/progress_form_manager/i9_form_manager.dart';
import 'package:prohealth/data/api_data/api_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/form_screen/widgetConst/const_form_list.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/form_screen/widgetConst/form_screen_const.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../form_nine_screen.dart';

class LegalDocumentsScreen extends StatefulWidget {
  final int employeeID;
  const LegalDocumentsScreen({
    super.key,
    required this.context, required this.employeeID,
  });

  final BuildContext context;

  @override
  State<LegalDocumentsScreen> createState() => _LegalDocumentsScreenState();
}

class _LegalDocumentsScreenState extends State<LegalDocumentsScreen> {

 bool isSelected = false;
  List<String> _fileNames = [];
  bool _loading = false;

  void _pickFiles() async {
    setState(() {
      _loading = true; // Show loader
      _fileNames.clear(); // Clear previous file names if any
    });

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      setState(() {
        _fileNames.addAll(result.files.map((file) => file.name!));
        _loading = false; // Hide loader
      });
      print('Files picked: $_fileNames');
    } else {
      setState(() {
        _loading = false; // Hide loader on cancel
      });
      print('User canceled the picker');
    }
  }


  ////////////////////////////////////

  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic? filePath;
  File? xfileToFile;
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

  Future<Uint8List> loadFileBytes() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/somefile.txt');
    if (await file.exists()) {
      return await file.readAsBytes();
    } else {
      throw Exception('File not found');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 166, right: 166),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Legal Documents',
                      style:FormHeading.customTextStyle(context)
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  Container(
                    //color: Colors.redAccent,
                    height: 50,
                    width: 940,
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE6F7FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Please add information about your legal documents',
                        style: DefineWorkWeekStyle.customTextStyle(context),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Upload one of your government ids ( e.g. drivers license )',
                          style: DefineWorkWeekStyle.customTextStyle(context),
                        ),
                      ),
                      const SizedBox(width: 40),
                      ElevatedButton.icon(
                        onPressed:
                         ()async {
                        // FilePickerResult? result = await FilePicker.platform.pickFiles(
                        //   allowMultiple: false,
                        // );
                        FilePickerResult? result = await FilePicker.platform.pickFiles();
                        if (result != null) {
                          print("Result::: ${result}");

                          try{
                            Uint8List? bytes = result.files.first.bytes;
                            XFile xlfile = XFile(result.xFiles.first.path);
                            xfileToFile = File(xlfile.path);

                            print("::::XFile To File ${xfileToFile.toString()}");
                            XFile xFile = await convertBytesToXFile(bytes!, result.xFiles.first.name);
                            _fileNames.addAll(result.files.map((file) => file.name!));
                            print('File picked: ${_fileNames}');
                            //print(String.fromCharCodes(file));
                            finalPath = result.files.first.bytes;
                            fileName = result.files.first.name;
                            setState(() {
                              _fileNames;
                              _documentUploaded = true;
                            });
                          }catch(e){
                            print(e);
                          }
                        }
                      },
                        // onPressed: () async {
                        //   FilePickerResult? result =
                        //   await FilePicker.platform.pickFiles(
                        //     allowMultiple: false,
                        //   );
                        //   if (result != null) {
                        //     PlatformFile file = result.files.first;
                        //     print('File picked: ${file.name}');
                        //   } else {
                        //     // User canceled the picker
                        //   }
                        // },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff50B5E5),
                          // padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        icon: const Icon(Icons.file_upload_outlined,
                            color: Colors.white),
                        label: Text(
                          'Upload Document',
                          style:BlueButtonTextConst.customTextStyle(context),
                        ),
                      ),
                      _loading
                          ? SizedBox(width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          color: ColorManager.blueprime, // Loader color
                          // Loader size
                        ),
                      )
                          : _fileNames.isNotEmpty
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _fileNames
                            .map((fileName) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'File picked: $fileName',
                            style:onlyFormDataStyle.customTextStyle(context),
                          ),
                        ))
                            .toList(),
                      )
                          : const SizedBox(), // Display file names if picked

                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 30),
                  Row(
                    children: [
                      Text(
                        'List Of Documents',
                        style: DefineWorkWeekStyle.customTextStyle(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  DefineFormList(formName: AppStringLegalDocument.candidatereLeaseForm, onPressed: () {

                  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.onCall,
                    onPressed: () async{
                    OnCallDocument onCallDoc = await getLegalOnCallDocument(context: context,callHtmlId:1, employeeId: widget.employeeID,);
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                      documentName: AppStringLegalDocument.onCall,
                      onPressed: () {  },
                      htmlFormData: onCallDoc.onCallData.toString(),)));
                    // FutureBuilder<OnCallDocument>(
                    //   future: onCallDoc,
                    //   builder: (BuildContext context, snapshot) {
                    //   if(snapshot.connectionState == ConnectionState.waiting){
                    //     return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
                    //   }
                    //   if(snapshot.hasData){
                    //    // return SignatureFormScreen(documentName: documentName, onPressed: onPressed, htmlFormData: htmlFormData)
                    //     Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                    //        documentName: AppStringLegalDocument.onCall,
                    //        onPressed: () {  },
                    //        htmlFormData: snapshot.data!.onCallData.toString(),)));
                    //   }else{
                    //     return SizedBox();
                    //   }
                    //   return SizedBox();
                    //   },
                    // );
                  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.confidentialityAgreement, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.covidTestingPolicy, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.policyConcerning, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.reportOfAbuse, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.personalOrientation, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.directDeposit, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.standardOfCodeOfConduct, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.sexualHarassmentPolicy, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.sexualHarassmentPolicyACK, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.preAuthorization, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.prop65, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.returnOfcompanyProperty, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.hepB, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.tDap, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.flu, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.covidVaccine, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.i9, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.w4, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),
                  DefineFormList(formName: AppStringLegalDocument.employeeHandbook, onPressed: () {  }, onPressedView: () {  },),
                  const SizedBox(height: AppSize.s10),
                  const Divider(
                    height: 1,
                    color: Color(0xFFD1D1D1),
                  ),
                  const SizedBox(height: AppSize.s10),

                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            isSelected == false ?const Text(''): CustomButton(
                  width: 117,
                  height: 30,
                  text: 'Save',
                  style: BlueButtonTextConst.customTextStyle(context),
                  borderRadius: 12,
                onPressed: () async {
                  if (finalPath == null || finalPath.isEmpty) {
                    print('Loading');
                  } else {
                    try {
                      ApiDataRegister result = await legalDocumentAdd(context: context,
                          employeeId: widget.employeeID,
                          documentName: fileName,
                          docUrl: '',
                          officeId: '');
                      var response = await uploadLegalDocumentBase64(context: context,
                          employeeLegalDocumentId: result.legalDocumentId!,
                          documentFile: finalPath
                      );

                      if(response.statusCode == 201 || response.statusCode == 200){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddSuccessPopup(
                              message: 'Document Uploaded Successfully',
                            );
                          },
                        );
                      }else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const AddSuccessPopup(
                              message: 'Failed To Upload Document',
                            );
                          },
                        );
                        print('Document upload Error');
                      }

                    } catch (e) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AddSuccessPopup(
                            message: 'Failed To Upload Document',
                          );
                        },
                      );
                    }
                  }
                },
                // onPressed: () async {
                //
                //   try {
                //     // File filePath = File(finalPath!);
                //     await uploadDocuments(
                //         context: context,
                //         employeeDocumentMetaId: 10,
                //         employeeDocumentTypeSetupId: 48,
                //         employeeId: 2,
                //         documentFile: finalPath,
                //         documentName: 'Legal Document ID'
                //     );
                //
                //
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content: Text('Document uploaded successfully!'),
                //         backgroundColor: Colors.green,
                //       ),
                //     );
                //   } catch (e) {
                //
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //         content: Text('Failed to upload document: $e'),
                //         backgroundColor: Colors.red,
                //       ),
                //     );
                //   }
                // },

                // onPressed: () async{
                  //   try{
                  //     //File filePath = File(finalPath!);
                  //     await uploadDocuments(context: context, employeeDocumentMetaId: 10, employeeDocumentTypeSetupId: 48,
                  //     employeeId: 2, //documentName: widget.AcknowledgementnameController.text,
                  //     documentFile: finalPath, documentName: 'Legal Document ID');
                  //   }catch(e){
                  //     print(e);
                  //   }
                  //
                  // },
              ),
            ],
          )
        ],
      ),

    );
  }
}