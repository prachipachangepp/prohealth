import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/widgets/intake_notes_miscellaneous/widget/miscellaneous_add_pop_up.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_notes/widgets/intake_notes_miscellaneous/widget/miscellaneous_edit_pop_up.dart';

import '../../../../../../../../app/resources/color.dart';
import '../../../../../../../../app/resources/font_manager.dart';
import '../../../../../widgets/constant_widgets/button_constant.dart';


class IntakeNotesMiscellaneousScreen extends StatefulWidget {
  const IntakeNotesMiscellaneousScreen({super.key});

  @override
  State<IntakeNotesMiscellaneousScreen> createState() => _IntakeNotesMiscellaneousScreenState();
}

class _IntakeNotesMiscellaneousScreenState extends State<IntakeNotesMiscellaneousScreen> {
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
                  Text('Status: Not Completed',
                    style: GoogleFonts.firaSans(
                        decoration: TextDecoration.none,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Color(0xffDE0909)
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/60),
                  Container(
                    height: 32,
                    width: 105,
                    child: SchedularIconButtonConst(
                        text: 'Add New',
                        icon: Icons.add,
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MiscellaneousAddPopUp();
                            },
                          );

                        }
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/30),
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
                // width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40),
                              child: Column(
                                children: [
                                  Container(
                                    height: 65,
                                    // width: 1109, //1109
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
                                                child: Icon(Icons.remove_red_eye_outlined, color: Colors.white, size: 24,),
                                              ),
                                            ),

                                            SizedBox(width: MediaQuery.of(context).size.width/120),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 11.5),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'ID: 248d1eb1-9020-4d8d-8168-43a3ef90a261',
                                                    style: GoogleFonts.firaSans(
                                                        decoration: TextDecoration.none,
                                                        fontSize: 10.0,
                                                        fontWeight: FontWeight.w500,
                                                        color: Color(0xff686464)
                                                    ),
                                                  ),
                                                  SizedBox(height: 3.5),
                                                  Text(
                                                    'Compliance 1',
                                                    style: GoogleFonts.firaSans(
                                                        decoration: TextDecoration.none,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.w700,
                                                        color: Color(0xff686464)
                                                    ),
                                                  ),

                                                  SizedBox(height: 1),
                                                  Text(
                                                    'Expiry 10 months',
                                                    style: GoogleFonts.firaSans(
                                                        decoration: TextDecoration.none,
                                                        fontSize: 10.0,
                                                        fontWeight: FontWeight.w300,
                                                        color: Color(0xff686464)
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        // SizedBox(width: MediaQuery.of(context).size.width/4.5), //3.5
                                        Padding(
                                          padding: const EdgeInsets.only(right: 50.0),
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.history,
                                                  color: Color(0xff686464),
                                                ),
                                                onPressed: () {

                                                },
                                              ),

                                              SizedBox(width: MediaQuery.of(context).size.width/120),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.print_outlined,
                                                  color: Color(0xff686464),
                                                ),
                                                onPressed: () async {
                                                  final pdf = pw.Document();

                                                  pdf.addPage(
                                                    pw.Page(
                                                      build: (pw.Context context) => pw.Center(
                                                        child: pw.Text('Hello, this is a test print!'),
                                                      ),
                                                    ),
                                                  );

                                                  await Printing.layoutPdf(
                                                    onLayout: (PdfPageFormat format) async => pdf.save(),
                                                  );
                                                },
                                              ),

                                              SizedBox(width: MediaQuery.of(context).size.width/120),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.file_download_outlined,
                                                  color: Color(0xff686464),
                                                ),
                                                onPressed: () {

                                                },
                                              ),

                                              SizedBox(width: MediaQuery.of(context).size.width/120),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.delete_outline,
                                                  color: Color(0xff686464),
                                                ),
                                                onPressed: () {

                                                },
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width/100),
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
                                                    Icon(Icons.mode_edit_outlined, color: ColorManager.white),
                                                    SizedBox(width: MediaQuery.of(context).size.width/160),
                                                    Text(
                                                      'Edit',
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: FontSize.s12,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorManager.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                                                  backgroundColor: ColorManager.blueprime,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12),
                                                    // side: BorderSide(color: Color(0xFFF6928A)),
                                                  ),
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
                        ),
                      )
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