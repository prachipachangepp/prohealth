import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/common_resources/common_theme_const.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
import 'package:prohealth/app/resources/provider/navigation_provider.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/licenses_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/profile_mnager.dart';
import 'package:prohealth/app/services/base64/base64_image.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import 'package:prohealth/data/api_data/hr_module_data/manage/licenses_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/expired_license_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profile_clipoval_const.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/profilebar_editor.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../profile_bar/widget/profil_custom_widget.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


 typedef EditCallback = void Function();

class ProfileBar extends StatelessWidget {
  const ProfileBar({
    super.key, this.searchByEmployeeIdProfileData,
    required this.onEditPressed,});
  final SearchByEmployeeIdProfileData? searchByEmployeeIdProfileData;
  final VoidCallback onEditPressed;

  // int expiredCount = 0;


  // String? sSNNBR;
  @override
  Widget build(BuildContext context) {
    var hexColor;

    final profileState = Provider.of<HrManageProvider>(context, listen: false);
    hexColor = searchByEmployeeIdProfileData?.color.replaceAll("#", "");
    profileState.fetchLicenseData(context, searchByEmployeeIdProfileData!.employeeId!);
    profileState.updateAddress(searchByEmployeeIdProfileData!.finalAddress);
    profileState.updateSummery(searchByEmployeeIdProfileData!.summary);
    profileState.maskString(searchByEmployeeIdProfileData!.SSNNbr, 4);
    if (searchByEmployeeIdProfileData?.dateofHire != null) {
      profileState.calculateHireDateTimeStamp(searchByEmployeeIdProfileData!.dateofHire);
    }
    if (searchByEmployeeIdProfileData?.dateOfBirth != null) {
      profileState.calculateAge(searchByEmployeeIdProfileData!.dateOfBirth);
    }
    int currentPage = 1;
    int itemsPerPage = 30;
    return Container(
      color: ColorManager.whitebluecolor.withOpacity(0.25),
      width: MediaQuery.of(context).size.width / 1,
      // width: double.maxFinite,
      //  margin: EdgeInsets.only(right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Material(
              elevation: 4,
              child: FutureBuilder<ProfilePercentage>(
                  future: getPercentage(context,
                      searchByEmployeeIdProfileData!.employeeId!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(width: AppSize.s70);
                    }
                    if(snapshot.hasData){
                      double percentage = double.parse(snapshot.data!.percentage);
                      double maxHeight = 187; // Maximum height in pixels for 100%
                      double containerHeight = (percentage / 100) * maxHeight;
                      Color containerColor;
                      if (percentage <= 30) {
                        containerColor = Colors.red;
                      } else if (percentage <= 60) {
                        containerColor = Colors.yellow;
                      } else {
                        containerColor = ColorManager.greenF;
                      }
                      return Container(
                          height: containerHeight,
                          width: AppSize.s70,
                          decoration: BoxDecoration(
                            color: containerColor,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Profile\n${snapshot.data!.percentage}%",
                                  style: ThemeManagerWhite.customTextStyle(context),
                                ),
                              ]),
                      );
                    }
                    else{
                      return SizedBox();
                    }
                  })
            ),
            Flexible(
              child: Material(
                elevation: 4,
                // borderRadius: BorderRadius.only(
                //     bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
                child: Container(
                  height: MediaQuery.of(context).size.height / 4,
                 // width:  double.maxFinite,
                 // width: MediaQuery.of(context).size.width/1.049,
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //     bottomRight: Radius.circular(8),
                    //     topRight: Radius.circular(8)),
                    color: ColorManager.whitebluecolor.withOpacity(0.25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ///image
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 70,
                            width: 70,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Circular avatar for the image or icon
                                ClipOval(
                                  child: searchByEmployeeIdProfileData!.imgurl == 'imgurl' ||
                                      searchByEmployeeIdProfileData!.imgurl == null
                                      ? CircleAvatar(radius: 60,backgroundColor: ColorManager.faintGrey,child: Image.asset("images/profilepic.png"),)
                                      : CachedNetworkImage(
                                    imageUrl: searchByEmployeeIdProfileData!.imgurl,
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>    CircleAvatar(child: Image.asset("images/profilepic.png"),),
                                    fit: BoxFit.cover, // Ensure the image fits inside the circle
                                    height: 67, // Adjust image height for proper fit
                                    width: 67, // Adjust image width for proper fit
                                  ),
                                ),
                                // Circular progress indicator around the image
                                SizedBox(
                                  height: AppSize.s70,
                                  width: AppSize.s70,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(ColorManager.greenF),
                                    strokeWidth: 3,
                                    value: searchByEmployeeIdProfileData!.profileScorePercentage,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        //  SizedBox(height: 15,),
                          searchByEmployeeIdProfileData!.active ? Text(
                            "Active",
                            style: ThemeManagerBlack.customTextStyle(context),
                          ):Text(
                            "Inactive",
                            style: ThemeManagerBlack.customTextStyle(context),
                          ),
                         // SizedBox(height: 15,),
                          FutureBuilder<ProfilePercentage>(
                              future: getPercentage(
                                  context,
                                  searchByEmployeeIdProfileData!.employeeId!),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return SizedBox();
                                }
                                return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Annual Skills 0%",
                                        style:
                                        ProfileBarTextBoldStyle.customEditTextStyle(),
                                      ),
                                    ]);
                              })
                        ],
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      /////////////////////////////////////////////////////////////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///text john scott
                                Row(
                                  children: [
                                    Text(
                                      "${searchByEmployeeIdProfileData!.firstName.capitalizeFirst}"
                                          " ${searchByEmployeeIdProfileData!.lastName.capitalizeFirst}",
                                      style: ThemeManagerBlack.customTextStyle(context),
                                    ),
                                    SizedBox(width: 15,),
                                    InkWell(
                                      onTap: onEditPressed,
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        child: Icon(Icons.edit_outlined, size: 14, color: IconColorManager.bluebottom,)),
                                  ],
                                ),
                                Container(
                                 // height: MediaQuery.of(context).size.height / 41,
                                  width: MediaQuery.of(context).size.width / 10,
                                  decoration: BoxDecoration(color: Color(int.parse("0xFF$hexColor"))),
                                   child: Center(
                                     child: Text(
                                           searchByEmployeeIdProfileData!.employeeType.capitalizeFirst!,
                                       style: TextStyle(
                                         fontSize: 12,
                                         color: profileState.isDarkColor(Color(int.parse('0xFF$hexColor')))?ColorManager.white:ColorManager.black,
                                         fontWeight: FontWeight.w600,
                                       ),
                                     ),
                                   ),
                                ),

                                Row(
                                  children: [
                                    Text(
                                      'Employment Type :',
                                      style: ThemeManagerDark.customTextStyle(context),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      searchByEmployeeIdProfileData!.employment[0].toUpperCase() +
                                          searchByEmployeeIdProfileData!.employment.substring(1),
                                      style: ProfileBarTextBoldStyle.customEditTextStyle(),
                                    ),
                                  ],
                                ),

                                Text(
                                  searchByEmployeeIdProfileData!.zone,
                                  style: ProfileBarTextBoldStyle.customEditTextStyle(),
                                ),
                                Text(
                                  AppString.address,
                                  style: ThemeManagerDark.customTextStyle(context),
                                ),

                                MouseRegion(
                                  onEnter: (event) => profileState.showOverlayAddress(
                                      context, event.position,searchByEmployeeIdProfileData!.finalAddress),
                                  onExit: (_) => profileState.removeOverlayAddress(),
                                  child: Text(
                                      profileState.trimmedAddress,
                                      textAlign: TextAlign.start,
                                      style:
                                      ThemeManagerAddressPB.customTextStyle(
                                          context)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      /////////////////////////////////////////////////////////////////////////////////////////////
                    //  SizedBox(width: MediaQuery.of(context).size.width/50),
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: MyConstants.personalInfoTexts(context),
                          ),
                         // SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 3.0,left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ///text john scott
                                Text(
                                  "${searchByEmployeeIdProfileData!.dateOfBirth} (${profileState.dateOfBirthStamp ?? 'N/A'})",
                                  style: ProfileBarTextBoldStyle.customEditTextStyle(),
                                ),

                                Text(
                                  searchByEmployeeIdProfileData!.gender,
                                  style: ProfileBarTextBoldStyle.customEditTextStyle(),
                                ),
                                Text(
                                  profileState.maskedString,
                                  style: ProfileBarTextBoldStyle.customEditTextStyle(),
                                ),

                                ///phone, comment
                                ProfileBarPhoneCmtConst(
                                  phoneNo : searchByEmployeeIdProfileData!.primaryPhoneNbr,
                                ),

                                ProfileBarPhoneCmtConst(
                                  phoneNo : searchByEmployeeIdProfileData!.secondryPhoneNbr,
                                ),

                                ProfileBarPhoneCmtConst(
                                  phoneNo : searchByEmployeeIdProfileData!.workPhoneNbr,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    //  SizedBox(width: MediaQuery.of(context).size.width/50),
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: MyConstantsColumn.personalInfoTexts(context),
                            ),
                          ),
                          //SizedBox(width: 20),
                          Padding(
                            padding: const EdgeInsets.only(top: 4,left: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: Text(
                                    searchByEmployeeIdProfileData!.personalEmail ?? 'No email provided',
                                    style: ProfileBarConst.profileTextStyle(context),
                                  ),
                                  onTap: () async {
                                    String? email = searchByEmployeeIdProfileData!.personalEmail;
                                    if (email != null && email.isNotEmpty) {
                                      // Create a mailto Uri with the email address
                                      final Uri emailUri = Uri(
                                        scheme: 'mailto',
                                        path: email,
                                        queryParameters: {
                                          'subject': 'Hello!',
                                          'body': 'I would like to reach out to you.',
                                        },
                                      );

                                      // Launch the email client
                                      if (await canLaunchUrl(emailUri)) {
                                        await launchUrl(emailUri);
                                      } else {
                                        print('Could not launch $emailUri');
                                      }
                                    }
                                  },
                                ),

                                InkWell(
                                  splashColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap:() async {
                                    String? email = searchByEmployeeIdProfileData!.workEmail;

                                    if (email != null && email.isNotEmpty) {
                                      // Create a mailto Uri with the email address
                                      final Uri emailUri = Uri(
                                        scheme: 'mailto',
                                        path: email,
                                        queryParameters: {
                                          'subject': 'Hello!',
                                          'body': 'I would like to reach out to you.',
                                        },
                                      );

                                      // Launch the email client
                                      if (await canLaunchUrl(emailUri)) {
                                        await launchUrl(emailUri);
                                      } else {
                                        print('Could not launch $emailUri');
                                      }
                                    }
                                  },
                                  child: Text(
                                      searchByEmployeeIdProfileData!.workEmail,
                                      style: ProfileBarConst.profileTextStyle(context)),
                                ),

                                Text(
                                  searchByEmployeeIdProfileData!.expertise,
                                  style: ProfileBarTextBoldStyle.customEditTextStyle(),
                                ),
                                Text(
                                  searchByEmployeeIdProfileData!.service,
                                  style: ProfileBarTextBoldStyle.customEditTextStyle(),
                                ),
                                Text(
                                  searchByEmployeeIdProfileData!.regOfficId,
                                  style: ProfileBarTextBoldStyle.customEditTextStyle(),
                                ),
                                MouseRegion(
                                  onEnter: (event) =>
                                      profileState.showSummeryOverlay(context, event.position,searchByEmployeeIdProfileData!.summary),
                                  onExit: (_) => profileState.removeSummeryOverlay(),
                                  child: Text(
                                    profileState.trimmedSummery,
                                    style: ProfileBarTextBoldStyle
                                        .customEditTextStyle(),
                                  ),
                                ),
                                // Text(""),
                              ],
                            ),
                          ),
                        ],
                      ),
                     // SizedBox(width: MediaQuery.of(context).size.width/50,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(AppString.hideDate,
                                          style: ThemeManagerDark.customTextStyle(context)
                                      ),
                                      SizedBox(height: 10,),
                                      Text('PTA :',
                                          style: ThemeManagerDark.customTextStyle(context)),
                                    ],
                                  ),
                              //   SizedBox(width: 20),
                                 // SizedBox(width: MediaQuery.of(context).size.width/50,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${searchByEmployeeIdProfileData!.dateofHire} (${profileState.hireDateTimeStamp ?? ''})",
                                            style: ProfileBarTextBoldStyle.customEditTextStyle(),),
                                        SizedBox(height: 10,),
                                        Text('1.2', style: ProfileBarTextBoldStyle.customEditTextStyle(),),
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                          SizedBox(height: 30,),
                          Flexible(
                            child: Column(
                              children: [
                                StatefulBuilder(builder: (BuildContext context,
                                    void Function(void Function()) setState) {
                                  return  StreamBuilder<Map<String, int>>(
                                  stream: profileState.licenseStream,
                                  builder: (BuildContext context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return SizedBox(height: 1, width: 1);
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(bottom: 5.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          ///"Expired License"
                                          ProfileBarClipConst(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return ExpiredLicensePopup(
                                                        title: 'Expired License',
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.symmetric(
                                                            vertical: AppPadding.p3,
                                                            horizontal: AppPadding.p20,
                                                          ),
                                                          child: SingleChildScrollView(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                              children: [
                                                                Container(
                                                                  height: 30,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.grey,
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(12),
                                                                  ),
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal: 15),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                                'Sr No.',
                                                                                style:ProfileBarNameLicenseStyle.customEditTextStyle()
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                                'Name Of License',
                                                                                textAlign:
                                                                                TextAlign
                                                                                    .start,
                                                                                style:ProfileBarNameLicenseStyle.customEditTextStyle()),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Center(
                                                                            child: Text(
                                                                                'Date',
                                                                                textAlign:
                                                                                TextAlign
                                                                                    .start,
                                                                                style:ProfileBarNameLicenseStyle.customEditTextStyle()),
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
                                                                    future: getLicenseStatusWise(context, searchByEmployeeIdProfileData!.employeeId!),
                                                                    builder: (context, snapshot) {
                                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                                        return Center(
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 150),
                                                                            child: CircularProgressIndicator(
                                                                              color: ColorManager.blueprime,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }
                                                                      if (snapshot.data!['Expired']!.isEmpty) {
                                                                        return Center(
                                                                            child: Padding(padding:
                                                                              const EdgeInsets.symmetric(vertical: 150),
                                                                              child: Text(NoDataMessage.noexpiredlicense,
                                                                                style: AllNoDataAvailable.customTextStyle(context),
                                                                              ),
                                                                            ));
                                                                      }
                                                                      if (snapshot.hasData) {
                                                                        final expiredLicenses = snapshot.data!['Expired']!;
                                                                        //final inactiveLicenses = snapshot.data!['Inactive']!;
                                                                        return Container(
                                                                          height: MediaQuery.of(context).size.height / 2,
                                                                          child: ScrollConfiguration(
                                                                            behavior:  ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                            child: ListView.builder(scrollDirection: Axis.vertical,
                                                                                itemCount: expiredLicenses.length,
                                                                                itemBuilder: (context, index) {
                                                                                  //profileState.expiredCount = expiredLicenses.length;
                                                                                  print("Expired count :: ${profileState.expiredCount}");
                                                                                  int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                                                                                  String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                                                                                  return Column(
                                                                                    crossAxisAlignment:
                                                                                    CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      // SizedBox(height: 5),
                                                                                      Padding(
                                                                                        padding: const EdgeInsets.all(5),
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
                                                                                              padding: const EdgeInsets.only(left: 20,right: 20),
                                                                                              child: Row(
                                                                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                children: [
                                                                                                  Expanded(
                                                                                                    child: Center(
                                                                                                      child: Text(
                                                                                                          formattedSerialNumber,
                                                                                                          // formattedSerialNumber,
                                                                                                          style: AboutExpiredLStyle .customEditTextStyle()
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  // Text(''),
                                                                                                  Expanded(
                                                                                                    child: Center(
                                                                                                      child: Text(
                                                                                                          expiredLicenses[index].licenseure,
                                                                                                          style: AboutExpiredLStyle.customEditTextStyle()
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    child: Center(
                                                                                                      child: Text(
                                                                                                          expiredLicenses[index].expDate,
                                                                                                          style: AboutExpiredLStyle.customEditTextStyle()
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
                                                                        );
                                                                      }
                                                                      return Offstage();
                                                                    }),
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                                  });
                                            },
                                            text: AppString.expiredlicense,
                                            // containerColor: Colors.deepOrangeAccent,
                                            containerColor: Color(0xffD16D6A),
                                            textOval: profileState.expiredCount.toString(),
                                          ),
                                          SizedBox(
                                              height:
                                              MediaQuery.of(context).size.height / 120),

                                          ///"About To Expired License"
                                          ProfileBarClipConst(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return ExpiredLicensePopup(
                                                          title: 'About To Expired License',
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: AppPadding.p3,
                                                              horizontal: AppPadding.p20,
                                                            ),
                                                            child: SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                                children: [
                                                                  Container(
                                                                    height: 30,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors.grey,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(12),
                                                                    ),
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                          15),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Center(
                                                                              child: Text(
                                                                                  'Sr No.',
                                                                                  style:ProfileBarNameLicenseStyle.customEditTextStyle()
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                                                                          Expanded(
                                                                            child: Center(
                                                                              child: Text(
                                                                                  'Name Of License',
                                                                                  textAlign:
                                                                                  TextAlign
                                                                                      .start,
                                                                                  style: ProfileBarNameLicenseStyle.customEditTextStyle()),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Center(
                                                                              child: Text(
                                                                                  'Date',
                                                                                  textAlign:
                                                                                  TextAlign
                                                                                      .start,
                                                                                  style: ProfileBarNameLicenseStyle.customEditTextStyle()),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  FutureBuilder<
                                                                      Map<
                                                                          String,
                                                                          List<
                                                                              LicensesData>>>(
                                                                      future: getLicenseStatusWise(
                                                                          context,
                                                                          searchByEmployeeIdProfileData!
                                                                              .employeeId!),
                                                                      builder: (context,
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .connectionState ==
                                                                            ConnectionState
                                                                                .waiting) {
                                                                          return Center(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets
                                                                                  .symmetric(
                                                                                  vertical:
                                                                                  150),
                                                                              child:
                                                                              CircularProgressIndicator(
                                                                                color: ColorManager
                                                                                    .blueprime,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        if (snapshot
                                                                            .data![
                                                                        'About to Expire']!
                                                                            .isEmpty) {
                                                                          return Center(
                                                                              child:
                                                                              Padding(
                                                                                padding: const EdgeInsets
                                                                                    .symmetric(
                                                                                    vertical:
                                                                                    150),
                                                                                child: Text(NoDataMessage.noabouttoexpired,
                                                                                  style: AllNoDataAvailable.customTextStyle(context),

                                                                                ),
                                                                              ));
                                                                        }
                                                                        if (snapshot.hasData) {
                                                                          final aboutToExpiredLicenses =
                                                                          snapshot.data![
                                                                          'About to Expire']!;
                                                                          //final inactiveLicenses = snapshot.data!['Inactive']!;
                                                                          return Container(
                                                                            height: MediaQuery.of(
                                                                                context)
                                                                                .size
                                                                                .height /
                                                                                2,
                                                                            child: ScrollConfiguration(
                                                                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                              child: ListView
                                                                                  .builder(
                                                                                  scrollDirection:
                                                                                  Axis
                                                                                      .vertical,
                                                                                  itemCount:
                                                                                  aboutToExpiredLicenses
                                                                                      .length,
                                                                                  itemBuilder:
                                                                                      (context,
                                                                                      index) {
                                                                                    int serialNumber = index +
                                                                                        1 +
                                                                                        (currentPage - 1) * itemsPerPage;
                                                                                    String
                                                                                    formattedSerialNumber =
                                                                                    serialNumber.toString().padLeft(2, '0');
                                                                                    return Column(
                                                                                      crossAxisAlignment:
                                                                                      CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        // SizedBox(height: 5),
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(5.0),
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
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                            formattedSerialNumber,
                                                                                                            // formattedSerialNumber,
                                                                                                            style:AboutExpiredLStyle.customEditTextStyle()
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    // Text(''),
                                                                                                    Expanded(
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                            aboutToExpiredLicenses[index].licenseure,
                                                                                                            style: AboutExpiredLStyle.customEditTextStyle()
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                            aboutToExpiredLicenses[index].expDate,
                                                                                                            style: AboutExpiredLStyle.customEditTextStyle()
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
                                                                          );
                                                                        }
                                                                        return Offstage();
                                                                      }),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    });
                                              },
                                              text: AppString.abouttoexpire,
                                              // containerColor: Colors.orange,
                                              containerColor: Color(0xffFEBD4D),
                                              textOval:profileState.aboutToCount.toString()),
                                          SizedBox(
                                              height:
                                              MediaQuery.of(context).size.height / 120),

                                          ///"Up To Date License"
                                          ProfileBarClipConst(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return ExpiredLicensePopup(
                                                          title: 'Up To Date License',
                                                          child: Padding(
                                                            padding:
                                                            const EdgeInsets.symmetric(
                                                              vertical: AppPadding.p3,
                                                              horizontal: AppPadding.p20,
                                                            ),
                                                            child: SingleChildScrollView(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                                children: [
                                                                  Container(
                                                                    height: 30,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: Colors.grey,
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(12),
                                                                    ),
                                                                    child: Padding(
                                                                      padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                          15),
                                                                      child: Row(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceAround,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Center(
                                                                              child: Text(
                                                                                  'Sr No.',
                                                                                  style: ProfileBarNameLicenseStyle.customEditTextStyle()
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                                                                          Expanded(
                                                                            child: Center(
                                                                              child: Text(
                                                                                  'Name Of License',
                                                                                  textAlign:
                                                                                  TextAlign
                                                                                      .start,
                                                                                  style: ProfileBarNameLicenseStyle.customEditTextStyle()),
                                                                            ),
                                                                          ),
                                                                          Expanded(
                                                                            child: Center(
                                                                              child: Text(
                                                                                  'Date',
                                                                                  textAlign:
                                                                                  TextAlign
                                                                                      .start,
                                                                                  style: ProfileBarNameLicenseStyle.customEditTextStyle()),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                  FutureBuilder<
                                                                      Map<
                                                                          String,
                                                                          List<
                                                                              LicensesData>>>(
                                                                      future: getLicenseStatusWise(
                                                                          context,
                                                                          searchByEmployeeIdProfileData!
                                                                              .employeeId!),
                                                                      builder: (context,
                                                                          snapshot) {
                                                                        if (snapshot
                                                                            .connectionState ==
                                                                            ConnectionState
                                                                                .waiting) {
                                                                          return Center(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets
                                                                                  .symmetric(
                                                                                  vertical:
                                                                                  150),
                                                                              child:
                                                                              CircularProgressIndicator(
                                                                                color: ColorManager
                                                                                    .blueprime,
                                                                              ),
                                                                            ),
                                                                          );
                                                                        }
                                                                        if (snapshot
                                                                            .data![
                                                                        'Upto date']!
                                                                            .isEmpty) {
                                                                          return Center(
                                                                              child:
                                                                              Padding(
                                                                                padding: const EdgeInsets
                                                                                    .symmetric(
                                                                                    vertical:
                                                                                    150),
                                                                                child: Text(NoDataMessage.nouptodate,
                                                                                  style: AllNoDataAvailable.customTextStyle(context),
                                                                                ),

                                                                              ));
                                                                        }
                                                                        if (snapshot
                                                                            .hasData) {
                                                                          final upToDateLicenses =
                                                                          snapshot.data![
                                                                          'Upto date']!;
                                                                          //final inactiveLicenses = snapshot.data!['Inactive']!;
                                                                          return Container(
                                                                            height: MediaQuery.of(
                                                                                context)
                                                                                .size
                                                                                .height /
                                                                                2,
                                                                            child: ScrollConfiguration(
                                                                              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                                                                              child: ListView
                                                                                  .builder(
                                                                                  scrollDirection:
                                                                                  Axis
                                                                                      .vertical,
                                                                                  itemCount:
                                                                                  upToDateLicenses
                                                                                      .length,
                                                                                  itemBuilder:
                                                                                      (context,
                                                                                      index) {
                                                                                    int serialNumber = index +
                                                                                        1 +
                                                                                        (currentPage - 1) * itemsPerPage;
                                                                                    String
                                                                                    formattedSerialNumber =
                                                                                    serialNumber.toString().padLeft(2, '0');
                                                                                    return Column(
                                                                                      crossAxisAlignment:
                                                                                      CrossAxisAlignment.start,
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
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                  children: [
                                                                                                    Expanded(
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                            formattedSerialNumber,
                                                                                                            // formattedSerialNumber,
                                                                                                            style: AboutExpiredLStyle.customEditTextStyle()
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    // Text(''),
                                                                                                    Expanded(
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                            upToDateLicenses[index].licenseure,
                                                                                                            style: AboutExpiredLStyle.customEditTextStyle()
                                                                                                        ),
                                                                                                      ),
                                                                                                    ),
                                                                                                    Expanded(
                                                                                                      child: Center(
                                                                                                        child: Text(
                                                                                                            upToDateLicenses[index].expDate,
                                                                                                            style: AboutExpiredLStyle.customEditTextStyle()
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
                                                                          );
                                                                        }
                                                                        return Offstage();
                                                                      }),
                                                                ],
                                                              ),
                                                            ),
                                                          ));
                                                    });
                                              },
                                              text: AppString.uptodate,
                                              // containerColor: Colors.lightGreen,
                                              containerColor: Color(0xffB4DB4C),
                                              textOval: profileState.upToDateCount.toString()),
                                        ],
                                      ),
                                    );
                                  },
                                );
                                  },

                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ],
        ),
      );
  }
}

class ProfileBarTextBoldStyle{
  static TextStyle customEditTextStyle() {
    return TextStyle(
      fontSize: FontSize.s12,
      fontWeight: FontWeight.w600,
      color: ColorManager.textPrimaryColor,

      // decoration: TextDecoration.none,
    );
  }
}
class ProfileBarZoneStyle {
  static TextStyle customEditTextStyle() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: const Color(0xff686464),
      decoration: TextDecoration.none,
    );
  }
}
class ProfileBarNameLicenseStyle {
  static TextStyle customEditTextStyle() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      decoration: TextDecoration.none,
    );
  }
}
class AboutExpiredLStyle{
  static TextStyle customEditTextStyle() {
    return TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: const Color(0xff686464),
      decoration: TextDecoration.none,
    );
  }
}