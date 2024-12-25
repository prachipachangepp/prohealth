import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/widgets/intake_notes_miscellaneous/widget/miscellaneous_add_pop_up.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/widgets/intake_notes_miscellaneous/widget/miscellaneous_edit_pop_up.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/notes_manager/notes_misc_manager.dart';
import '../../../../../../../../app/services/base64/download_file_base64.dart';
import '../../../../../../../../data/api_data/sm_data/Intake_deta/notes_data/intake_misc_note_data.dart';
import '../../../../../../../../data/api_data/sm_data/patient_data/patient_data_compliance.dart';
import '../../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../../em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';

class IntakeNotesMiscellaneousScreen extends StatefulWidget {
  final int patientId;
  const IntakeNotesMiscellaneousScreen({super.key, required this.patientId});

  @override
  State<IntakeNotesMiscellaneousScreen> createState() =>
      _IntakeNotesMiscellaneousScreenState();
}

class _IntakeNotesMiscellaneousScreenState
    extends State<IntakeNotesMiscellaneousScreen> {
  final StreamController<List<IntakeNotesMiscData>> noteMiscController =
      StreamController<List<IntakeNotesMiscData>>();
  final StreamController<List<PatientDataComplianceModal>>
      _compliancePatientDataController =
      StreamController<List<PatientDataComplianceModal>>();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController patientIdcontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  int docTypeId = 0;
  bool _isLoading = false;
  String? expiryType;
  String fileName ='';
  dynamic filePath;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 40.0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ///status
                // Text(
                //   'Status: Not Completed',
                //   style: GoogleFonts.firaSans(
                //     decoration: TextDecoration.none,
                //     fontSize: FontSize.s14,
                //     fontWeight: FontWeightManager.bold,
                //     color: ColorManager.burnt_red,
                //   ),
                // ),
                SizedBox(width: MediaQuery.of(context).size.width / 60),
                ///add button
                Container(
                  height: AppSize.s32,
                  width: AppSize.s105,
                  child: SchedularIconButtonConst(
                    text: AppString.add_new,
                    icon: Icons.add,
                    onPressed: () async {
                      String? selectedDocType;
                      String? selectedExpiryType = expiryType;
                      String? expDate = calenderController.text;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MiscellaneousAddPopUp(
                              title: 'Add New Notes',
                              patientId: widget.patientId,
                              fileName: fileName,
                              filePath: filePath,
                              idDocController: docIdController,
                              nameDocController: docNamecontroller,
                              calenderController: calenderController,

                              // child2: ,
                              radioButton: StatefulBuilder(
                                builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppString.expiry_type,
                                        style: AllPopupHeadings.customTextStyle(context)
                                      ),
                                      CustomRadioListTile(
                                        value: "Not Applicable",
                                        groupValue: selectedExpiryType,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedExpiryType = value;
                                            if (selectedExpiryType ==
                                                "Not Applicable") {
                                              expDate = "";
                                            }
                                          });
                                        },
                                        title: "Not Applicable",
                                      ),
                                      CustomRadioListTile(
                                        value: 'Scheduled',
                                        groupValue: selectedExpiryType,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedExpiryType = value;
                                          });
                                        },
                                        title: 'Scheduled',
                                      ),
                                      CustomRadioListTile(
                                        value: 'Issuer Expiry',
                                        groupValue: selectedExpiryType,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedExpiryType = value;
                                          });
                                        },
                                        title: 'Issuer Expiry',
                                      ),
                                      Visibility(
                                        visible:
                                            selectedExpiryType == "Scheduled" ||
                                                selectedExpiryType ==
                                                    "Issuer Expiry",
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppString.expiry_date,
                                              style: AllPopupHeadings.customTextStyle(context)
                                            ),
                                            SizedBox(height: AppSize.s10),
                                            FormField<String>(
                                              builder: (FormFieldState<String>
                                                  field) {
                                                return SizedBox(
                                                  width: AppSize.s354,
                                                  height: AppSize.s30,
                                                  child: TextFormField(
                                                    controller:
                                                        calenderController,
                                                    cursorColor:
                                                        ColorManager.black,
                                                    style:TableSubHeading.customTextStyle(context),
                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ColorManager
                                                                .fmediumgrey,
                                                            width: AppSize.s1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ColorManager
                                                                .fmediumgrey,
                                                            width: AppSize.s1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      hintText: 'mm-dd-yyyy',
                                                      hintStyle:
                                                      TableSubHeading.customTextStyle(context),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        borderSide: BorderSide(
                                                            width: AppSize.s1,
                                                            color: ColorManager
                                                                .fmediumgrey),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 16),
                                                      suffixIcon: Icon(
                                                          Icons
                                                              .calendar_month_outlined,
                                                          color: ColorManager
                                                              .blueprime),
                                                      errorText:
                                                          field.errorText,
                                                    ),
                                                    onTap: () async {
                                                      DateTime? pickedDate =
                                                          await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(2000),
                                                        lastDate:
                                                            DateTime(3101),
                                                      );
                                                      if (pickedDate != null) {
                                                        calenderController
                                                            .text = DateFormat(
                                                                'MM-dd-yyyy')
                                                            .format(pickedDate);
                                                      }
                                                    },
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please select date';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              onPressed: () async {
                                print('File path on pressed ${filePath}');
                                setState(() {
                                  _isLoading = true;
                                });
                                String expiryTypeToSend =
                                selectedExpiryType == "Not Applicable"
                                    ? "--"
                                    : calenderController.text;
                                try {
                                  await addNotesMiscPost(
                                    context: context,
                                    patientId: widget.patientId,
                                    docTypeId: docTypeId, //  docTypeId,
                                    docName: docNamecontroller.text,
                                    docUrl: "some_doc_url",
                                    createdAt: calenderController.text,
                                    docType: selectedDocType!,
                                    // expDate: "${calenderController.text}T09:39:48.030Z",
                                     expDate: "2024-08-16T09:39:48.030Z",
                                  );
                                  print("DocName${docNamecontroller.text}");
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("An error occurred: $e")));
                                }
                              }
                              );
                            },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(12),
               // border: Border.symmetric(vertical: BorderSide(width: 0.2,color: ColorManager.grey),horizontal: BorderSide(width: 0.2,color: ColorManager.grey),),//all(width: 1, color: Color(0xFFBCBCBC)),
                border: Border.all(width: 0.2,color: ColorManager.lightGrey),//all(width: 1, color: Color(0xFFBCBCBC)),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height / 1.5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<List<IntakeNotesMiscData>>(
                        stream: noteMiscController.stream,
                        builder: (context, snapshot) {
                          getIntakeNoteMiscByPatientsID(context,
                                  patientId: widget.patientId)
                              .then((data) {
                            noteMiscController.add(data);
                          }).catchError((error) {
                            // Handle error
                          });
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                                child: CircularProgressIndicator(
                              color: ColorManager.blueprime,
                            ));
                          }
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                AppString.dataNotFound,
                                style: CustomTextStylesCommon.commonStyle(
                                  fontWeight: FontWeightManager.medium,
                                  fontSize: FontSize.s14,
                                  color: ColorManager.mediumgrey,
                                ),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                 final note = snapshot.data![index];
                                // var note = snapshot.data![index];
                                var fileUrl = note.docUrl;
                                final fileExtension = fileUrl.split('/').last;

                                Widget fileWidget;

                                if (['jpg', 'jpeg', 'png', 'gif'].contains(fileExtension)) {
                                  fileWidget = Image.network(
                                    fileUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(
                                        Icons.broken_image,
                                        size: 45,
                                        color: ColorManager.faintGrey,
                                      );
                                    },
                                  );
                                }
                                else if (['pdf', 'doc', 'docx'].contains(fileExtension)) {
                                  fileWidget = Icon(
                                    Icons.description,
                                    size: 45,
                                    color: ColorManager.faintGrey,
                                  );
                                } else {
                                  fileWidget = Icon(
                                    Icons.insert_drive_file,
                                    size: 45,
                                    color: ColorManager.faintGrey,
                                  );
                                }
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: AppSize.s65,
                                        decoration: BoxDecoration(
                                          color: ColorManager.white,
                                          borderRadius: BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: ColorManager.black.withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 10.0),
                                                    child: Container(
                                                      color: ColorManager.blueprime,
                                                      height: AppSize.s45,
                                                      width: AppSize.s65,
                                                      child: Icon(
                                                        Icons.remove_red_eye_outlined,
                                                        color: ColorManager.white,
                                                        size: AppSize.s24,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom: 4,top: 2),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'ID: ${snapshot.data![index].miscNoteId}',
                                                          style:TableSubHeading.customTextStyle(context),
                                                        ),
                                                        //SizedBox(height:AppSize.s2 ),
                                                        Text(snapshot.data![index].docType,
                                                          style:AllPopupHeadings.customTextStyle(context)
                                                        ),
                                                        //SizedBox(height: AppSize.s1),
                                                        Text(
                                                       "Expiry 10 months", //  'Expiry: ${snapshot.data![index].expDate.isNotEmpty ? note.expDate : 'N/A'}',
                                                          style: TableSubHeading.customTextStyleDate(context),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(child: Container()),
                                            Expanded(
                                             //flex: 2,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                        size: 20,
                                                      Icons.history,
                                                      color: ColorManager.granitegray
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                 // SizedBox(width: MediaQuery.of(context).size.width / 120),
                                                  IconButton(
                                                    icon: Icon(
                                                      size: 20,
                                                      Icons.print_outlined,
                                                        color:  ColorManager.granitegray
                                                    ),
                                                    onPressed: () async {
                                                      final pdf = pw.Document();

                                                      final miscNotes = snapshot.data!;

                                                      miscNotes.forEach((note) {
                                                        pdf.addPage(
                                                          pw.Page(
                                                            build: (pw.Context context) => pw.Column(
                                                              mainAxisAlignment: pw.MainAxisAlignment.start,
                                                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                              children: [
                                                                pw.Text(
                                                                  'Miscellaneous Note',
                                                                  style: pw.TextStyle(
                                                                    fontSize: FontSize.s18,
                                                                    fontWeight: pw.FontWeight.bold,
                                                                  ),
                                                                ),
                                                                pw.Divider(),
                                                                pw.SizedBox(height: AppSize.s20),
                                                                pw.Table(
                                                                  border: pw.TableBorder.all(),
                                                                  children: [
                                                                    pw.TableRow(
                                                                      children: [
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(
                                                                            'Misc ID',
                                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text('${note.miscNoteId}'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    pw.TableRow(
                                                                      children: [
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(
                                                                            'Patient ID',
                                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text('${note.patientId}'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    pw.TableRow(
                                                                      children: [
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(
                                                                            'Doc Type ID',
                                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text('${note.docTypeId}'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    pw.TableRow(
                                                                      children: [
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(
                                                                            'Doc Type',
                                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(note.docType.isNotEmpty ? note.docType : 'N/A'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    pw.TableRow(
                                                                      children: [
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(
                                                                            'Doc URL',
                                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(note.docUrl.isNotEmpty ? note.docUrl : 'N/A'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    pw.TableRow(
                                                                      children: [
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(
                                                                            'Name',
                                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(note.name.isNotEmpty ? note.name : 'N/A'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    pw.TableRow(
                                                                      children: [
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(
                                                                            'Created At',
                                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(note.createdAt.isNotEmpty ? note.createdAt : 'N/A'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    pw.TableRow(
                                                                      children: [
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(
                                                                            'Expiry Date',
                                                                            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                        pw.Padding(
                                                                          padding: pw.EdgeInsets.all(8.0),
                                                                          child: pw.Text(note.expDate.isNotEmpty ? note.expDate : 'N/A'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      });

                                                      await Printing.layoutPdf(
                                                        onLayout: (PdfPageFormat format) async => pdf.save(),
                                                      );
                                                    },
                                                  ),
                                                  //SizedBox(width: MediaQuery.of(context).size.width / 120),
                                                  IconButton(
                                                    icon: Icon(
                                                      size: 20,
                                                      Icons
                                                          .file_download_outlined,
                                                      color: Color(0xff686464),
                                                    ),
                                                    onPressed: () {
                                                      print("FileExtension:${fileExtension}");
                                                      DowloadFile().downloadPdfFromBase64(fileExtension,"MicNotes.pdf");
                                                      downloadFile(fileUrl);
                                                      // DowloadFile().downloadPdfFromBase64(fileExtension,"Compensation");


                                                    },
                                                  ),

                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            StatefulBuilder(
                                                          builder: (BuildContext
                                                                  context,
                                                              void Function(
                                                                      void
                                                                          Function())
                                                                  setState) {
                                                            return DeletePopup(
                                                              title:
                                                                  'Delete Miscellaneous Note',
                                                              loadingDuration:
                                                                  _isLoading,
                                                              onCancel: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              onDelete:
                                                                  () async {
                                                                setState(() {
                                                                  _isLoading =
                                                                      true;
                                                                });
                                                                try {
                                                                  await deleteMiscNoteAPI(
                                                                      context,
                                                                      snapshot
                                                                          .data![
                                                                              index]
                                                                          .miscNoteId!);
                                                                  setState(
                                                                      () async {
                                                                    getIntakeNoteMiscByPatientsID(
                                                                            context,
                                                                            patientId: widget
                                                                                .patientId)
                                                                        .then(
                                                                            (data) {
                                                                      noteMiscController
                                                                          .add(
                                                                              data);
                                                                    }).catchError(
                                                                            (error) {
                                                                      // Handle error
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  });
                                                                } finally {
                                                                  setState(() {
                                                                    _isLoading =
                                                                        false;
                                                                  });
                                                                }
                                                              },
                                                            );
                                                          },
                                                        ),
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.delete_outline,
                                                      size: 20,
                                                      color: Color(0xff686464),
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return MiscellaneousEditPopUp();
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Icon(
                                                          Icons.mode_edit_outlined,
                                                          color: ColorManager.white,
                                                          size: IconSize.I18,
                                                        ),
                                                       SizedBox(width: 20),
                                                        Text(
                                                          'Edit',
                                                          style: BlueButtonTextConst.customTextStyle(context)
                                                        ),
                                                      ],
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                      shape: RoundedRectangleBorder(  borderRadius: BorderRadius.circular(12),),
                                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                                      backgroundColor: ColorManager.blueprime,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          }
                          return Offstage();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
