import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/controller/controller.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/add_batch_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/view_batch_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';

class DefineWorkWeek extends StatefulWidget {
  const DefineWorkWeek({super.key});

  @override
  State<DefineWorkWeek> createState() => _DefineWorkWeekState();
}

class _DefineWorkWeekState extends State<DefineWorkWeek> {
TextEditingController startTimeController = TextEditingController();
TextEditingController endTimeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Material(
      child: GetBuilder<Controller>(
        init: Controller(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  children: List.generate(controller.daysList.length, (index) {
                    var days = controller.daysList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: mediaQuery.height / 3,
                        width: mediaQuery.width / 3.3,
                        decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 2, color: Colors.grey, spreadRadius: 1)
                            ]),
                        child: Row(
                          children: [
                            Container(
                              height: mediaQuery.height / 1,
                              width: mediaQuery.width / 40,
                              decoration: BoxDecoration(
                                  color: ColorManager.faintOrange,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      bottomLeft: Radius.circular(10))),
                              child: Center(
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(
                                    days.toString(),
                                    style: TextStyle(
                                        letterSpacing: 1,
                                        color: ColorManager.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: mediaQuery.height / 23.5,
                                  width: mediaQuery.width / 3.6,
                                  // width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: ColorManager.grey,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text('Office Start Time',style: TextStyle(

                                            color: ColorManager.white,
                                            fontWeight: FontWeight.w700),),
                                        Text('Office End Time',style: TextStyle(

                                            color: ColorManager.white,
                                            fontWeight: FontWeight.w700),),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: mediaQuery.height / 3.7,
                                  width:mediaQuery.width / 3.6,
                                  // width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: mediaQuery.height / 20,
                                              width: mediaQuery.width / 12,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey, width: 1),
                                                  borderRadius:
                                                  BorderRadius.circular(10)),
                                              child: Center(child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text("10:00 AM",style: GoogleFonts.firaSans(
                                                fontSize: mediaQuery.width/120,
                                                fontWeight: FontWeightManager.semiBold,
                                                color: ColorManager.mediumgrey,
                                                decoration: TextDecoration.none,
                                              )),
                                                  Icon(Icons.timer_outlined,size: AppSize.s20,)
                                                ],
                                              ),),
                                            ),
                                            Spacer(),
                                            Container(
                                              height:
                                              mediaQuery.height /
                                                  20,
                                              width: mediaQuery.width / 12,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey, width: 1),
                                                  borderRadius:
                                                  BorderRadius.circular(10)),
                                              child: Center(child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text("6:00 PM",style: GoogleFonts.firaSans(
                                                    fontSize: mediaQuery.width/120,
                                                    fontWeight: FontWeightManager.semiBold,
                                                    color: ColorManager.mediumgrey,
                                                    decoration: TextDecoration.none,
                                                  )),
                                                  Icon(Icons.timer_outlined,size: AppSize.s20)
                                                ],
                                              ),),
                                            ),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.delete_outline,
                                                  color: ColorManager.blueprime,
                                                ))
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        color: ColorManager.faintgrey,
                                        thickness: 1,
                                      ),
                                      Container(
                                        height: 70,
                                        child: ListView.builder(
                                          itemCount: 2,
                                          itemBuilder: (context,index) {
                                            return Column(
                                              children: [
                                                Row(
                                                  //alignment: WrapAlignment.spaceBetween,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: [
                                                    Text('Shift 1',style: GoogleFonts.firaSans(
                                                      fontSize: mediaQuery.width/100,
                                                      fontWeight: FontWeightManager.bold,
                                                      color: ColorManager.mediumgrey,
                                                      decoration: TextDecoration.none,
                                                    ),),
                                                    Container(
                                                      height: mediaQuery.height / 30,
                                                      width: mediaQuery.width / 11,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color: Colors.grey, width: 1),
                                                          borderRadius:
                                                          BorderRadius.circular(10)),
                                                      child: Center(child: Text("11 PM - 12 PM",style: GoogleFonts.firaSans(
                                                        fontSize: mediaQuery.width/100,
                                                        fontWeight: FontWeightManager.semiBold,
                                                        color: ColorManager.mediumgrey,
                                                        decoration: TextDecoration.none,
                                                      ),)),
                                                    ),
                                                    InkWell(
                                                      onTap: (){
                                                        showDialog(context: context, builder: (BuildContext context){
                                                          return ViewBatchesPopup();
                                                        });
                                                      },
                                                      child: Text('10+ Batches more',style: GoogleFonts.firaSans(
                                                        fontSize: mediaQuery.width/100,
                                                        fontWeight: FontWeightManager.light,
                                                        color: ColorManager.faintgrey,
                                                        decoration: TextDecoration.none,
                                                      ),),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(context: context, builder: (BuildContext context){
                                                            return AddBatchPopup(controller1: startTimeController, controller2: endTimeController, onPressed: () {  },);
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          color: ColorManager.red,
                                                        ))
                                                  ],
                                                ),
                                              ],
                                            );
                                          }
                                        ),
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CustomIconButton(text: "Add Shift",onPressed: (){},icon: Icons.add,)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            
                ),
                SizedBox(height: AppSize.s40,),
                Center(
                  child: CustomElevatedButton(
                    width: AppSize.s105,
                    height: AppSize.s30,
                    text: AppStringEM.save,
                    onPressed: () {
                     // Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
