import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/licenses_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/profile_mnager.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/licenses_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/expired_license_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profile_clipoval_const.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../profile_bar/widget/profil_custom_widget.dart';

class ProfileBar extends StatefulWidget {
  const ProfileBar({super.key, this.searchByEmployeeIdProfileData});
  final SearchByEmployeeIdProfileData? searchByEmployeeIdProfileData;

  @override
  State<ProfileBar> createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {
  // @override
  // void initState() {
  //   super.initState();
  //   fetchData();
  // }
  @override
  Widget build(BuildContext context) {
    int currentPage = 1;
    int itemsPerPage = 30;
    return Row(
      children: [
        Material(
          elevation: 4,
          child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: AppSize.s50,
              decoration: BoxDecoration(
                color: ColorManager.greenF,
              ),
              child: FutureBuilder<ProfilePercentage>(
                  future: getPercentage(context, widget.searchByEmployeeIdProfileData!.employeeId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox();
                    }
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Profile\n${snapshot.data!.percentage}%",
                            style: ThemeManagerWhite.customTextStyle(context),
                          ),
                        ]);
                  })),
        ),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8)),
              color: ColorManager.whitebluecolor.withOpacity(0.25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.s10, vertical: AppSize.s15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: AppSize.s70,
                        height: AppSize.s70,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(Icons.person,color: ColorManager.white,size: AppSize.s50,),
                            // Image.network(searchByEmployeeIdProfileData!.imgurl,
                            //     height: AppSize.s50, width: AppSize.s50),
                            // you can replace
                            SizedBox(
                              height: AppSize.s53,
                              width: AppSize.s53,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    ColorManager.greenF),
                                strokeWidth: 3,
                                value: widget.searchByEmployeeIdProfileData!
                                    .profileScorePercentage,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        widget.searchByEmployeeIdProfileData!.status.capitalizeFirst!,
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      Text(
                        AppString.annualSkill,
                        style: ThemeManager.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///text john scott
                      Text(
                        "${widget.searchByEmployeeIdProfileData!.firstName.capitalizeFirst} ${widget.searchByEmployeeIdProfileData!.lastName.capitalizeFirst}",
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      SizedBox(
                        height: AppSize.s2,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 40,
                        width: MediaQuery.of(context).size.width / 10,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            backgroundColor:
                                ColorManager.faintOrange.withOpacity(0.9),
                            elevation: 4,
                          ),
                          onPressed: () {},
                          child: Text(
                            widget.searchByEmployeeIdProfileData!.employment.capitalizeFirst!,
                            style: ThemeManagerWhite.customTextStyle(context),
                          ),
                        ),
                      ),
                      Text(
                        widget.searchByEmployeeIdProfileData!.employeeType,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.saanJoes,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.address,
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      Text(widget.searchByEmployeeIdProfileData!.finalAddress,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.firaSans(
                            fontSize: AppSize.s10,
                            color: ColorManager.primary,
                            fontWeight: FontWeightManager.light,
                          )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: MyConstants.personalInfoTexts(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///text john scott
                      Text(
                        widget.searchByEmployeeIdProfileData!.dateOfBirth,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        widget.searchByEmployeeIdProfileData!.gender,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.star,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),

                      ///phone, comment
                      ProfileBarPhoneCmtConst(
                        phoneNo: widget.searchByEmployeeIdProfileData!.primaryPhoneNbr,
                      ),
                      ProfileBarPhoneCmtConst(
                        phoneNo:
                            widget.searchByEmployeeIdProfileData!.secondryPhoneNbr,
                      ),
                      ProfileBarPhoneCmtConst(
                        phoneNo: widget.searchByEmployeeIdProfileData!.workPhoneNbr,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: MyConstantsColumn.personalInfoTexts(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.searchByEmployeeIdProfileData!.workEmail,
                          style: ProfileBarConst.profileTextStyle(context)),
                      Text(widget.searchByEmployeeIdProfileData!.personalEmail,
                          style: ProfileBarConst.profileTextStyle(context)),
                      Row(
                        children: [
                          Text(
                            widget.searchByEmployeeIdProfileData!.zone,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          SizedBox(width: 10),
                          Container(
                            height: MediaQuery.of(context).size.height / 35,
                            width: MediaQuery.of(context).size.width / 16,
                            margin: EdgeInsets.only(right: AppSize.s40),
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(context: context, builder: (BuildContext context){
                                  return ExpiredLicensePopup(title: 'Zones', child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppPadding.p3,
                                      horizontal: AppPadding.p20,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        'Zn No.',
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          decoration: TextDecoration.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text('Name Of Zone',textAlign: TextAlign.start,
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white,
                                                            decoration: TextDecoration.none,
                                                          )),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Center(
                                                      child: Text('Action',textAlign: TextAlign.start,
                                                          style: GoogleFonts.firaSans(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700,
                                                            color: Colors.white,
                                                            decoration: TextDecoration.none,
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.height/1.6,
                                            child:
                                            ListView.builder(
                                                scrollDirection: Axis.vertical,
                                                itemCount: 10,
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
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                            decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius: BorderRadius.circular(4),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: const Color(0xff000000).withOpacity(0.25),
                                                                  spreadRadius: 0,
                                                                  blurRadius: 4,
                                                                  offset: const Offset(0, 2),
                                                                ),
                                                              ],
                                                            ),
                                                            height: 50,
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 15),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.spaceAround,
                                                                children: [
                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Text(
                                                                        formattedSerialNumber,
                                                                        // formattedSerialNumber,
                                                                        style: GoogleFonts.firaSans(
                                                                          fontSize: 10,
                                                                          fontWeight: FontWeight.w500,
                                                                          color: const Color(0xff686464),
                                                                          decoration: TextDecoration.none,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // Text(''),
                                                                  Expanded(
                                                                    child: Center(
                                                                      child: Text(
                                                                        'ProHealth San Jose',
                                                                        style: GoogleFonts.firaSans(
                                                                          fontSize: 10,
                                                                          fontWeight: FontWeight.w500,
                                                                          color: const Color(0xff686464),
                                                                          decoration: TextDecoration.none,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Center(
                                                                      child: BorderIconButton(
                                                                        iconData:
                                                                        Icons.remove_red_eye_outlined,
                                                                        buttonText:
                                                                        'View',
                                                                        onPressed:
                                                                            () async {
                                                                          const String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=36.778259, -119.417931";

                                                                          if (await canLaunchUrlString(googleMapsUrl)) {
                                                                            await launchUrlString(googleMapsUrl);
                                                                          } else {
                                                                            print('Could not open the map.');
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSize.s15,
                                    vertical: AppSize.s10),
                                backgroundColor: ColorManager.blueprime,
                                shadowColor: ColorManager.grey.withOpacity(0.3),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                AppString.viewzone,
                                style: GoogleFonts.firaSans(
                                    fontSize: FontSize.s10,
                                    fontWeight: FontWeightManager.regular,
                                    color: ColorManager.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: ColorManager.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.searchByEmployeeIdProfileData!.employment,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        widget.searchByEmployeeIdProfileData!.service,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.na,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.na,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(AppString.hideDate,
                              style: ProfileBarConstText.profileTextStyle(
                                  context)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          Text(AppString.datetime,
                              style: ProfileBarConstText.profileTextStyle(
                                  context)),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              'PTA',
                              style: ProfileBarConstText.profileTextStyle(
                                  context)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 70.0),
                            child: Text(
                                '1.2',
                                style: ProfileBarConstText.profileTextStyle(
                                    context)),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ///"Expired License"
                          ProfileBarClipConst(
                            onTap: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return ExpiredLicensePopup(title: 'Expired License', child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p3,
                                    horizontal: AppPadding.p20,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'Sr No.',
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white,
                                                        decoration: TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                                                Expanded(
                                                  child: Center(
                                                    child: Text('Name Of License',textAlign: TextAlign.start,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          decoration: TextDecoration.none,
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text('Date',textAlign: TextAlign.start,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          decoration: TextDecoration.none,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        FutureBuilder<Map<String, List<LicensesData>>>(
                                          future: getLicenseStatusWise(context, widget.searchByEmployeeIdProfileData!.employeeId!),
                                          builder: (context,snapshot) {
                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                              return Center(
                                                child: Padding(
                                                  padding:const EdgeInsets.symmetric(vertical: 150),
                                                  child: CircularProgressIndicator(
                                                    color: ColorManager.blueprime,
                                                  ),
                                                ),
                                              );
                                            }
                                            if (snapshot.data!['Expired']!.isEmpty) {
                                              return Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 150),
                                                    child: Text(
                                                      AppString.dataNotFound,
                                                      style: CustomTextStylesCommon.commonStyle(
                                                          fontWeight: FontWeightManager.medium,
                                                          fontSize: FontSize.s12,
                                                          color: ColorManager.mediumgrey),
                                                    ),
                                                  ));
                                            }
                                            if(snapshot.hasData){
                                              final expiredLicenses = snapshot.data!['Expired']!;
                                              //final inactiveLicenses = snapshot.data!['Inactive']!;
                                              return Container(
                                                height: MediaQuery.of(context).size.height/1.6,
                                                child:
                                                ListView.builder(
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: expiredLicenses.length,
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
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(4),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: const Color(0xff000000).withOpacity(0.25),
                                                                      spreadRadius: 0,
                                                                      blurRadius: 4,
                                                                      offset: const Offset(0, 2),
                                                                    ),
                                                                  ],
                                                                ),
                                                                height: 50,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.spaceAround,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Center(
                                                                          child: Text(
                                                                            formattedSerialNumber,
                                                                            // formattedSerialNumber,
                                                                            style: GoogleFonts.firaSans(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: const Color(0xff686464),
                                                                              decoration: TextDecoration.none,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      // Text(''),
                                                                      Expanded(
                                                                        child: Center(
                                                                          child: Text(
                                                                            expiredLicenses[index].org,
                                                                            style: GoogleFonts.firaSans(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: const Color(0xff686464),
                                                                              decoration: TextDecoration.none,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: Center(
                                                                          child: Text(
                                                                            expiredLicenses[index].issueDate,
                                                                            style: GoogleFonts.firaSans(
                                                                              fontSize: 10,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: const Color(0xff686464),
                                                                              decoration: TextDecoration.none,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                              );
                                            }
                                            return Offstage();

                                          }
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                              });
                            },
                              text: AppString.expiredlicense,
                              // containerColor: Colors.deepOrangeAccent,
                              containerColor: Color(0xffD16D6A),
                              textOval: AppString.zero),

                          SizedBox(
                              height: MediaQuery.of(context).size.height / 120),

                          ///"About To Expired License"
                          ProfileBarClipConst(
                            onTap: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return ExpiredLicensePopup(title: 'About To Expired License', child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p3,
                                    horizontal: AppPadding.p20,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'Sr No.',
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white,
                                                        decoration: TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                                                Expanded(
                                                  child: Center(
                                                    child: Text('Name Of License',textAlign: TextAlign.start,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          decoration: TextDecoration.none,
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text('Date',textAlign: TextAlign.start,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          decoration: TextDecoration.none,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        FutureBuilder<Map<String, List<LicensesData>>>(
                                            future: getLicenseStatusWise(context, widget.searchByEmployeeIdProfileData!.employeeId!),
                                            builder: (context,snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Center(
                                                  child: Padding(
                                                    padding:const EdgeInsets.symmetric(vertical: 150),
                                                    child: CircularProgressIndicator(
                                                      color: ColorManager.blueprime,
                                                    ),
                                                  ),
                                                );
                                              }
                                              if (snapshot.data!['About to Expire']!.isEmpty) {
                                                return Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 150),
                                                      child: Text(
                                                        AppString.dataNotFound,
                                                        style: CustomTextStylesCommon.commonStyle(
                                                            fontWeight: FontWeightManager.medium,
                                                            fontSize: FontSize.s12,
                                                            color: ColorManager.mediumgrey),
                                                      ),
                                                    ));
                                              }
                                              if(snapshot.hasData){
                                                final aboutToExpiredLicenses = snapshot.data!['About to Expire']!;
                                                //final inactiveLicenses = snapshot.data!['Inactive']!;
                                                return Container(
                                                  height: MediaQuery.of(context).size.height/1.6,
                                                  child:
                                                  ListView.builder(
                                                      scrollDirection: Axis.vertical,
                                                      itemCount: aboutToExpiredLicenses.length,
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
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(4),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: const Color(0xff000000).withOpacity(0.25),
                                                                        spreadRadius: 0,
                                                                        blurRadius: 4,
                                                                        offset: const Offset(0, 2),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  height: 50,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                              formattedSerialNumber,
                                                                              // formattedSerialNumber,
                                                                              style: GoogleFonts.firaSans(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: const Color(0xff686464),
                                                                                decoration: TextDecoration.none,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // Text(''),
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                              aboutToExpiredLicenses[index].org,
                                                                              style: GoogleFonts.firaSans(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: const Color(0xff686464),
                                                                                decoration: TextDecoration.none,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                              aboutToExpiredLicenses[index].issueDate,
                                                                              style: GoogleFonts.firaSans(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: const Color(0xff686464),
                                                                                decoration: TextDecoration.none,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                );
                                              }
                                              return Offstage();

                                            }
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                              });
                            },
                              text: AppString.abouttoexpire,
                              // containerColor: Colors.orange,
                              containerColor: Color(0xffFEBD4D),
                              textOval: AppString.two),

                          SizedBox(
                              height: MediaQuery.of(context).size.height / 120),

                          ///"Up To Date License"
                          ProfileBarClipConst(
                            onTap: (){
                              showDialog(context: context, builder: (BuildContext context){
                                return ExpiredLicensePopup(title: 'Up To Date License', child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: AppPadding.p3,
                                    horizontal: AppPadding.p20,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: Center(
                                                    child: Text(
                                                      'Sr No.',
                                                      style: GoogleFonts.firaSans(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w700,
                                                        color: Colors.white,
                                                        decoration: TextDecoration.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                                                Expanded(
                                                  child: Center(
                                                    child: Text('Name Of License',textAlign: TextAlign.start,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          decoration: TextDecoration.none,
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Text('Date',textAlign: TextAlign.start,
                                                        style: GoogleFonts.firaSans(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w700,
                                                          color: Colors.white,
                                                          decoration: TextDecoration.none,
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        FutureBuilder<Map<String, List<LicensesData>>>(
                                            future: getLicenseStatusWise(context, widget.searchByEmployeeIdProfileData!.employeeId!),
                                            builder: (context,snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Center(
                                                  child: Padding(
                                                    padding:const EdgeInsets.symmetric(vertical: 150),
                                                    child: CircularProgressIndicator(
                                                      color: ColorManager.blueprime,
                                                    ),
                                                  ),
                                                );
                                              }
                                              if (snapshot.data!['Upto date']!.isEmpty) {
                                                return Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(vertical: 150),
                                                      child: Text(
                                                        AppString.dataNotFound,
                                                        style: CustomTextStylesCommon.commonStyle(
                                                            fontWeight: FontWeightManager.medium,
                                                            fontSize: FontSize.s12,
                                                            color: ColorManager.mediumgrey),
                                                      ),
                                                    ));
                                              }
                                              if(snapshot.hasData){
                                                final upToDateLicenses = snapshot.data!['Upto date']!;
                                                //final inactiveLicenses = snapshot.data!['Inactive']!;
                                                return Container(
                                                  height: MediaQuery.of(context).size.height/1.6,
                                                  child:
                                                  ListView.builder(
                                                      scrollDirection: Axis.vertical,
                                                      itemCount: upToDateLicenses.length,
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
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(4),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: const Color(0xff000000).withOpacity(0.25),
                                                                        spreadRadius: 0,
                                                                        blurRadius: 4,
                                                                        offset: const Offset(0, 2),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  height: 50,
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment.spaceAround,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                              formattedSerialNumber,
                                                                              // formattedSerialNumber,
                                                                              style: GoogleFonts.firaSans(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: const Color(0xff686464),
                                                                                decoration: TextDecoration.none,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        // Text(''),
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                              upToDateLicenses[index].org,
                                                                              style: GoogleFonts.firaSans(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: const Color(0xff686464),
                                                                                decoration: TextDecoration.none,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                              upToDateLicenses[index].issueDate,
                                                                              style: GoogleFonts.firaSans(
                                                                                fontSize: 10,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: const Color(0xff686464),
                                                                                decoration: TextDecoration.none,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                );
                                              }
                                              return Offstage();

                                            }
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                              });
                            },
                              text: AppString.uptodate,
                              // containerColor: Colors.lightGreen,
                              containerColor: Color(0xffB4DB4C),
                              textOval: AppString.four),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
