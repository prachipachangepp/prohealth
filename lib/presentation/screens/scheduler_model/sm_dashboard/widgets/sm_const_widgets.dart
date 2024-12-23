import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_dashboard/widgets/popup_const.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_dashboard/widgets/sm_dashboard_const.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/common_resources/em_dashboard_theme.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../widgets/widgets/constant_textfield/const_textfield.dart';
import '../../../em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import '../../sm_scheduler/widget/schedular/schedular_new_screen.dart';

///row 2 part 1
class AllVisitsUpdate extends StatelessWidget {
  const AllVisitsUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                SMDashboardContainerConst(
                  child: SMSmallContainerData(headingText: 'No. of Clinicians working today', totalCount: '125',
                    imagePath: 'images/sm/sm_dashboard/clinician_work.png', totalValue: 75, flex: 4,
                    indicatorColor: ColorManager.Violet,TextColor: ColorManager.greenDark,),
                ),
                const SizedBox(height: 10,),
                ///Employee Ratio
                GestureDetector(
                  onTap: (){
                    showDialog(context: context, builder: (context) => MissedVisitPopup());
                  },
                  child: SMDashboardContainerConst(
                    child: SMSmallContainerData(headingText: 'Missed Visit Count', totalCount: '03',
                      imagePath: 'images/sm/sm_dashboard/missed_visit.png', totalValue: 50,
                      indicatorColor: ColorManager.red,TextColor: ColorManager.rednew,),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15,),

          Expanded(
            child: Column(
              children: [
                ///Attrition Rate
                SMDashboardContainerConst(
                  child: SMSmallContainerData(headingText: 'No. of SOC\'s due today', totalCount: '92',
                    imagePath: 'images/sm/sm_dashboard/soc_due.png', totalValue: 92,
                    indicatorColor: ColorManager.orange.withOpacity(0.5),TextColor: ColorManager.greenDark,),
                ),
                SizedBox(height: 10,),
                ///hiring ratio
                SMDashboardContainerConst(
                  child: SMSmallContainerData(headingText: 'Todays Completed Visits', totalCount: '17/30',
                    imagePath: 'images/sm/sm_dashboard/completed_visit.png', totalValue: 40,
                    indicatorColor: Colors.orangeAccent.withOpacity(0.4),TextColor: ColorManager.greenDark,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
///row 2 part 2
class ScheduledToBeScheduledPatients extends StatelessWidget {
  const ScheduledToBeScheduledPatients({super.key});

  @override
  Widget build(BuildContext context) {
    return   Expanded(
        flex: 3,
        child: SMDashboadGraphContainer(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0,left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Number of Patients",
                        style: TextStyle(fontSize: FontSize.s12,color: ColorManager.mediumgrey,fontWeight: FontWeight.w600),),
                      CustomDropdownTextField(
                        width: 100,
                        isAstric:false,
                        // Adjust headText based on depId
                        initialValue: 'Weekly',
                        headText: "", // Default fallback if depId doesn't match any of the expected values
                        items: ["Weekly", "Monthly"],
                        onChanged: (newValue) {
                          // for (var a in snapshot.data!) {
                          //   if (a.empType == newValue) {
                          //     clinicialName = a.empType!;
                          //     clinicalId = a.employeeTypesId!;
                          //     print("Dept ID'''''' ${clinicalId}");
                          //     print("';';';''''''''Dept ID ${clinicialName}");
                          //     // Do something with docType
                          //   }
                          // }
                        },
                      ),
                    ],),
                ),
                Divider(),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text("Scheduled",
                          style: TextStyle(fontSize: FontSize.s14,color: ColorManager.mediumgrey,fontWeight: FontWeight.w600),),
                        Container(
                          width: 100,
                          child: Divider(),
                        ),
                        Text("112",
                          style: TextStyle(fontSize: FontSize.s30,color: ColorManager.fGrey,fontWeight: FontWeight.w700),),
                      ],),
                    SizedBox(width: 5,),
                    Column(children: [
                      Text("To Be Scheduled",
                        style: TextStyle(fontSize: FontSize.s14,color: ColorManager.mediumgrey,fontWeight: FontWeight.w600),),
                      Container(
                        width: 100,
                        child: Divider(),
                      ),
                      Text("78",
                        style: TextStyle(fontSize: FontSize.s30,color: ColorManager.fGrey,fontWeight: FontWeight.w700),),
                    ],),
                  ],)
              ],
            )));
  }
}

