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
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/form_screen/widgetConst/candidate_release_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/form_screen/widgetConst/const_form_list.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/form_screen/widgetConst/form_screen_const.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/form_screen/widgetConst/company_property_popup_const.dart';

import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/onboarding_manager/form_status_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/legal_document_data/legal_oncall_doc_data.dart';
import '../../../../../../../data/api_data/hr_module_data/onboarding_data/form_status_data.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';
import '../form_nine_screen.dart';

class LegalDocumentsScreen extends StatefulWidget {
  final int employeeID;
  const LegalDocumentsScreen({
    super.key,
    required this.context,
    required this.employeeID,
  });

  final BuildContext context;

  @override
  State<LegalDocumentsScreen> createState() => _LegalDocumentsScreenState();
}

class _LegalDocumentsScreenState extends State<LegalDocumentsScreen> {
  final StreamController<List<FormModel>> formController =
      StreamController<List<FormModel>>();
  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }

  @override
  void initState() {
    super.initState();

  }

  bool isSelected = false;
  List<String> _fileNames = [];
  bool _loading = false;

  bool isLoading = false;

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
    final file = html.File([blob], fileName);
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

  Future<void> callHtmlData(String htmlName, int id) async{
    setState(() {

    });
    if(htmlName == AppStringLegalDocument.onCall){
      OnCallDocument oncallDoc = await getLegalOnCallDocument(context: context, callHtmlId: id, employeeId: widget.employeeID);

      Navigator.push(context, MaterialPageRoute(builder: (context)=>
          SignatureFormScreen(
        documentName: oncallDoc.name,
        onPressed: () {  },
        htmlFormData: oncallDoc.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: oncallDoc.onCallId,)
      ));
    }
    else if(htmlName == AppStringLegalDocument.confidentialityAgreement){
      ConfidentialStatementDocument confidentialStatementDocument = await getLegalConfidentialStatementDocument(context: context, employeeId: widget.employeeID, ConfidentialStatementId: id);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignatureFormScreen(
        documentName: confidentialStatementDocument.name,
        onPressed: () {  },
        htmlFormData: confidentialStatementDocument.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: confidentialStatementDocument.confidentialStatementId,)));
    }
    else if(htmlName == AppStringLegalDocument.covidTestingPolicy){
      CovidTestPolicyDocument covidTestPolicyDocument = await getLegalCovidTestPolicyDocument(context: context, employeeId: widget.employeeID, covidTestId: id);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignatureFormScreen(
        documentName: covidTestPolicyDocument.name,
        onPressed: () {  },
        htmlFormData: covidTestPolicyDocument.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: covidTestPolicyDocument.covidTestPolicyId,)));
    }
    else if(htmlName == AppStringLegalDocument.reportOfAbuse){
      ReportingAbuseDocument reportingAbuseDocument = await getLegalReportingAbuseDocumentDocument(context: context, employeeId: widget.employeeID, reportingAbuseId: id);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignatureFormScreen(
        documentName: reportingAbuseDocument.name,
        onPressed: () {  },
        htmlFormData: reportingAbuseDocument.html,
        employeeId: widget.employeeID,
        htmlFormTemplateId: reportingAbuseDocument.reportingAbuseId,)));
    }
    else if(htmlName == AppStringLegalDocument.policyConcerning){
      PolicyConcerningDocument policyConcerningDocument = await getLegalpolicyConcerningDocument(context: context, employeeId: widget.employeeID, policyConcerningId: id);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignatureFormScreen(
        documentName: policyConcerningDocument.name,
        onPressed: () {  },
        htmlFormData: policyConcerningDocument.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: policyConcerningDocument.policyConcerningId,)));
    }
    else if(htmlName == AppStringLegalDocument.standardOfCodeOfConduct){
      StandardConductDocument standardConductDocument = await getStandardConductDocument(context: context, employeeId: widget.employeeID, standardConductId: id);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
        documentName: standardConductDocument.name,
        onPressed: () {  },
        htmlFormData: standardConductDocument.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: standardConductDocument.standardConductId,)));
    }
    else if(htmlName == AppStringLegalDocument.sexualHarassmentPolicy){
      SexualHaressmentDocument sexualHaressmentDocument = await getSexualHaressmentDocument(context: context, employeeId: widget.employeeID,templateId: id);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
        documentName: sexualHaressmentDocument.name,
        onPressed: () {  },
        htmlFormData: sexualHaressmentDocument.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: sexualHaressmentDocument.sexualHaressmentId,)));
    }
    else if(htmlName == AppStringLegalDocument.sexualHarassmentPolicyACK){
      SexualAndUnlawfulDocument sexualAndUnlawfulDocument = await getSexualAndUnlawfulDocument(context: context, employeeId: widget.employeeID,templateId: id);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
        documentName: sexualAndUnlawfulDocument.name,
        onPressed: () {  },
        htmlFormData: sexualAndUnlawfulDocument.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: sexualAndUnlawfulDocument.sexualUnlawfulId,)));
    }
    else if(htmlName == AppStringLegalDocument.preAuthorization){
      PreAuthPatientVisitsDocument preAuthPatientVisitsDocument = await getPreAuthPatientVisitsDocument(context: context, employeeId: widget.employeeID,templateId: id);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
        documentName: preAuthPatientVisitsDocument.name,
        onPressed: () {  },
        htmlFormData: preAuthPatientVisitsDocument.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: preAuthPatientVisitsDocument.preAuthPatientId,)));
    }
    else if(htmlName == AppStringLegalDocument.prop65){
      ProDocument proDocument = await getPro65Document(context: context, employeeId: widget.employeeID,templateId: id);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
        documentName: proDocument.name,
        onPressed: () {  },
        htmlFormData: proDocument.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: proDocument.proDocumentId,)));
    }
    else if(htmlName == AppStringLegalDocument.returnOfcompanyProperty){
      showDialog(context: context, builder: (BuildContext context){
        return CompanyPropertySignPopup(
          employeeId: widget.employeeID,
          htmlFormTemplateId: id,
          );
      });
      // Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
      //   documentName: returnOfCompanyProperty.name,
      //   onPressed: () {  },
      //   htmlFormData: returnOfCompanyProperty.html,
      //   employeeId: widget.employeeID,//widget.employeeID,
      //   htmlFormTemplateId: returnOfCompanyProperty.returnOfCompanyPropertyId,)
      // ));
    }
    else if(htmlName == AppStringLegalDocument.hepB){
      HepBDocuemnt hepBDocuemnt = await getHepBDocument(context: context, employeeId: widget.employeeID,templateId: id);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
        documentName: hepBDocuemnt.name,
        onPressed: () {  },
        htmlFormData: hepBDocuemnt.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: hepBDocuemnt.hepBDocuemntId,)));
    }
    else if(htmlName == AppStringLegalDocument.tDap){
      TDapDocuemnt tDapDocuemnt = await getTDapDocument(context: context, employeeId: widget.employeeID,templateId: id);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
        documentName: tDapDocuemnt.name,
        onPressed: () {  },
        htmlFormData: tDapDocuemnt.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: tDapDocuemnt.tDapDocuemnttId,)));
    }
    else if(htmlName == AppStringLegalDocument.covidVaccine){
      CovidVaccineDocuemnt covidVaccineDocuemnt = await getCovidVaccineDocument(context: context, employeeId: widget.employeeID, templateId: id);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
        documentName: covidVaccineDocuemnt.name,
        onPressed: () {  },
        htmlFormData: covidVaccineDocuemnt.html,
        employeeId: widget.employeeID,//widget.employeeID,
        htmlFormTemplateId: covidVaccineDocuemnt.covidVaccineDocuemntId,)));
    }
    else if(htmlName == AppStringLegalDocument.candidatereLeaseForm){
      showDialog(context: context, builder: (BuildContext context){
        return CandidateReleaseSignPopup(
          employeeId: widget.employeeID,
          htmlFormTemplateId:id,
          );
      });
      // Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
      //   documentName: covidVaccineDocuemnt.name,
      //   onPressed: () {  },
      //   htmlFormData: covidVaccineDocuemnt.html,
      //   employeeId: widget.employeeID,//widget.employeeID,
      //   htmlFormTemplateId: covidVaccineDocuemnt.covidVaccineDocuemntId,)));
    }
    else{

    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Container(
          child: Padding(
        padding: const EdgeInsets.only(left: 166, right: 166),
        child: Column(
          children: [
            Center(
              child: Text('Legal Documents',
                  style: FormHeading.customTextStyle(context)),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 60),
            Container(
              //color: Colors.redAccent,
              height: 50,
              width: 940,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                    style: FileuploadString.customTextStyle(context),
                  ),
                ),
                const SizedBox(width: 40),
                ElevatedButton.icon(
                  onPressed: () async {
                    // FilePickerResult? result = await FilePicker.platform.pickFiles(
                    //   allowMultiple: false,
                    // );
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(
                            type: FileType.custom, allowedExtensions: ['pdf']);
                    if (result != null) {
                      print("Result::: ${result}");

                      try {
                        Uint8List? bytes = result.files.first.bytes;
                        XFile xlfile = XFile(result.xFiles.first.path);
                        xfileToFile = File(xlfile.path);

                        print("::::XFile To File ${xfileToFile.toString()}");
                        XFile xFile = await convertBytesToXFile(
                            bytes!, result.xFiles.first.name);
                        _fileNames
                            .addAll(result.files.map((file) => file.name!));
                        print('File picked: ${_fileNames}');
                        //print(String.fromCharCodes(file));
                        finalPath = result.files.first.bytes;
                        fileName = result.files.first.name;
                        setState(() {
                          _fileNames;
                          _documentUploaded = true;
                        });
                      } catch (e) {
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
                    style: BlueButtonTextConst.customTextStyle(context),
                  ),
                ),
                _loading
                    ? SizedBox(
                        width: 25,
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
                                        style: onlyFormDataStyle
                                            .customTextStyle(context),
                                      ),
                                    ))
                                .toList(),
                          )
                        : const SizedBox(), // Display file names if picked
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'List Of Documents',
                  style: HeadingFormStyle.customTextStyle(context),
                ),
                CustomButton(
                  width: 117,
                  height: 30,
                  text: isLoading ? 'Wait..' : 'Save',
                  style: BlueButtonTextConst.customTextStyle(context),
                  borderRadius: 12,
                  onPressed: () {},
                  child: isLoading
                      ? SizedBox(
                          height: AppSize.s25,
                          width: AppSize.s25,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Text(
                          'Save',
                          style: BlueButtonTextConst.customTextStyle(context),
                        ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            StreamBuilder<List<FormModel>>(
                stream: formController.stream,
                builder: (context, snapshot) {
                  getFormStatus(
                    context,
                    widget.employeeID,
                  ).then((data) {
                    formController.add(data);
                  }).catchError((error) {});
                  print('1111111');
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.blueprime,
                      ),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        AppStringHRNoData.noOnboardingData,
                        style: AllNoDataAvailable.customTextStyle(context),
                      ),
                    );
                  }
                  if (snapshot.hasData) {
                    int totalItems = snapshot.data!.length;
                    int totalPages = (totalItems / itemsPerPage).ceil();
                    List<FormModel> paginatedData = snapshot.data!
                        .skip((currentPage - 1) * itemsPerPage)
                        .take(itemsPerPage)
                        .toList();
                    return Container(
                      height: MediaQuery.of(context).size.height / 1,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: paginatedData.length,
                        itemBuilder: (context, index) {
                          FormModel formStatus = paginatedData[index];
                          return Column(
                            children: [
                              // const SizedBox(height: AppSize.s10),
                              // DefineFormList(formName: AppStringLegalDocument.onCall, onSigned: () async{
                              //   OnCallDocument oncallDoc = await getLegalOnCallDocument(context: context, callHtmlId: 1, employeeId: 169);
                              //   Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
                              //     documentName: AppStringLegalDocument.onCall,
                              //     onPressed: () {  },
                              //     htmlFormData: oncallDoc.html,
                              //     employeeId: 169,//widget.employeeID,
                              //     htmlFormTemplateId: 1,)));
                              // }, onView: () {  },),
                              // const SizedBox(height: AppSize.s10),
                              /// dont delete this code
                              DefineFormList(
                                formName: formStatus.htmlname,
                                onSigned: formStatus.signed
                                    ? null
                                    : () async{
                                   await callHtmlData(formStatus.htmlname,formStatus.formHtmlTemplatesId);
                                  print("${formStatus.htmlname} signed.");
                                },
                                onView: formStatus.signed ?  () {
                                  // Logic for viewing the form
                                  downloadFile(formStatus.url);
                                  print("Viewing ${formStatus.htmlname}");
                                } : (){},
                                isSigned: formStatus.signed,
                              ),
                              const SizedBox(height: AppSize.s10),
                              const Divider(
                                height: 1,
                                color: Color(0xFFD1D1D1),
                              ),
                              const SizedBox(height: AppSize.s10),
                            ],
                          );
                        },
                      ),
                    );


                    //   Container(
                    //   height: MediaQuery.of(context).size.height/1,
                    //   child: ListView.builder(
                    //       scrollDirection: Axis.vertical,
                    //       itemCount: paginatedData.length,
                    //       itemBuilder: (context, index) {
                    //         FormModel formStatus = paginatedData[index];
                    //         return Column(
                    //           children: [
                    //             DefineFormList(
                    //                 formName: formStatus.htmlname,
                    //                 onSigned: () {},
                    //                 onView: () {}),
                    //             const SizedBox(height: AppSize.s10),
                    //             const Divider(
                    //               height: 1,
                    //               color: Color(0xFFD1D1D1),
                    //             ),
                    //             const SizedBox(height: AppSize.s10),
                    //           ],
                    //         );
                    //       }),
                    // );
                  }
                  return Offstage();
                }),
            const SizedBox(height: AppSize.s10),
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
      ))
    ]));
  }
}


