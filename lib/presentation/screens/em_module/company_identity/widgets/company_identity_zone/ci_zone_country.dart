import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_zone/widgets/zone_widgets_constants.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';

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
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(60, (index) => 'Item ${index + 1}');
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
        CustomIconButtonConst(
          icon: Icons.add,
            text: AppStringEM.add, onPressed: (){
            showDialog(context: context, builder: (context){
              return CIZoneAddPopup(
                  onSavePressed: (){},
                title1: AppStringEM.countyName,
                countynameController: countynameController,
                title2: AppStringEM.zipCode,
                zipcodeController: zipcodeController,
                title3: AppStringEM.map,
                mapController: mapController,
               title4:AppStringEM.landmark,
                landmarkController: landmarkController, );
            });
        }),
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
                Text(AppStringEM.name,textAlign: TextAlign.start,
                    style: AllHRTableHeading.customTextStyle(context)),
                Text(AppStringEM.zipCode,
                    textAlign: TextAlign.start,
                    style:AllHRTableHeading.customTextStyle(context)),
                Text(
                  AppStringEM.map,
                  style: AllHRTableHeading.customTextStyle(context)
                ),
                Text(
                  AppStringEM.landmark,
                  style: AllHRTableHeading.customTextStyle(context)
                ),
                Text(
                  AppStringEM.actions,
                  style: AllHRTableHeading.customTextStyle(context)
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

                                          onSavePressed: (){},
                                          title1: AppStringEM.countyName,
                                          countynameController: countynameController,
                                          title2: AppStringEM.zipCode,
                                          zipcodeController: zipcodeController,
                                          title3: AppStringEM.map,
                                          mapController: mapController,
                                          title4:AppStringEM.landmark,
                                          landmarkController: landmarkController, );
                                      });
                                    }, icon: Icon(Icons.edit_outlined,color: ColorManager.mediumgrey,)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,color: ColorManager.faintOrange,)),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ),
                  ],
                );
              }),
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        Container(
          height: AppPadding.p30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: AppSize.s20,
                height: AppSize.s20,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6.39),
                  border: Border.all(
                    color: ColorManager.grey,
                    width: 0.79,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(bottom: 1.5),
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      currentPage = currentPage > 1 ? currentPage - 1 : 1;
                    });
                  },
                  color: ColorManager.black,
                  iconSize: 20,
                ),
              ),
              SizedBox(width: AppSize.s3),
              for (var i = 1; i <= (items.length / itemsPerPage).ceil(); i++)
                if (i == 1 ||
                    i == currentPage ||
                    i == (items.length / itemsPerPage).ceil())
                  InkWell(
                    onTap: () {
                      setState(() {
                        currentPage = i;
                      });
                    },
                    child: Container(
                      width: AppSize.s20,
                      height: AppSize.s20,
                      margin: EdgeInsets.symmetric(horizontal: AppMargin.m5,),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: currentPage == i
                              ? ColorManager.blueprime
                              : ColorManager.grey,
                          width: currentPage == i ? 2.0 : 1.0,
                        ),
                        color: currentPage == i
                            ? ColorManager.blueprime
                            : Colors.transparent,
                        // border: Border.all(
                        //   color: currentPage == i
                        //       ? Colors.blue
                        //       : Colors.transparent,
                        // ),
                      ),
                      child: Text(
                        '$i',
                        style: TextStyle(
                          color: currentPage == i ? Colors.white : Colors.grey,
                          fontWeight: FontWeightManager.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  )
                else if (i == currentPage - 1 || i == currentPage + 1)
                  Text(
                    '...',
                    style: TextStyle(
                      color: ColorManager.black,
                      fontWeight: FontWeightManager.bold,
                      fontSize: 12,
                    ),
                  ),
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.79,
                  ),
                ),
                child: IconButton(
                  padding: EdgeInsets.only(bottom: 2),
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      currentPage =
                      currentPage < (items.length / itemsPerPage).ceil()
                          ? currentPage + 1
                          : (items.length / itemsPerPage).ceil();
                    });
                  },
                  color: ColorManager.black,
                  iconSize: 20,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