///row2 part 3
class ScheduledPatientsList extends StatelessWidget {
  const ScheduledPatientsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 6,
        child: JointContainerConst(
          height: 225,
          childHeading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Patients Name',
                  textAlign: TextAlign.start,
                  style: MenuContainerTextStylling.customTextStyle(context),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Address',
                    textAlign: TextAlign.end,
                    style: MenuContainerTextStylling.customTextStyle(context),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Visit Frequency',
                    textAlign: TextAlign.end,
                    style: MenuContainerTextStylling.customTextStyle(context),
                  ),
                ),
                Text(
                  'Status',
                  textAlign: TextAlign.start,
                  style: MenuContainerTextStylling.customTextStyle(context),
                ),
              ],
            ),
          ),
          childBody:  Column(
            children: [
              Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                      // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                      // EmployeeDocumentModal employeedoc = paginatedData[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  //flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Image.asset(
                                              'images/hr_dashboard/man.png', // Replace with your image path
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Eva I",
                                            textAlign: TextAlign.start,
                                            style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w600,
                                              color: ColorManager.textBlack,),
                                          ),
                                          Text(
                                            "Cancer",
                                            textAlign: TextAlign.start,
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w400,
                                              color: ColorManager.mediumgrey,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child:  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.location_on_outlined,color: ColorManager.bluebottom,size: IconSize.I18,),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Text(
                                          "Tufts International Center, 20 Sawyer Ave, Medford MA 02155 ",
                                          textAlign: TextAlign.start,
                                          style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.mediumgrey,),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                    ],
                                  ),),
                                Expanded(
                                  flex:1,
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SMDashboardConst(
                                              onTap: (int index) {
                                                //_selectButton(index);
                                              },
                                              index: 0,
                                              grpIndex: 0,),
                                            SizedBox(width: 2,),
                                            SMDashboardConst(
                                              onTap: (int index) {
                                                //_selectButton(index);
                                              },
                                              index: 0,
                                              grpIndex: 0,),
                                            SizedBox(width: 2,),
                                            SMDashboardConst(
                                              onTap: (int index) {
                                                //_selectButton(index);
                                              },
                                              index: 0,
                                              grpIndex: 0,),
                                          ]
                                      ),
                                      Text(
                                        "3/3",
                                        textAlign: TextAlign.end,
                                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                          fontWeight: FontWeight.w400,
                                          color: ColorManager.mediumgrey,),
                                      ),
                                    ],
                                  ),),
                                Expanded(
                                  //flex: 2,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Completed",
                                        textAlign: TextAlign.end,
                                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                          fontWeight: FontWeight.w600,
                                          color: ColorManager.greenDark,),
                                      ),
                                      // SizedBox(width: 20,),
                                      // Image.asset(
                                      //   "images/sm/contact.png",
                                      //   height: 45,width: 55,fit: BoxFit.fill,
                                      // ),
                                    ],
                                  ),
                                ),
                              ],),
                          ),
                          Divider(color: ColorManager.dashDivider,height: 1,),
                          SizedBox(height: AppSize.s5),
                        ],
                      );
                    },
                  )),
              //SizedBox(height: AppSize.s10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "View More",
                            textAlign: TextAlign.end,
                            style: EmDashViewMoreText.customTextStyle(context),
                          ),
                          SizedBox(width: AppSize.s5),
                          Icon(Icons.arrow_forward,color: ColorManager.blueprime,size: IconSize.I16,)
                        ],
                      ),
                    ),
                  ],),
              ),

            ],
          ),));
  }
}

