import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prohealth/app/constants/app_config.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import '../../../../../../../app/resources/color.dart';
import '../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../app/resources/hr_resources/hr_theme_manager.dart';
import '../../../../../../../app/resources/value_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/manage_emp/uploadData_manager.dart';
import '../../../../../../../app/services/api/managers/hr_module_manager/progress_form_manager/form_health_record_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/progress_form_data/form_health_record_data.dart';
import '../../../../../../widgets/error_popups/failed_popup.dart';
import '../../../../../../widgets/error_popups/four_not_four_popup.dart';
import '../../../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../../../manage/widgets/child_tabbar_screen/documents_child/widgets/acknowledgement_add_popup.dart';
import '../../../../manage/widgets/custom_icon_button_constant.dart';

class HealthRecordsScreen extends StatefulWidget {
  final int employeeID;
  final Function onSave;
  final Function onBack;
  final Function onNext;

  const HealthRecordsScreen({
    super.key,
    required this.context,
    required this.employeeID, required this.onSave, required this.onBack, required this.onNext,
  });

  final BuildContext context;

  @override
  State<HealthRecordsScreen> createState() => _HealthRecordsScreenState();
}

class _HealthRecordsScreenState extends State<HealthRecordsScreen> {

  final StreamController<List<HREmployeeDocumentModal>> healthrecord = StreamController<List<HREmployeeDocumentModal>>();

