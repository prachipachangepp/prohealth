import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/child_tabbar_screen/equipment_child/equipment_head_tabbar.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/widgets/intake_notes_miscellaneous/widget/miscellaneous_add_pop_up.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/widgets/intake_notes_miscellaneous/widget/miscellaneous_edit_pop_up.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/const_string.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/notes_manager/notes_misc_manager.dart';
import '../../../../../../../../app/services/api/managers/sm_module_manager/patient_data/patient_data_compliance.dart';
import '../../../../../../../../data/api_data/sm_data/Intake_deta/notes_data/intake_misc_note_data.dart';
import '../../../../../../../../data/api_data/sm_data/patient_data/patient_data_compliance.dart';
import '../../../../../../em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../../../../../em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import '../../../../../../em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';


class IntakeNotesMiscellaneousScreen extends StatefulWidget {
  final int patientId;
  const IntakeNotesMiscellaneousScreen({super.key, required this.patientId});

  @override
  State<IntakeNotesMiscellaneousScreen> createState() => _IntakeNotesMiscellaneousScreenState();
}

class _IntakeNotesMiscellaneousScreenState extends State<IntakeNotesMiscellaneousScreen> {
  final StreamController<List<IntakeNotesMiscData>>noteMiscController = StreamController<List<IntakeNotesMiscData>>();
  final StreamController<List<PatientDataComplianceModal>>_compliancePatientDataController =
  StreamController<List<PatientDataComplianceModal>>();
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController patientIdcontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  TextEditingController calenderController = TextEditingController();
  int docTypeId = 0;
  bool _isLoading = false;
  String? expiryType;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 40.0, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Status: Not Completed',
                    style: GoogleFonts.firaSans(
                      decoration: TextDecoration.none,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffDE0909),
                    ),
                  ),

                  SizedBox(width: MediaQuery.of(context).size.width / 60),
        Container(
          height: 32,
          width: 105,
          child: SchedularIconButtonConst(
            text: 'Add New',
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
                    idDocController: docIdController,
                    nameDocController: nameController,
                    calenderController: calenderController,
                    child: FutureBuilder<List<PatientDataComplianceDoc>>(
                      future: getpatientDataComplianceDoc(context),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            width: 350,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          );
                        }
                        if (snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              AppString.dataNotFound,
                              style: CustomTextStylesCommon.commonStyle(
                                fontWeight: FontWeightManager.medium,
                                fontSize: FontSize.s12,
                                color: ColorManager.mediumgrey,
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          List<DropdownMenuItem<String>> dropDownMenuItems = snapshot.data!
                              .map((doc) => DropdownMenuItem<String>(
                            value: doc.docType,
                            child: Text(doc.docType!),
                          ))
                              .toList();
                          return CICCDropdown(
                            initialValue: selectedDocType ?? dropDownMenuItems[0].value,
                            onChange: (val) {
                              setState(() {
                                selectedDocType = val;
                                for (var doc in snapshot.data!) {
                                  if (doc.docType == val) {
                                    docTypeId = doc.docTypeId!;
                                  }
                                }
                              });
                            },
                            items: dropDownMenuItems,
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    radioButton: StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expiry Type",
                              style: GoogleFonts.firaSans(
                                fontSize: FontSize.s12,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.mediumgrey,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            CustomRadioListTile(
                              value: "Not Applicable",
                              groupValue: selectedExpiryType,
                              onChanged: (value) {
                                setState(() {
                                  selectedExpiryType = value;
                                  if (selectedExpiryType == "Not Applicable") {
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
                              visible: selectedExpiryType == "Scheduled" || selectedExpiryType == "Issuer Expiry",
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Expiry Date",
                                    style: GoogleFonts.firaSans(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.mediumgrey,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  FormField<String>(
                                    builder: (FormFieldState<String> field) {
                                      return SizedBox(
                                        width: 354,
                                        height: 30,
                                        child: TextFormField(
                                          controller: calenderController,
                                          cursorColor: ColorManager.black,
                                          style: GoogleFonts.firaSans(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w700,
                                            color: ColorManager.mediumgrey,
                                          ),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: ColorManager.fmediumgrey, width: 1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            hintText: 'mm-dd-yyyy',
                                            hintStyle: GoogleFonts.firaSans(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorManager.mediumgrey,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(width: 1, color: ColorManager.fmediumgrey),
                                            ),
                                            contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                            suffixIcon: Icon(Icons.calendar_month_outlined, color: ColorManager.blueprime),
                                            errorText: field.errorText,
                                          ),
                                          onTap: () async {
                                            DateTime? pickedDate = await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(2000),
                                              lastDate: DateTime(3101),
                                            );
                                            if (pickedDate != null) {
                                              calenderController.text = DateFormat('MM-dd-yyyy').format(pickedDate);
                                            }
                                          },
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'please select date';
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
                        try {
                           await addNotesMiscPost(
                            context: context,
                            patientId: widget.patientId,
                            docTypeId: docTypeId,
                            docName: nameController.text,
                            docUrl: "some_doc_url",
                            createdAt: calenderController.text,
                            docType: selectedDocType!,
                            expDate: "${calenderController.text}T09:39:48.030Z",
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An error occurred: $e")));
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
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.width * 0.3,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: StreamBuilder<List<IntakeNotesMiscData>>(
                          stream: noteMiscController.stream,
                          builder: (context, snapshot) {
                            getIntakeNoteMiscByPatientsID(context, patientId: widget.patientId).then((data) {
                              noteMiscController.add(data);
                            }).catchError((error) {
                              // Handle error
                            });
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(color: ColorManager.blueprime,));
                            }if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Text(
                                  AppString.dataNotFound,
                                  style: CustomTextStylesCommon.commonStyle(
                                    fontWeight: FontWeightManager.medium,
                                    fontSize: FontSize.s12,
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
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
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
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0),
                                                  child: Container(
                                                    color: Color(0xff50B5E5),
                                                    height: 45,
                                                    width: 62,
                                                    child: Icon(
                                                      Icons.remove_red_eye_outlined,
                                                      color: Colors.white,
                                                      size: 24,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: MediaQuery.of(context).size.width / 120),
                                                Padding(
                                                  padding: const EdgeInsets.only(top: 11.5),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'ID: ${snapshot.data![index].miscNoteId}',
                                                        style: GoogleFonts.firaSans(
                                                          decoration: TextDecoration.none,
                                                          fontSize: 10.0,
                                                          fontWeight: FontWeight.w500,
                                                          color: Color(0xff686464),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3.5),
                                                      Text(
                                                        snapshot.data![index].docType,
                                                        style: GoogleFonts.firaSans(
                                                          decoration: TextDecoration.none,
                                                          fontSize: 12.0,
                                                          fontWeight: FontWeight.w700,
                                                          color: Color(0xff686464),
                                                        ),
                                                      ),
                                                      SizedBox(height: 1),
                                                      Text(
                                                        'Expiry: ${snapshot.data![index].expDate.isNotEmpty ? note.expDate : 'N/A'}',
                                                        style: GoogleFonts.firaSans(
                                                          decoration: TextDecoration.none,
                                                          fontSize: 10.0,
                                                          fontWeight: FontWeight.w300,
                                                          color: Color(0xff686464),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(right: 50.0),
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.history,
                                                      color: Color(0xff686464),
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  SizedBox(width: MediaQuery.of(context).size.width / 120),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.print_outlined,
                                                      color: Color(0xff686464),
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
                                                                    fontSize: 18,
                                                                    fontWeight: pw.FontWeight.bold,
                                                                  ),
                                                                ),
                                                                pw.Divider(),
                                                                pw.SizedBox(height: 20),
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

                                                  SizedBox(width: MediaQuery.of(context).size.width / 120),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.file_download_outlined,
                                                      color: Color(0xff686464),
                                                    ),
                                                    onPressed: () {},
                                                  ),
                                                  SizedBox(width: MediaQuery.of(context).size.width / 120),
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) => StatefulBuilder(
                                                          builder: (BuildContext context, void Function(void Function()) setState) {
                                                            return DeletePopup(
                                                              title: 'Delete Miscellaneous Note',
                                                              loadingDuration: _isLoading,
                                                              onCancel: () {
                                                                Navigator.pop(context);
                                                              },
                                                              onDelete: () async {
                                                                setState(() {
                                                                  _isLoading = true;
                                                                });
                                                                try {
                                                                  await deleteMiscNoteAPI(context, snapshot.data![index].miscNoteId!);
                                                                  setState(() async {
                                                                   getIntakeNoteMiscByPatientsID(context, patientId: widget.patientId).then((data) {
                                                                     noteMiscController.add(data);
                                                                   }).catchError((error) {
                                                                     // Handle error
                                                                   });
                                                                    Navigator.pop(context);
                                                                  });
                                                                } finally {
                                                                  setState(() {
                                                                    _isLoading = false;
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
                                                      size: 22,
                                                      color: Colors.red,
                                                    ),
                                                  ),

                                                  SizedBox(width: MediaQuery.of(context).size.width / 100),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return MiscellaneousEditPopUp();
                                                        },
                                                      );
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.mode_edit_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: MediaQuery.of(context).size.width / 160),
                                                        Text(
                                                          'Edit',
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                                      backgroundColor: Color(0xff50B5E5),
                                                    ),
                                                  ),
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
      ),
    );
  }
}