///row 3 part 1
class PatientsToBeScheduledList extends StatelessWidget {
  const PatientsToBeScheduledList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 3,
        child: JointContainerConst(
          height: 245,
          childHeading: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Patients to be scheduled',
                  textAlign: TextAlign.start,
                  style: MenuContainerTextStylling.customTextStyle(context),
                ),
              ],
            ),
          ),
          childBody:  Column(
            children: [
              Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                      // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                      // EmployeeDocumentModal employeedoc = paginatedData[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  //flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: SizedBox(
                                            width: 50,
                                            height: 50,
                                            child: Image.asset(
                                              'images/hr_dashboard/man.png', // Replace with your image path
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Eva I",
                                            textAlign: TextAlign.start,
                                            style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w600,
                                              color: ColorManager.textBlack,),
                                          ),
                                          Text(
                                            "Cancer",
                                            textAlign: TextAlign.start,
                                            style: CustomTextStylesCommon.commonStyle(
                                              fontSize: FontSize.s12,
                                              fontWeight: FontWeight.w400,
                                              color: ColorManager.mediumgrey,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex:2,
                                  child:  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.location_on_outlined,color: ColorManager.bluebottom,size: IconSize.I18,),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Text(
                                          "Tufts International Center, 20 Sawyer Ave, Medford MA 02155 ",
                                          textAlign: TextAlign.start,
                                          style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w500,
                                            color: ColorManager.mediumgrey,),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                    ],
                                  ),),
                                Container(
                                    width: 185,
                                    height: 30,
                                    child:Row(
                                      children: [
                                        Container(
                                          width: 90,
                                          child:  ElevatedButton.icon(onPressed: ()async{
                                            await  showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return VendorSelectNoti(
                                                  message: 'Please Select A File',
                                                );
                                              },
                                            );
                                          },
                                            label: Text("Auto", style: TextStyle(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w600,
                                            color: ColorManager.white,
                                            decoration: TextDecoration.none,
                                          )),
                                            //icon: Icon(Icons.flash_auto,color:ColorManager.white ,size: 16,),
                                            icon: Image.asset("images/sm/auto.png",height: 30,width: 18,),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:  ColorManager.bluebottom,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12), // Round only the top-left corner
                                                  bottomLeft: Radius.circular(12), // Round only the bottom-left corner
                                                ),
                                                side: BorderSide(
                                                  color: ColorManager.bluebottom, // Border color
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 95,
                                          child:  ElevatedButton.icon(onPressed: (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AddErrorPopup(
                                                  message: 'File is too large!',
                                                );
                                              },
                                            );
                                          },label: Text("Manual", style: TextStyle(
                                            fontSize: FontSize.s12,
                                            fontWeight: FontWeight.w600,
                                            color: ColorManager.bluebottom,
                                            decoration: TextDecoration.none,
                                          )),
                                            //icon: Icon(Icons.swipe_rounded,color:ColorManager.bluebottom ,size: 16,),
                                            icon: Image.asset("images/sm/manual.png",height: 30,width: 18,),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12), // Round only the top-left corner
                                                  bottomRight: Radius.circular(12), // Round only the bottom-left corner
                                                ),
                                                side: BorderSide(
                                                  color: ColorManager.bluebottom, // Border color
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],),
                          ),
                          Divider(color: ColorManager.dashDivider,height: 1,),
                          SizedBox(height: AppSize.s5),
                        ],
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "View More",
                            textAlign: TextAlign.end,
                            style: EmDashViewMoreText.customTextStyle(context),
                          ),
                          SizedBox(width: AppSize.s5),
                          Icon(Icons.arrow_forward,color: ColorManager.blueprime,size: IconSize.I16,)
                        ],
                      ),
                    ),
                  ],),
              ),
            ],
          ),));
  }
}
///row 3 part 2
class AllAvailableClinician extends StatelessWidget {
  const AllAvailableClinician({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 5,
        child: JointContainerConst(
          height: 245,
          childHeading: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'All Available Clinicians',
                textAlign: TextAlign.start,
                style: MenuContainerTextStylling.customTextStyle(context),
              ),
            ],
          ),
          childBody: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                      // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                      // EmployeeDocumentModal employeedoc = paginatedData[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  //flex: 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Stack(

