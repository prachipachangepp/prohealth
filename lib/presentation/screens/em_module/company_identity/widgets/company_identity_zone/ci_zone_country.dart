import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../data/api_data/establishment_data/ci_manage_button/manage_zone_data.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';

class CIZoneCountry extends StatefulWidget {
  const CIZoneCountry({super.key});

  @override
  State<CIZoneCountry> createState() => _CIZoneCountryState();
}

class _CIZoneCountryState extends State<CIZoneCountry> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController countynameController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();
  TextEditingController mapController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  final StreamController<List<ManageZoneCounty>> _controller = StreamController<List<ManageZoneCounty>>();

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(60, (index) => 'Item ${index + 1}');
    // orgDocumentGet(context).then((data) {
    //   _controller.add(data);
    // }).catchError((error) {
    //   // Handle error
    // });
  }

    @override
  Widget build(BuildContext context) {
      List<String> currentPageItems = items.sublist(
        (currentPage - 1) * itemsPerPage,
        min(currentPage * itemsPerPage, items.length),
      );
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // CustomIconButtonConst(
        //   icon: Icons.add,
        //     text: AppStringEM.add, onPressed: (){
        //     showDialog(context: context, builder: (context){
        //       return CIZoneAddPopup(
        //           onSavePressed: (){},
        //         title1: AppStringEM.countyName,
        //         countynameController: countynameController,
        //         title2: AppStringEM.zipCode,
        //         zipcodeController: zipcodeController,
        //         title3: AppStringEM.map,
        //         mapController: mapController,
        //        title4:AppStringEM.landmark,
        //         landmarkController: landmarkController, );
        //     });
        // }),
        SizedBox(
          height: AppSize.s5,
        ),
        Container(
          height: AppSize.s30,
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  AppStringEM.zones,
                  style: AllHRTableHeading.customTextStyle(context)
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Text(AppStringEM.name,textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 45.0),
                  child: Text(AppStringEM.zipCode,
                      textAlign: TextAlign.start,
                      style:AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: Text(
                    AppStringEM.map,
                    style: AllHRTableHeading.customTextStyle(context)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                    AppStringEM.landmark,
                    style: AllHRTableHeading.customTextStyle(context)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    AppStringEM.actions,
                    style: AllHRTableHeading.customTextStyle(context)
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        Expanded(
          child:
          // StreamBuilder<List<ManageZoneCounty>>(
          //   stream: _controller.stream,
          //   builder: (context, snapshot) {
          //     print('1111111');
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(
          //           color: ColorManager.blueprime,
          //         ),
          //       );
          //     }
          //     if (snapshot.data!.isEmpty) {
          //       return Center(
          //         child: Text(
          //           AppString.dataNotFound,
          //           style: CustomTextStylesCommon.commonStyle(
          //             fontWeight: FontWeightManager.medium,
          //             fontSize: FontSize.s12,
          //             color: ColorManager.mediumgrey,
          //           ),
          //         ),
          //       );
          //     }
          //     if (snapshot.hasData) {
          //       return
          ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: currentPageItems.length,
              itemBuilder: (context, index) {
                int serialNumber =
                    index + 1 + (currentPage - 1) * itemsPerPage;
                String formattedSerialNumber =
                serialNumber.toString().padLeft(2, '0');
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: Container(
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                color: ColorManager.black.withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: AppSize.s56,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                   formattedSerialNumber,
                                  style: AllHRTableData.customTextStyle(context)
                                ),
                                // Text(''),
                                Text(
                                  "Santa Clara",textAlign:TextAlign.center,
                                  style: AllHRTableData.customTextStyle(context)
                                ),
                                Text(
                                  '94022,94023,94024,94025',
                                  style: AllHRTableData.customTextStyle(context)
                                ),
                                Text(
                                  'View map',
                                  style: GoogleFonts.firaSans(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.medium,
                                    color: ColorManager.mediumgrey,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text(
                                  'Statue of Liberty',
                                  style:AllHRTableData.customTextStyle(context)
                                ),
                                //  Text(''),
                                Row(
                                  children: [
                                    IconButton(onPressed: (){
                                      showDialog(context: context, builder: (context){
                                        return CIZoneAddPopup(
                                          onSavePressed: (){
                                          },
                                          title1: AppStringEM.countyName,
                                          countynameController: countynameController,
                                          title2: AppStringEM.zipCode,
                                          zipcodeController: zipcodeController,
                                          title3: AppStringEM.map,
                                          mapController: mapController,
                                          title4:AppStringEM.landmark,
                                          landmarkController: landmarkController, );
                                      });
                                    }, icon: Icon(Icons.edit_outlined,size:18,color: ColorManager.blueprime,)),
                                    IconButton(onPressed: (){
                                      showDialog(context: context, builder: (context) => DeletePopup(onCancel: (){
                                        Navigator.pop(context);
                                      }, onDelete: (){}));
                                    }, icon: Icon(Icons.delete_outline,size:18,color: ColorManager.faintOrange,)),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                );
              }),
          //;
//     }
//   return Offstage();
// },
// ),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        PaginationControlsWidget(
          currentPage: currentPage,
          items: items,
          itemsPerPage: itemsPerPage,
          onPreviousPagePressed: () {
            /// Handle previous page button press
            setState(() {
              currentPage = currentPage > 1 ? currentPage - 1 : 1;
            });
          },
          onPageNumberPressed: (pageNumber) {
            /// Handle page number tap
            setState(() {
              currentPage = pageNumber;
            });
          },
          onNextPagePressed: () {
            /// Handle next page button press
            setState(() {
              currentPage = currentPage < (items.length / itemsPerPage).ceil()
                  ? currentPage + 1
                  : (items.length / itemsPerPage).ceil();
            });
          },
        ),
      ],
    );
  }
}