  bool isLoading =false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHREmployeeDoc(
      context,
      AppConfig.empdocumentTypeMetaDataId,
      1,
      20,
    ).then((data){healthrecord.add(data);}).catchError((error){});
  }




  List<String> _fileNames = [];
  List<int> docSetupId = [];
  bool _loading = false;
  ////////////////////////////////////

  bool _documentUploaded = true;
  var fileName;
  var fileName1;
  dynamic? filePath;
  File? xfileToFile;
  var finalPath;
  // PlatformFile? fileName;

  bool fileAbove20Mb = false;
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
  List<Uint8List?> finalPaths = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Center(
            child: Text(
              'Health Records',
              style:FormHeading.customTextStyle(context)
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 60),
          Container(
            width: 952,
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Color(0xFFE6F7FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style:  DefineWorkWeekStyle.customTextStyle(context),
                    ),
                    Expanded(
                      child: Text(
                        'Instructions: This section is designed to capture and document your health and immunization records as part of your onboarding process. Please enter the required information accurately.',
                        textAlign: TextAlign.center,
                        style:ZoneDataStyle.customTextStyle(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height / 100),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style:  DefineWorkWeekStyle.customTextStyle(context),
                    ),
                    Expanded(
                      child: Text(
                        'Please ensure that all uploaded immunization records are clear and legible. Accepted file formats for iuploads include PDF, JPG or PNG. In case of declination, please upload a signed copy of the declination form.',
                        textAlign: TextAlign.center,
                        style:ZoneDataStyle.customTextStyle(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 20),



          SingleChildScrollView(
            child: Container(
              height: 500,
              child:
              StreamBuilder<List<HREmployeeDocumentModal>>(
                stream: healthrecord.stream,
                // builder: getHREmployeeDoc(
                //     context, AppConfig.empdocumentTypeMetaDataId, 1, 20),


                builder: (BuildContext context,
                    AsyncSnapshot<List<HREmployeeDocumentModal>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error :${snapshot.error}");
                  } else {
                    List<HREmployeeDocumentModal> documents = snapshot.data!;

                    // Ensure _fileNames is at least as long as documents
                    if (_fileNames.length < documents.length) {
                      _fileNames.addAll(List.generate(
                        documents.length - _fileNames.length,
                        (index) => '', // Or any default value
                      ));
                    }

                    if (finalPaths.length < documents.length) {
                      finalPaths.addAll(
                        List.generate(documents.length - finalPaths.length, (_) => null),
                      );
                    }
                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final fileName =
                            _fileNames.isNotEmpty && index < _fileNames.length
                                ? _fileNames[index]
                                : null;
                         // Assign or retrieve the docSetupId dynamically here
                        int setupId = document.employeeDocTypesetupId; // Assuming 'setupId' is a property of the document
                        print("Document");

                        // If you need to create your own logic, you could do something like:
                        // int setupId = index + 1; // Just an example: setupId starts at 1 for the first item

                        if (docSetupId.length <= index) {
                          docSetupId.add(setupId);
                          print('Document ${docSetupId}');
                        } else {
                          docSetupId[index] = setupId;
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 150, vertical: 10),
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              color: ColorManager.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorManager.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding:  EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          document.docName,
                                          style: AllPopupHeadings.customTextStyle(context),
                                        ),
                                        SizedBox(height: 8),
                                        Flexible(
                                          child: Text(
                                            'Upload Physical Exam records in pdf, jpg or png format',
                                            style:  onlyFormDataStyle.customTextStyle(context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffB1B1B1)),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['pdf']
                                            );
                                            final fileSize = result?.files.first.size; // File size in bytes
                                            final isAbove20MB = fileSize! > (20 * 1024 * 1024);
                                            if (result != null) {
                                              try {
                                                Uint8List? bytes = result.files.first.bytes;
                                                if (bytes != null) {
                                                  setState(() {
                                                    if (_fileNames.length <= index) {
                                                      _fileNames.add(result.files.first.name);
                                                    } else {
                                                      _fileNames[index] = result.files.first.name;
                                                    }

                                                    if (finalPaths.length <= index) {
                                                      finalPaths.add(bytes);
                                                    } else {
                                                      finalPaths[index] = bytes;
                                                    }
                                                    fileAbove20Mb = !isAbove20MB;
                                                  });
                                                }
                                              } catch (e) {
                                                print(e);
                                              }

                                            }

                                          },
                                          child: Text(
                                            "Upload file",
                                            style: BlueButtonTextConst.customTextStyle(context),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff50B5E5),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                      _loading
                                          ? SizedBox(
                                        width: 25,
                                        height: 25,
                                        child: CircularProgressIndicator(
                                          color: ColorManager.blueprime,
                                        ),
                                      )
                                          : fileName != null
                                          ? Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Text(
                                          'File picked: $fileName',
                                          style:onlyFormDataStyle.customTextStyle(context),
                                        ),
                                      )
                                          : SizedBox(),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //color: Colors.white,
                width: 117,
                height: 30,
                child: ElevatedButton(
                  onPressed: (){
                    widget.onBack();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: ColorManager.bluebottom,
                        width: 1,
                      ),
                    ),),
                  child: Text('Previous',
                    style: TransparentButtonTextConst.customTextStyle(context),
                  ),),
              ),
              const SizedBox(
                width: 30,
              ),

              isLoading
                  ? SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: ColorManager.blueprime,
                ),
              )
                  :CustomButton(
                width: 117,
                height: 30,
                text:'Save',
                style:BlueButtonTextConst.customTextStyle(context),
                borderRadius: 12,
                onPressed: () async {
                  try{
                    setState(() {
                      isLoading = true; // Start loading
                    });
                    if (finalPaths == null || finalPaths.isEmpty) {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return VendorSelectNoti(
                            message: 'Please Select File',
                          );
                        },
                      );
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(
                      //     content: Text(
                      //         'No file selected. Please select a file to upload.'),
                      //     backgroundColor: Colors.red,
                      //   ),
                      // );
                    } else {
                      if (fileAbove20Mb) {
                        try {
                          // Loop through each form and extract data to post
                          for (int i = 0; i < finalPaths.length; i++) {
                            if (finalPaths[i] != null) {
                              var response = await uploadDocuments(
                                context: context,
                                employeeDocumentMetaId: AppConfig
                                    .empdocumentTypeMetaDataId,
                                employeeDocumentTypeSetupId: docSetupId[i],
                                employeeId: widget.employeeID,
                                documentFile: finalPaths[i]!,
                                documentName: _fileNames[i],
                              );
                              print("Document Uploaded response ${response}");

                              if (response.statusCode == 200 || response
                                  .statusCode == 201) {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AddSuccessPopup(
                                      message: 'Document Uploaded Successfully',
                                    );
                                  },
                                );

                                // _loadLicensesData();
                              }
                              else {
                                // Navigator.pop(context);
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      FailedPopup(
                                          text: "Failed To Upload Document"),
                                );
                              }
                            }
                          }


                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text('Document uploaded successfully!'),
                          //     backgroundColor: Colors.green,
                          //   ),
                          // );

                        } catch (e) {
                          await showDialog(
                            context: context,
                            builder: (
                                BuildContext context) => const FourNotFourPopup(),
                          );
                          // await showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return AddFailePopup(
                          //       message: 'Failed To Upload Document',
                          //     );
                          //   },
                          // );
                        }
                      }
                      else{
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddErrorPopup(
                              message: 'File is too large!',
                            );
                          },
                        );
                      }
                    }
                  }finally{
                    setState(() {
                      isLoading = false; // End loading
                    });
                    widget.onSave();
                  }
                },
                child: Text(
                  'Save',
                  style: BlueButtonTextConst.customTextStyle(context),
                ),
              ),
              const SizedBox(
                width: AppSize.s30,
              ),
              Container(
                //color: Colors.white,
                width: 117,
                height: 30,
                child: ElevatedButton(
                  onPressed: (){
                    widget.onNext();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: ColorManager.bluebottom,
                        width: 1,
                      ),
                    ),),
                  child: Text('Next',
                    style: TransparentButtonTextConst.customTextStyle(context),
                  ),),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