                                        children: [SizedBox(
                                          height:50,
                                          child: CircleAvatar(
                                            child:
                                            Image.asset('images/1.png'),
                                          ),
                                        ),
                                          Positioned(
                                            left:22,
                                            bottom :0,
                                            child: Container(
                                              color: Color(0xFF527FB9),
                                              width: 19,
                                              height: 15,
                                              child: Center(
                                                child: Text("ST",style: TextStyle(
                                                  // fontWeight: FontWeight.w600,
                                                  fontSize: FontSize.s10,
                                                  color: ColorManager.white,
                                                  decoration: TextDecoration.none,
                                                ),),
                                              ),
                                            ),)
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Kia Steve Anderson",
                                        textAlign: TextAlign.center,
                                        style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorManager.textBlack,),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child:  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Caseload : ",
                                        textAlign: TextAlign.start,
                                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                          fontWeight: FontWeight.w500,
                                          color: ColorManager.mediumgrey,),
                                      ),
                                      // SizedBox(width: 25,),
                                      Text(
                                        "24",
                                        textAlign: TextAlign.start,
                                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                                          fontWeight: FontWeight.w500,
                                          color: ColorManager.mediumgrey,),
                                      ),
                                    ],
                                  ),),
                                Expanded(
                                  //flex: 2,
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        "images/sm/sm_dashboard/ProhealthCalenderIcon.png",
                                        height: 25,width: 30,fit: BoxFit.fill,
                                      ),
                                      SizedBox(width: 20,),
                                      Image.asset(
                                        "images/sm/contact.png",
                                        height: 45,width: 55,fit: BoxFit.fill,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    width: 200,
                                    height: 55,
                                    child:Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          child:  ElevatedButton.icon(onPressed: ()async{
                                            await  showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return VendorSelectNoti(
                                                  message: 'Please Select A File',
                                                );
                                              },
                                            );
                                          },label: Text("Auto", style: TextStyle(
                                            fontSize: FontSize.s13,
                                            fontWeight: FontWeight.w600,
                                            color: ColorManager.white,
                                            decoration: TextDecoration.none,
                                          )),
                                            //icon: Icon(Icons.flash_auto,color:ColorManager.white ,size: 16,),
                                            icon: Image.asset("images/sm/auto.png",height: 30,width: 18,),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:  Color(0xFFB9DFEF),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12), // Round only the top-left corner
                                                  bottomLeft: Radius.circular(12), // Round only the bottom-left corner
                                                ),
                                                // side: BorderSide(
                                                //   color: ColorManager.bluebottom, // Border color
                                                //   width: 1,
                                                // ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 100,
                                          child:  ElevatedButton.icon(onPressed: (){
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AddErrorPopup(
                                                  message: 'File is too large!',
                                                );
                                              },
                                            );
                                          },label: Text("Manual", style: TextStyle(
                                            fontSize: FontSize.s13,
                                            fontWeight: FontWeight.w600,
                                            color: ColorManager.bluebottom,
                                            decoration: TextDecoration.none,
                                          )),
                                            //icon: Icon(Icons.swipe_rounded,color:ColorManager.bluebottom ,size: 16,),
                                            icon: Image.asset("images/sm/manual.png",height: 30,width: 18,),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(12), // Round only the top-left corner
                                                  bottomRight: Radius.circular(12), // Round only the bottom-left corner
                                                ),
                                                side: BorderSide(
                                                  color: ColorManager.bluebottom, // Border color
                                                  width: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],),
                          ),
                          Divider(color: ColorManager.dashDivider,height: 1,),
                          SizedBox(height: AppSize.s5),
                        ],
                      );
                    },
                  )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Text(
                            "View More",
                            textAlign: TextAlign.end,
                            style: EmDashViewMoreText.customTextStyle(context),
                          ),
                          SizedBox(width: AppSize.s5),
                          Icon(Icons.arrow_forward,color: ColorManager.blueprime,size: IconSize.I16,)
                        ],
                      ),
                    ),
                  ],),
              ),

            ],
          ),));
  }
}

///highest case load listview
class HighestCaseLoadListview extends StatefulWidget {
  const HighestCaseLoadListview({super.key});

  @override
  _HighestCaseLoadListviewState createState() =>
      _HighestCaseLoadListviewState();
}

