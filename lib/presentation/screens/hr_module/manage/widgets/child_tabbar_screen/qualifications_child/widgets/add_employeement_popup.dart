import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/register/taxtfield_constant.dart';

class AddEmployeementPopup extends StatefulWidget {
  final TextEditingController positionTitleController;
  final TextEditingController leavingResonController;
  final TextEditingController startDateContoller;
  final TextEditingController endDateController;
  final TextEditingController lastSupervisorNameController;
  final TextEditingController supervisorMobileNumber;
  final TextEditingController cityNameController;
  final TextEditingController employeerController;
  final TextEditingController emergencyMobileNumber;
  final VoidCallback onpressedClose;
  final VoidCallback onpressedSave;
  final Widget checkBoxTile;
   AddEmployeementPopup({super.key, required this.positionTitleController, required this.leavingResonController, required this.startDateContoller, required this.endDateController, required this.lastSupervisorNameController, required this.supervisorMobileNumber, required this.cityNameController, required this.employeerController, required this.emergencyMobileNumber, required this.onpressedClose, required this.onpressedSave, required this.checkBoxTile});

  @override
  State<AddEmployeementPopup> createState() => _AddEmployeementPopupState();
}

class _AddEmployeementPopupState extends State<AddEmployeementPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s900,
        height: AppSize.s400,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
                    child: Text("Add Education",style: GoogleFonts.firaSans(
                      fontSize: FontSize.s16,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.blueprime,
                      decoration: TextDecoration.none,
                    ),),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomIconButton(icon: Icons.add,text: 'Add Employeement', onPressed: () async{
                    }),

                  ],
                ),
              ),
              SizedBox(height:MediaQuery.of(context).size.height/20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.positionTitleController,
                    labelText: "Final Position Title",
                    keyboardType: TextInputType.text,
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.leavingResonController,
                    labelText: "Reason For Leaving",
                    keyboardType: TextInputType.text,
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.startDateContoller,
                    labelText: "Start Date",
                    keyboardType: TextInputType.text,
                    suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime,),
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),

                ],
              ),
              SizedBox(height:MediaQuery.of(context).size.height/20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.endDateController,
                    labelText: "End Date",
                    keyboardType: TextInputType.text,
                    suffixIcon: Icon(Icons.calendar_month_outlined,color: ColorManager.blueprime,),
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.lastSupervisorNameController,
                    labelText: "Last Supervisor’s Name",
                    keyboardType: TextInputType.text,
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.supervisorMobileNumber,
                    labelText: "Supervisor’s Mobile Number",
                    keyboardType: TextInputType.text,
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),

                ],
              ),
              //SizedBox(height:MediaQuery.of(context).size.height/50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.checkBoxTile,
                ],
              ),
             // SizedBox(height:MediaQuery.of(context).size.height/50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.cityNameController,
                    labelText: "City",
                    keyboardType: TextInputType.text,
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.employeerController,
                    labelText: "Employer",
                    keyboardType: TextInputType.text,
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),
                  CustomTextFieldRegister(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width/6,
                    controller: widget.emergencyMobileNumber,
                    labelText: "Emergency Mobile Number",
                    keyboardType: TextInputType.text,
                    padding: const EdgeInsets.only(bottom:AppPadding.p5,left: AppPadding.p20),
                    onChanged: (value) {

                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppString.enterText;
                      }
                      return null;
                    },
                  ),

                ],
              ),
              SizedBox(height:MediaQuery.of(context).size.height/15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButtonTransparent(text: "Cancel", onPressed: () async{
                      widget.onpressedClose;
                    }),
                    SizedBox(width: 10,),
                    CustomElevatedButton(text: "Save",onPressed: (){
                      widget.onpressedSave;
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