//
// DefineFormList(formName: AppStringLegalDocument.candidatereLeaseForm, onPressed: () {
//
// }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.onCall, onPressed: () async{
//   OnCallDocument onCallDocument = await getLegalOnCallDocument(
//     context: context,callHtmlId:1,
//     employeeId: widget.employeeID,);
//       Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
//   documentName: AppStringLegalDocument.onCall,
//   onPressed: () {  },
//   htmlFormData: onCallDocument.onCallData.toString(),
//         employeeId: widget.employeeID,
//         htmlFormTemplateId: 0,)));
//   // FutureBuilder<OnCallDocument>(
//   //   future: getLegalOnCallDocument(context: context,callHtmlId:1, employeeId: widget.employeeID,),
//   //   builder: (BuildContext context, snapshot) {
//   //   if(snapshot.connectionState == ConnectionState.waiting){
//   //     return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),);
//   //   }
//   //   if(snapshot.hasData){
//   //     Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
//   //        documentName: AppStringLegalDocument.onCall,
//   //        onPressed: () {  },
//   //        htmlFormData: snapshot.data!.onCallData.toString(),)));
//   //   }else{
//   //     return SizedBox();
//   //   }
//   //   return SizedBox();
//   //   },
//   // );
// }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.confidentialityAgreement, onPressed: () async{
//   ConfidentialStatementDocument confidentialStatementDocument =
//   await getLegalConfidentialStatementDocument(context: context, ConfidentialStatementId: 1, employeeId: widget.employeeID);
//   Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
//     documentName: AppStringLegalDocument.confidentialityAgreement,
//     onPressed: () {  },
//     htmlFormData: confidentialStatementDocument.confidentialDocument.toString(),
//     employeeId: widget.employeeID,
//     htmlFormTemplateId: 0,)));
// }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.covidTestingPolicy, onPressed: () async{
//   CovidTestPolicyDocument covidTestPolicyDocument = await getLegalCovidTestPolicyDocument(context: context, covidTestId: 1, employeeId: widget.employeeID);
//   Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
//     documentName: AppStringLegalDocument.covidTestingPolicy,
//     onPressed: () {  },
//     htmlFormData: covidTestPolicyDocument.covidTestData.toString(),
//     employeeId: widget.employeeID,
//     htmlFormTemplateId: 0,)));
// }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.policyConcerning, onPressed: () async{
//   PolicyConcerningDocument policyConcerningDocument = await getLegalpolicyConcerningDocument(context: context, policyConcerningId: 1, employeeId: widget.employeeID);
//   Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
//     documentName: AppStringLegalDocument.policyConcerning,
//     onPressed: () {  },
//     htmlFormData: policyConcerningDocument.policyConcerningDocument.toString(),
//     employeeId: widget.employeeID,
//     htmlFormTemplateId: 0,)));
// }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.reportOfAbuse, onPressed: () async{
//   ReportingAbuseDocument reportingAbuseDocument = await getLegalReportingAbuseDocumentDocument(context: context, reportingAbuseId: 1, employeeId: widget.employeeID);
//   Navigator.push(context, MaterialPageRoute(builder: (_)=>SignatureFormScreen(
//     documentName: AppStringLegalDocument.reportOfAbuse,
//     onPressed: () {  },
//     htmlFormData: reportingAbuseDocument.reportingAbuseDocument.toString(),
//     employeeId: widget.employeeID,
//     htmlFormTemplateId: 0,)));
// }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.personalOrientation, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.directDeposit, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.standardOfCodeOfConduct, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.sexualHarassmentPolicy, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.sexualHarassmentPolicyACK, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.preAuthorization, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.prop65, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.returnOfcompanyProperty, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.hepB, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.tDap, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.flu, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.covidVaccine, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.i9, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.w4, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
//
// const SizedBox(height: AppSize.s10),
// DefineFormList(formName: AppStringLegalDocument.employeeHandbook, onPressed: () {  }, onPressedView: () {  },),
// const SizedBox(height: AppSize.s10),
//
// const Divider(
//   height: 1,
//   color: Color(0xFFD1D1D1),
// ),
// const SizedBox(height: AppSize.s10),