class _HighestCaseLoadListviewState extends State<HighestCaseLoadListview> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  int totalValue = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                if (_currentPageIndex > 0) {
                  setState(() {
                    _currentPageIndex--;
                  });
                  _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: _currentPageIndex > 0
                    ? ColorManager.mediumgrey
                    : Colors.grey, // Disable icon if on the first page
                size: IconSize.I16,
              ),
            ),
          _currentPageIndex == 0
              ?  Text(
              "Clinician Name",
              style: NumberTExtFieldLegalDoc.customTextStyle(context),
            )
            : _currentPageIndex == 1
            ? Text(
            "Clinician Type",
            style: NumberTExtFieldLegalDoc.customTextStyle(context),
          )
            : Text(
            "Employee Type",
            style: NumberTExtFieldLegalDoc.customTextStyle(context),
          ),
            IconButton(
              onPressed: () {
                if (_currentPageIndex < 2) {
                  setState(() {
                    _currentPageIndex++;
                  });
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorManager.mediumgrey,
                size: IconSize.I16,
              ),
            ),
          ],
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: [
              _buildClinicianName(context), // Initial screen
              _buildClinicianType(context), // Next screen
              _buildEmployeeType(context), // Add more as needed
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:  _currentPageIndex == 2
              ? Offstage()
              : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "View More",
                      textAlign: TextAlign.end,
                      style: EmDashViewMoreText.customTextStyle(context),
                    ),
                    SizedBox(width: AppSize.s5),
                    Icon(Icons.arrow_forward,color: ColorManager.blueprime,size: IconSize.I16,)
                  ],
                ),
              ),
            ],),
        ),// Space between ListView and indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => _buildDot(index)),
        ),
        SizedBox(height: 20), // Space between indicators and bottom
      ],
    );
  }

  Widget _buildClinicianName(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (context, index) {
        //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
        // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
        // EmployeeDocumentModal employeedoc = paginatedData[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right:50,top: 10,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    //flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [SizedBox(
                            height:50,
                            child: CircleAvatar(
                              child:
                              Image.asset('images/1.png'),
                            ),
                          ),
                            Positioned(
                              left:22,
                              bottom :0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Color(0xFF527FB9),
                                ),
                                width: 19,
                                height: 15,
                                child: Center(
                                  child: Text("ST",style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: FontSize.s10,
                                    color: ColorManager.white,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ),)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Michel Jackson",
                          textAlign: TextAlign.start,
                          style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.mediumgrey,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "24",
                          textAlign: TextAlign.start,
                          style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.blueprime,),
                        ),
                      ],
                    ),),
                ],),
            ),
          ],
        );
      },
    );
  }
  Widget _buildClinicianType(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (context, index) {
        //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
        // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
        // EmployeeDocumentModal employeedoc = paginatedData[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right:50,top: 10,bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                       flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: Color(0xFFF6928A)

                              ),
                              width: 26,
                              height: 20,
                              child: Center(
                                child: Text("ST",style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.s10,
                                  color: ColorManager.white,
                                  decoration: TextDecoration.none,
                                ),),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "Physical Therapy",
                              textAlign: TextAlign.start,
                              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.mediumgrey,),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "24",
                              textAlign: TextAlign.start,
                              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.blueprime,),
                            ),
                          ],
                        ),),
                    ],),
                  SizedBox(height: 10,),
                  GradientProgressIndicator(
                    progress: totalValue / 100, // Pass your progress value here
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _buildEmployeeType(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (context, index) {
        //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
        // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
        // EmployeeDocumentModal employeedoc = paginatedData[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right:50,top: 10,bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Temporery",
                        textAlign: TextAlign.start,
                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.mediumgrey,),
                      ),
                      Text(
                        "30",
                        textAlign: TextAlign.start,
                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.blueprime,),
                      ),
                    ],),
                  SizedBox(height: 10,),
                  GradientProgressIndicator(
                    progress: totalValue / 100, // Pass your progress value here
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8, //_currentPageIndex == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPageIndex == index
            ? ColorManager.bluebottom // Active color
            : ColorManager.transparentColor, // Inactive color
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

///Most Missed visit
class MostMissedVisitsListview extends StatefulWidget {
  const MostMissedVisitsListview({super.key});

  @override
  State<MostMissedVisitsListview> createState() => _MostMissedVisitsListviewState();
}

class _MostMissedVisitsListviewState extends State<MostMissedVisitsListview> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;
  int totalValue = 50;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                if (_currentPageIndex > 0) {
                  setState(() {
                    _currentPageIndex--;
                  });
                  _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: _currentPageIndex > 0
                    ? ColorManager.mediumgrey
                    : Colors.grey, // Disable icon if on the first page
                size: IconSize.I16,
              ),
            ),
            _currentPageIndex == 0
                ?  Text(
              "Clinician Name",
              style: NumberTExtFieldLegalDoc.customTextStyle(context),
            )
                : _currentPageIndex == 1
                ? Text(
              "Clinician Type",
              style: NumberTExtFieldLegalDoc.customTextStyle(context),
            )
                : Text(
              "Employee Type",
              style: NumberTExtFieldLegalDoc.customTextStyle(context),
            ),
            IconButton(
              onPressed: () {
                if (_currentPageIndex < 2) {
                  setState(() {
                    _currentPageIndex++;
                  });
                  _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut);
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: ColorManager.mediumgrey,
                size: IconSize.I16,
              ),
            ),
          ],
        ),
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            children: [
              _buildClinicianNameMissed(context,), // Initial screen
              _buildClinicianTypeMissed(context,), // Next screen
              _buildEmployeeTypeMissed(context, ), // Add more as needed
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child:  _currentPageIndex == 2
              ? Offstage()
              : Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "View More",
                      textAlign: TextAlign.end,
                      style: EmDashViewMoreText.customTextStyle(context),
                    ),
                    SizedBox(width: AppSize.s5),
                    Icon(Icons.arrow_forward,color: ColorManager.blueprime,size: IconSize.I16,)
                  ],
                ),
              ),
            ],),
        ),// Space between ListView and indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => _buildDot(index)),
        ),
        SizedBox(height: 20), // Space between indicators and bottom
      ],
    );
  }

  Widget _buildClinicianNameMissed(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (context, index) {
        //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
        // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
        // EmployeeDocumentModal employeedoc = paginatedData[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right:50,top: 10,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    //flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [SizedBox(
                            height:50,
                            child: CircleAvatar(
                              child:
                              Image.asset('images/1.png'),
                            ),
                          ),
                            Positioned(
                              left:22,
                              bottom :0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Color(0xFFF6928A)
                                ),
                                width: 20,
                                height: 15,
                                child: Center(
                                  child: Text("OT",style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: FontSize.s10,
                                    color: ColorManager.white,
                                    decoration: TextDecoration.none,
                                  ),),
                                ),
                              ),)
                          ],
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Rose Galler",
                          textAlign: TextAlign.start,
                          style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                            fontWeight: FontWeight.w500,
                            color: ColorManager.mediumgrey,),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "25",
                          textAlign: TextAlign.start,
                          style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.blueprime,),
                        ),
                      ],
                    ),),
                ],),
            ),
          ],
        );
      },
    );
  }
  Widget _buildClinicianTypeMissed(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 15,
      itemBuilder: (context, index) {
        //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
        // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
        // EmployeeDocumentModal employeedoc = paginatedData[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right:50,top: 10,bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Color(0xFFF6928A)

                              ),
                              width: 26,
                              height: 20,
                              child: Center(
                                child: Text("LVN",style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.s10,
                                  color: ColorManager.white,
                                  decoration: TextDecoration.none,
                                ),),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Text(
                              "Occupational Therapy",
                              textAlign: TextAlign.start,
                              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                fontWeight: FontWeight.w500,
                                color: ColorManager.mediumgrey,),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "20",
                              textAlign: TextAlign.start,
                              style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                                fontWeight: FontWeight.w700,
                                color: ColorManager.blueprime,),
                            ),
                          ],
                        ),),
                    ],),
                  SizedBox(height: 10,),
                  GradientProgressIndicator(
                    progress: totalValue / 100, // Pass your progress value here
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
  Widget _buildEmployeeTypeMissed(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 3,
      itemBuilder: (context, index) {
        //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
        // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
        // EmployeeDocumentModal employeedoc = paginatedData[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0,right:50,top: 10,bottom: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Salaried",
                        textAlign: TextAlign.start,
                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                          fontWeight: FontWeight.w500,
                          color: ColorManager.mediumgrey,),
                      ),
                      Text(
                        "24",
                        textAlign: TextAlign.start,
                        style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                          fontWeight: FontWeight.w700,
                          color: ColorManager.blueprime,),
                      ),
                    ],),
                  SizedBox(height: 10,),
                  GradientProgressIndicator(
                    progress: totalValue / 100, // Pass your progress value here
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8, //_currentPageIndex == index ? 12 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPageIndex == index
            ? ColorManager.bluebottom // Active color
            : ColorManager.transparentColor, // Inactive color
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
