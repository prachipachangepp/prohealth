import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/widgets/dialogue_template.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';

class MissedVisitPopup extends StatelessWidget {
  const MissedVisitPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return DialogueTemplate(
        width: AppSize.s650,
        height: AppSize.s450,
        body: [
          Container(
            height: AppSize.s35,
            padding: EdgeInsets.only(left: 10,right: 10),
            decoration: BoxDecoration(
              color: ColorManager.lightBlue,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),),
              border: Border(top: BorderSide(color: ColorManager.blueBorder.withOpacity(0.1), width: 1),
                  bottom: BorderSide(color: ColorManager.blueBorder.withOpacity(0.1), width: 1),
                  left: BorderSide(color: ColorManager.blueBorder.withOpacity(0.1), width: 1),
                  right: BorderSide(color: ColorManager.blueBorder.withOpacity(0.1), width: 1)),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Patients Name',
                    textAlign: TextAlign.start,
                    style:
                        MenuContainerTextStylling.customTextStyle(context),
                  ),
                  Text(
                    'Address',
                    textAlign: TextAlign.end,
                    style: MenuContainerTextStylling.customTextStyle(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      'Visit Date',
                      textAlign: TextAlign.end,
                      style: MenuContainerTextStylling.customTextStyle(context),
                    ),
                  ),
                  Text(
                    'Clinician',
                    textAlign: TextAlign.start,
                    style: MenuContainerTextStylling.customTextStyle(context),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 280,
            child:  Expanded(
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
                            //flex:2,
                            child:  Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.location_on_outlined,color: ColorManager.bluebottom,size: IconSize.I18,),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    "Tufts International Center",
                                    textAlign: TextAlign.start,
                                    style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.mediumgrey,),
                                  ),
                                ),
                               // SizedBox(width: 10,),
                              ],
                            ),),
                          Expanded(
                            //flex: 2,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "03/02/2024",
                                  textAlign: TextAlign.end,
                                  style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.mediumgrey,),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
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
                                        height: 19,
                                        child: Center(
                                          child: Text("ST",style: TextStyle(
                                            // fontWeight: FontWeight.w600,
                                            // fontSize: FontSize.s13,
                                            color: ColorManager.white,
                                            decoration: TextDecoration.none,
                                          ),),
                                        ),
                                      ),)
                                  ],
                                ),
                                SizedBox(width: 5,),
                                Text(
                                  "John",
                                  textAlign: TextAlign.start,
                                  style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.textBlack,),
                                ),
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
                        ),
            ),)
        ],
        bottomButtons: Offstage(),
        title: "Missed Visit");
  }
}
