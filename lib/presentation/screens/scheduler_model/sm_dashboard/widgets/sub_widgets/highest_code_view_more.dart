import 'package:flutter/material.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../sm_dashboard_const.dart';

class HigestCaseViewMoreScreen extends StatelessWidget {
  final VoidCallback? onGoBackHigestCase;
  const HigestCaseViewMoreScreen({super.key, this.onGoBackHigestCase});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: AppSize.s25,),
                Icon(
                  Icons.arrow_back,
                  size: IconSize.I16,
                  color: ColorManager.mediumgrey,

                ),
                SizedBox(width: 5,),
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    if (onGoBackHigestCase != null) {
                      onGoBackHigestCase!(); // Trigger the callback to notify parent
                    }},
                  child: Text(
                    'Go Back',
                    style:TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              'Highest Case Loads (Clinician Name)',
              style:TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeight.w600,
                color: ColorManager.mediumgrey,
              ),
            ),
          ),
          Expanded(child: Container()),
        ],),
        SizedBox(height: AppSize.s40,),
        ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (context, index) {
                //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                // EmployeeDocumentModal employeedoc = paginatedData[index];
                return Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
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
                                    SizedBox(width: AppSize.s10,),
                                    Text(
                                      "James Smith",
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
                                      "14",
                                      textAlign: TextAlign.start,
                                      style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.blueprime,),
                                    ),
                                  ],
                                ),),
                            ],),
                          Divider(color: ColorManager.fGrey,)
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

///
class HigestCaseClinicianTypeViewScreen extends StatelessWidget {
  final VoidCallback? onGoBackClinicianType;
   HigestCaseClinicianTypeViewScreen({super.key, this.onGoBackClinicianType});

   int totalValue = 50;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: Row(
              children: [
                SizedBox(width: AppSize.s25,),
                Icon(
                  Icons.arrow_back,
                  size: IconSize.I16,
                  color: ColorManager.mediumgrey,

                ),
                SizedBox(width: AppSize.s5,),
                InkWell(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  onTap: () {
                    if (onGoBackClinicianType != null) {
                      onGoBackClinicianType!(); // Trigger the callback to notify parent
                    }},
                  child: Text(
                    'Go Back',
                    style:TextStyle(
                      fontSize: FontSize.s14,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              'Highest Case Loads (Clinician Type)',
              style:TextStyle(
                fontSize: FontSize.s16,
                fontWeight: FontWeight.w600,
                color: ColorManager.mediumgrey,
              ),
            ),
          ),
          Expanded(child: Container()),
        ],),
        SizedBox(height: AppSize.s40,),
        ScrollConfiguration(
          behavior: ScrollBehavior().copyWith(scrollbars: false),
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 15,
              itemBuilder: (context, index) {
                //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                // EmployeeDocumentModal employeedoc = paginatedData[index];
                return Row(
                  children: [
                    Expanded(child: Container()),
                    Expanded(
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
                                          color: Color(0xFFFEBD4D)


                                          ),
                                      width: AppSize.s28,
                                      height: AppSize.s20,
                                      child: Center(
                                        child: Text("OT",style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: FontSize.s10,
                                          color: ColorManager.white,
                                          decoration: TextDecoration.none,
                                        ),),
                                      ),
                                    ),
                                    SizedBox(width: AppSize.s15,),
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
                                      "24",
                                      textAlign: TextAlign.start,
                                      style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s14,
                                        fontWeight: FontWeight.w700,
                                        color: ColorManager.blueprime,),
                                    ),
                                  ],
                                ),),
                            ],),
                          SizedBox(height: AppSize.s10,),
                          GradientProgressIndicator(
                            progress: totalValue / 100, // Pass your progress value here
                          ),
                          SizedBox(height: AppSize.s15,),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
