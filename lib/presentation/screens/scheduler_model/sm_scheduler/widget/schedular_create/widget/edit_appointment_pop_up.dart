import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_Intake/widgets/intake_insurance/widgets/intake_insurance_primary/intake_insurance_primary_screen.dart';
import '../../../../../../../../../app/resources/color.dart';
import '../../../../widgets/constant_widgets/schedular_success_popup.dart';
import '../../../../widgets/constant_widgets/textfield_constant.dart';

class EditAppointmentPopUp extends StatefulWidget {
  const EditAppointmentPopUp({super.key});

  @override
  State<EditAppointmentPopUp> createState() => _EditAppointmentPopUpState();
}

class _EditAppointmentPopUpState extends State<EditAppointmentPopUp> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.zero,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: ColorManager.blueprime,
        ),
        height: 47,
        width: 700,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Edit Appointment',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
          ],
        ),
      ),
      content: SingleChildScrollView(
        child: Container(
          height: 350,
          width: 600,
          color: ColorManager.white,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Select Patient',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(labelText: ''),
                      ],
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assigned Clinician',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(labelText: ''),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assign Date',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(labelText: '', isDate: true, initialValue: 'Select',),
                      ],
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    child: Container()
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Time',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(labelText: '', isTime: true, initialValue: 'Select',),
                      ],
                    ),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Time',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        PopUpTextField(labelText: '', isTime: true, initialValue: 'Select',),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                            color: ColorManager.mediumgrey,
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Container(
                            height: 54,
                            child: PopUpTextField(labelText: '', initialValue: 'Enter Text',))
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.s14,
                            color: ColorManager.mediumgrey)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/60),
                  SizedBox(
                    height: 31,
                    width: 105,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 4),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        child: Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: FontSize.s14,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.blueprime,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SchedularSuccessPopup(title: 'Success',);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


