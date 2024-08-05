import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/main_register_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/register_data/register_data.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/register/offer_letter_screen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/register_enroll_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/register/webView/WebViewScreen.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/on_boarding_welcome.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/register_row_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../data/api_data/hr_module_data/register_data/main_register_screen_data.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import 'confirmation_constant.dart';
import 'dart:html' as html;

///saloni
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final StreamController<List<RegisterDataCompID>> registerController = StreamController<List<RegisterDataCompID>>();
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  String _selectedValue = 'Select';
  List<RegisterDataCompID> allData = [];

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<RegisterDataCompID> data = await GetRegisterByCompId(context);
      setState(() {
        allData = data;
      });
      registerController.add(data);
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildDropdownButton(context),
              const SizedBox(width: 50),
            ],
          ),
          const SizedBox(height: AppSize.s20),
          StreamBuilder<List<RegisterDataCompID>>(
            stream: registerController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Center(
                    child: CircularProgressIndicator(color: ColorManager.blueprime),
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Center(
                    child: Text(
                      AppString.dataNotFound,
                      style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  ),
                );
              }
              return Wrap(
                spacing: 10,
               // runSpacing: 10,
                children: List.generate(snapshot.data!.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p10,
                        right: AppPadding.p10,
                        top: AppPadding.p5,
                        bottom: AppPadding.p40),
                    child: buildDataContainer(snapshot.data![index]),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget buildDropdownButton(BuildContext context) {
    return FutureBuilder<List<RegisterEnrollData>>(
      future: RegisterGetData(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 300,
              height: 30,
              decoration: BoxDecoration(
                color: ColorManager.faintGrey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          return Container(
            height: 31,
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.25),
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: DropdownButton<String>(
              value: _selectedValue,
              style: GoogleFonts.firaSans(
                fontSize: 12,
                fontWeight: FontWeightManager.bold,
                color: const Color(0xff50B5E5),
                decoration: TextDecoration.none,
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xff50B5E5),
              ),
              iconSize: 20,
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedValue = newValue!;
                  filterData();
                });
              },
              items: <String>[
                'Select',
                'Opened',
                'Notopen',
                'Partial',
                'Complete',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: ColorManager.blueprime)),
                );
              }).toList(),
            ),
          );
        } else {
          return const Offstage();
        }
      },
    );
  }

  void filterData() {
    if (_selectedValue == 'Select') {
      registerController.add(allData);
    } else {
      List<RegisterDataCompID> filteredData = allData.where((data) => data.status == _selectedValue).toList();
      registerController.add(filteredData);
    }
  }

  Widget buildDataContainer(RegisterDataCompID data) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.2,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xff51B5E6),
          width: 0.5,
        ),
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      height: 163,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 80,
          vertical: MediaQuery.of(context).size.height / 120,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  data.firstName.capitalizeFirst!,
                  style: GoogleFonts.firaSans(
                    fontWeight: FontWeightManager.medium,
                    color: const Color(0xff333333),
                    fontSize: FontSize.s13,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                data.status == 'Notopen'
                    ? Text(
                  'Not Opened',
                  style: GoogleFonts.firaSans(
                    fontWeight: FontWeightManager.medium,
                    color: const Color(0xff333333),
                    fontSize: FontSize.s12,
                  ),
                )
                    : Text(
                  'Status',
                  style: GoogleFonts.firaSans(
                    fontWeight: FontWeightManager.medium,
                    color: const Color(0xff333333),
                    fontSize: FontSize.s12,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 100),
                data.status == 'Notopen'
                    ? const SizedBox(width: 10)
                    : Container(
                  width: 10.0,
                  height: 15.0,
                  decoration: BoxDecoration(
                    color: data.status == 'Opened'
                        ? const Color(0xff51B5E6)
                        : data.status == 'Partial'
                        ? const Color(0xffCA8A04)
                        : const Color(0xffB4DB4C),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width / 100),
                data.status == 'Notopen'
                    ? const SizedBox(width: 10)
                    : Text(
                  data.status,
                  style: GoogleFonts.firaSans(
                    fontWeight: FontWeightManager.medium,
                    color: data.status == 'Opened'
                        ? Color(0xff51B5E6) : data.status == 'Partial'
                        ? Color(0xffCA8A04) : data.status == 'Completed'
                        ? Color(0xffB4DB4C)
                        :ColorManager.rednew,
                    fontSize: FontSize.s12,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 130,
                top: MediaQuery.of(context).size.height / 120,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  CustomRow(
                    icon: Icons.email_outlined,
                    text1: 'Email',
                    text2: data.email,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 60),
                  ///link
                  Row(
                    children: [
                      Icon(Icons.link, size: 15, color: ColorManager.mediumgrey),
                      SizedBox(width: MediaQuery.of(context).size.width / 40),
                      Text(
                        'Link',
                        style: GoogleFonts.firaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: ColorManager.mediumgrey,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                      data.status == 'Notopen'
                          ? const Text('')
                          : TextButton(
                        onPressed: () async {
                          //html.window.open('/onBordingWelcome',"_blank");
                          const url = "http://localhost:58946/#/onBordingWelcome";//https://staging.symmetry.care/#/onBordingWelcome
                          if (await canLaunch(url)) {
                            await launch(url);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OnBoardingWelcome(),
                              ),
                            );
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          data.link!,
                          style: GoogleFonts.firaSans(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: ColorManager.blueprime,
                          ),
                        ),
                      ),
                    ],
                  ),
                  data.status == 'Notopen'
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: AppSize.s110,
                        margin: const EdgeInsets.only(right: AppMargin.m30),
                        child: CustomIconButtonConst(
                          text: AppString.enroll,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => FutureBuilder<RegisterDataUserIDPrefill>(
                                future: getRegisterEnrollPrefillUserId(context, data.userId),
                                builder: (context, snapshotPrefill) {
                                  if (snapshotPrefill.connectionState == ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(color: ColorManager.blueprime),
                                    );
                                  }
                                  var firstName = snapshotPrefill.data!.firstName.toString();
                                  firstNameController = TextEditingController(text: firstName);

                                  var lastName = snapshotPrefill.data!.lastName.toString();
                                  lastNameController = TextEditingController(text: lastName);

                                  var email = snapshotPrefill.data!.email.toString();
                                  emailController = TextEditingController(text: email);

                                  return RegisterEnrollPopup(
                                    employeeId: data.employeeId!,
                                    firstName: firstNameController,
                                    lastName: lastNameController,
                                    email: emailController,
                                    userId: snapshotPrefill.data!.userId,
                                    role: snapshotPrefill.data!.role,
                                    status: snapshotPrefill.data!.status,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
