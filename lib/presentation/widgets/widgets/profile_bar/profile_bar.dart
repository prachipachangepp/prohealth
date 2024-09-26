import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/font_manager.dart';
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
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../profile_bar/widget/profil_custom_widget.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


 typedef EditCallback = void Function();

class ProfileBar extends StatefulWidget {
  const ProfileBar({
    super.key, this.searchByEmployeeIdProfileData,
    required this.onEditPressed,});
  final SearchByEmployeeIdProfileData? searchByEmployeeIdProfileData;
  final VoidCallback onEditPressed;

  @override
  State<ProfileBar> createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {
  @override
  void initState() {
    super.initState();
    _calculateAge(widget.searchByEmployeeIdProfileData!.dateOfBirth);
    _calculateHireDateTimeStamp(widget.searchByEmployeeIdProfileData!.dateofHire);
    sSNNBR = maskString(widget.searchByEmployeeIdProfileData!.SSNNbr, 4);
    fetchData();
  }

  String? sSNNBR;
  int expiredCount = 0;
  int upToDateCount = 0;
  int aboutToCount = 0;
  dynamic base64Decode;
  Future<void> decodeMEthod(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Url response Data : ${response.body}');
      base64Decode = response.body;
      return base64Decode;
    }
  }

  String? dobTimestamp;
  String _calculateAge(String birthDate) {
    DateTime convertedDate = DateTime.parse(birthDate);
    DateTime today = DateTime.now();
    int years = today.year - convertedDate.year;
    int months = today.month - convertedDate.month;
    int days = today.day - convertedDate.day;

    if (days < 0) {
      months--;
      days += DateTime(today.year, today.month, 0)
          .day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    if (years > 0) {
      dobTimestamp = "${years.toString()} year";
    } else if (months > 0) {
      dobTimestamp = "${months.toString()} months";
    } else {
      dobTimestamp = "${days.toString()} days";
    }
    //dobTimestamp = days.toString();
    print('Timestamp date ${dobTimestamp}');

    return "$dobTimestamp years";
  }
  String? totalDateStamp;
  String _calculateHireDateTimeStamp(String hireDate) {
    DateTime convertedDate = DateTime.parse(hireDate);
    DateTime today = DateTime.now();
    int years = today.year - convertedDate.year;
    int months = today.month - convertedDate.month;
    int days = today.day - convertedDate.day;

    if (days < 0) {
      months--;
      days += DateTime(today.year, today.month, 0)
          .day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }

    if (years > 0) {
      totalDateStamp = "${years.toString()} year";
    } else if (months > 0) {
      totalDateStamp = "${months.toString()} months";
    } else {
      totalDateStamp = "${days.toString()} days";
    }
    //dobTimestamp = days.toString();
    print('Timestamp Hiredate ${totalDateStamp}');

    return "$totalDateStamp years";
  }

  Future<void> fetchData() async {
    try {
      Map<String, List<LicensesData>> data = await getLicenseStatusWise(
          context, widget.searchByEmployeeIdProfileData!.employeeId!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Update the count after the current build phase
        expiredCount = data['Expired']!.length;
        upToDateCount = data['About to Expire']!.length;
        aboutToCount = data['Upto date']!.length;
        //print("EEE ${expiredCount}");
      });
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  String maskString(String input, int visibleDigits) {

    int maskLength = input.length - visibleDigits;

    if (maskLength > 0) {

      String masked = '*' * maskLength;

      return masked + input.substring(maskLength);
    } else {

      return input;
    }
  }

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
              width: AppSize.s70,
              decoration: BoxDecoration(
                color: ColorManager.greenF,
              ),
              child: FutureBuilder<ProfilePercentage>(
                  future: getPercentage(context,
                      widget.searchByEmployeeIdProfileData!.employeeId!),
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
                  horizontal: AppSize.s10, vertical: AppSize.s10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ///image
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: AppSize.s70,
                          height: AppSize.s70,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              widget.searchByEmployeeIdProfileData!.imgurl == 'imgurl' ||
                                  widget.searchByEmployeeIdProfileData!.imgurl == null ?

                              Icon(
                                Icons.person,
                                color: ColorManager.white,
                                size: AppSize.s50,
                              ) :
                              CachedNetworkImage(
                                imageUrl: widget.searchByEmployeeIdProfileData!.imgurl,
                                placeholder: (context, url) => new CircularProgressIndicator(),
                                errorWidget: (context, url, error) => new Icon(Icons.error),
                                width: AppSize.s70,
                                height: AppSize.s70,
                              ),
                              // Image.network(widget.searchByEmployeeIdProfileData!.imgurl,
                              //     height: AppSize.s50, width: AppSize.s50),
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
                          widget.searchByEmployeeIdProfileData!.status
                              .capitalizeFirst!,
                          style: ThemeManagerBlack.customTextStyle(context),
                        ),
                        SizedBox(height: 5,),
                        FutureBuilder<ProfilePercentage>(
                            future: getPercentage(
                                context,
                                widget.searchByEmployeeIdProfileData!.employeeId!),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return SizedBox();
                              }
                              return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Annual skills ${snapshot.data!.percentage}%",
                                      style:
                                      ProfileBarTextBoldStyle.customEditTextStyle(),
                                    ),
                                  ]);
                            })
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///text john scott
                      Row(
                        children: [
                          Text(
                            "${widget.searchByEmployeeIdProfileData!.firstName.capitalizeFirst}"
                                " ${widget.searchByEmployeeIdProfileData!.lastName.capitalizeFirst}",
                            style: ThemeManagerBlack.customTextStyle(context),
                          ),
                          // IconButton(
                          //   onPressed: widget.onEditPressed,
                          //   icon: Icon(Icons.edit_outlined, size: 14),
                          // ),
                          IconButton(
                            onPressed: widget.onEditPressed,
                            icon: Icon(Icons.edit_outlined, size: 14, color: IconColorManager.bluebottom,),
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 40,
                        width: MediaQuery.of(context).size.width / 10,
                        decoration: BoxDecoration(color: ColorManager.faintOrange.withOpacity(0.9)),
                        ///edit button
                         child: Center(
                           child: Text(
                                 widget.searchByEmployeeIdProfileData!.employeeType.capitalizeFirst!,
                             style: ThemeManagerWhite.customTextStyle(context),
                           ),
                         ),
                      ),

                      Row(
                        children: [
                          Text(
                            'Employment Type :',
                            style: ProfileBarTextBoldStyle.customEditTextStyle(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.searchByEmployeeIdProfileData!.employment[0].toUpperCase() +
                                widget.searchByEmployeeIdProfileData!.employment.substring(1),
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                        ],
                      ),

                      Text(
                        widget.searchByEmployeeIdProfileData!.zone,
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        AppString.address,
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      Text(widget.searchByEmployeeIdProfileData!.finalAddress,
                          textAlign: TextAlign.start,
                          style: ThemeManagerAddressPB.customTextStyle(context)),
                    ],
                  ),

                  SizedBox(
                    width: 40,
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: MyConstants.personalInfoTexts(context),
                      ),
                      SizedBox(
                        width: 20
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ///text john scott
                          Text(
                            "${widget.searchByEmployeeIdProfileData!.dateOfBirth} (${dobTimestamp})",
                            style: ThemeManagerDark.customTextStyle(context),
                          ),

                          Text(
                            widget.searchByEmployeeIdProfileData!.gender,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          Text(
                            sSNNBR!,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),

                          ///phone, comment
                          ProfileBarPhoneCmtConst(
                            phoneNo: widget
                                .searchByEmployeeIdProfileData!.primaryPhoneNbr,
                          ),

                          ProfileBarPhoneCmtConst(
                            phoneNo: widget.searchByEmployeeIdProfileData!
                                .secondryPhoneNbr,
                          ),

                          ProfileBarPhoneCmtConst(
                            phoneNo: widget
                                .searchByEmployeeIdProfileData!.workPhoneNbr,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: MyConstantsColumn.personalInfoTexts(context),
                        ),
                      ),
                      SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // InkWell(
                          //   child: Text(widget.searchByEmployeeIdProfileData!.personalEmail,
                          //       style: ProfileBarConst.profileTextStyle(context)),
                          //   onTap: () async {
                          //
                          //   },
                          // ),
                          InkWell(
                            child: Text(
                              widget.searchByEmployeeIdProfileData!.personalEmail ?? 'No email provided',
                              style: ProfileBarConst.profileTextStyle(context),  // Ensure the ProfileBarConst is defined elsewhere
                            ),
                            onTap: () async {
                              String? email = widget.searchByEmployeeIdProfileData!.personalEmail;

                              // Check if the email is not null or empty
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

                          Text(
                              widget
                                  .searchByEmployeeIdProfileData!.workEmail,
                              style: ProfileBarConst.profileTextStyle(context)),

                          Text(
                            widget.searchByEmployeeIdProfileData!.employment,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          Text(
                            widget.searchByEmployeeIdProfileData!.service,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          Text(
                            widget.searchByEmployeeIdProfileData!.regOfficId,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          Text(
                            AppString.na,
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          // Text(""),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/45,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(AppString.hideDate,
                                      style: ProfileBarTextBoldStyle.customEditTextStyle()
                                  ),
                                  SizedBox(height: 10,),
                                  Text('PTA',
                                      style: ProfileBarTextBoldStyle.customEditTextStyle()),
                                ],
                              ),
                              SizedBox(width: MediaQuery.of(context).size.width/50,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${widget.searchByEmployeeIdProfileData!.dateofHire} (${totalDateStamp})",
                                      style: ThemeManagerDark.customTextStyle(context)),
                                  SizedBox(height: 10,),
                                  Text('1.2', style: ThemeManagerDark.customTextStyle(context)),
                                ],
                              )
                            ]),
                      ),
                      FutureBuilder(
                        future: fetchData(),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(height: 1, width: 1);
                          }
                          return Column(
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
                                                        future: getLicenseStatusWise(
                                                            context,
                                                            widget
                                                                .searchByEmployeeIdProfileData!
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
                                                              .data!['Expired']!
                                                              .isEmpty) {
                                                            return Center(
                                                                child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          150),
                                                              child: Text(
                                                                AppString
                                                                    .dataNotFound,
                                                                style: CustomTextStylesCommon.commonStyle(
                                                                    fontWeight: FontWeight.w400,
                                                                    fontSize:
                                                                        FontSize
                                                                            .s12,
                                                                    color: ColorManager
                                                                        .mediumgrey),
                                                              ),
                                                            ));
                                                          }
                                                          if (snapshot
                                                              .hasData) {
                                                            final expiredLicenses =
                                                                snapshot.data![
                                                                    'Expired']!;
                                                            //final inactiveLicenses = snapshot.data!['Inactive']!;
                                                            return Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height /
                                                                  2,
                                                              child: ListView
                                                                  .builder(
                                                                      scrollDirection:
                                                                          Axis
                                                                              .vertical,
                                                                      itemCount:
                                                                          expiredLicenses
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              index) {
                                                                        expiredCount =
                                                                            expiredLicenses.length;
                                                                        print(
                                                                            "Expired count :: ${expiredCount}");
                                                                        int serialNumber = index +
                                                                            1 +
                                                                            (currentPage - 1) *
                                                                                itemsPerPage;
                                                                        String formattedSerialNumber = serialNumber
                                                                            .toString()
                                                                            .padLeft(2,
                                                                                '0');
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
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                      children: [
                                                                                        Expanded(
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              formattedSerialNumber,
                                                                                              // formattedSerialNumber,
                                                                                        style: ProfileBarNameLicenseStyle.customEditTextStyle()
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        // Text(''),
                                                                                        Expanded(
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              expiredLicenses[index].org,
                                                                                                style: ProfileBarNameLicenseStyle.customEditTextStyle()
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              expiredLicenses[index].issueDate,
                                                                                                style: ProfileBarNameLicenseStyle.customEditTextStyle()
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
                                textOval: expiredCount.toString(),
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
                                                              widget
                                                                  .searchByEmployeeIdProfileData!
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
                                                                child: Text(
                                                                  AppString
                                                                      .dataNotFound,
                                                                  style: CustomTextStylesCommon.commonStyle(
                                                                      fontWeight:FontWeight.w500,
                                                                      fontSize:
                                                                          FontSize
                                                                              .s12,
                                                                      color: ColorManager
                                                                          .mediumgrey),
                                                                ),
                                                              ));
                                                            }
                                                            if (snapshot
                                                                .hasData) {
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
                                                                                                aboutToExpiredLicenses[index].org,
                                                                                                style: AboutExpiredLStyle.customEditTextStyle()
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                aboutToExpiredLicenses[index].issueDate,
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
                                  textOval: upToDateCount.toString()),
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
                                                              widget
                                                                  .searchByEmployeeIdProfileData!
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
                                                                child: Text(
                                                                  AppString
                                                                      .dataNotFound,
                                                                  style: CustomTextStylesCommon.commonStyle(
                                                                      fontWeight:
                                                                          FontWeightManager
                                                                              .medium,
                                                                      fontSize:
                                                                          FontSize
                                                                              .s12,
                                                                      color: ColorManager
                                                                          .mediumgrey),
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
                                                                                                style: ProfileBarZoneStyle.customEditTextStyle()
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          // Text(''),
                                                                                          Expanded(
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                upToDateLicenses[index].org,
                                                                                                style: ProfileBarZoneStyle.customEditTextStyle()
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Center(
                                                                                              child: Text(
                                                                                                upToDateLicenses[index].issueDate,
                                                                                                style: ProfileBarZoneStyle.customEditTextStyle()
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
                                  textOval: aboutToCount.toString()),
                            ],
                          );
                        },
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

class ProfileBarTextBoldStyle{
  static TextStyle customEditTextStyle() {
    return TextStyle(
      fontSize: FontSize.s10,
      fontWeight: FontWeight.w600,
      color: ColorManager.textPrimaryColor,

      // decoration: TextDecoration.none,
    );
  }
}
class ProfileBarZoneStyle {
  static TextStyle customEditTextStyle() {
    return TextStyle(
      fontSize: 10,
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
      fontSize: 11,
      fontWeight: FontWeight.w400,
      color: const Color(0xff686464),
      decoration: TextDecoration.none,
    );
  }
}