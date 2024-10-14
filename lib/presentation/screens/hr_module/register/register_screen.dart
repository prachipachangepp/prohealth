import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/constants/app_config.dart';

import 'package:prohealth/app/services/api/managers/hr_module_manager/add_employee/clinical_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/main_register_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/register_manager.dart';
import 'package:prohealth/data/api_data/hr_module_data/add_employee/clinical.dart';
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
import '../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../app/services/api/managers/establishment_manager/all_from_hr_manager.dart';
import '../../../../app/services/api/managers/establishment_manager/user.dart';
import '../../../../data/api_data/establishment_data/all_from_hr/all_from_hr_data.dart';
import '../../../../data/api_data/establishment_data/user/user_modal.dart';
import '../../../../data/api_data/hr_module_data/register_data/main_register_screen_data.dart';
import '../../../widgets/establishment_text_const/text_widget_const.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../../em_module/see_all_screen/widgets/popup_const.dart';
import '../manage/widgets/custom_icon_button_constant.dart';
import 'confirmation_constant.dart';
import 'dart:html' as html;

///saloni
class RegisterScreen extends StatefulWidget {
  final Function() onRefresh;

  const RegisterScreen({Key? key, required this.onRefresh, }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final StreamController<List<RegisterDataCompID>> registerController = StreamController<List<RegisterDataCompID>>();
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  /// register enroll user
  TextEditingController newUserFirstNameController = TextEditingController();
  TextEditingController newUserLastNameController = TextEditingController();
  TextEditingController newUserEmailController = TextEditingController();
  TextEditingController newUserPasswordController = TextEditingController();

  /// Enroll
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  /// Enroll
  TextEditingController userIdController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController companyIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final StreamController<List<UserModal>> _companyUsersList =
  StreamController<List<UserModal>>();

  String _selectedValue = 'Sort';
  List<RegisterDataCompID> allData = [];

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    fetchData();
  }
  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      // Optionally show a snackbar or dialog to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Copied to clipboard',  style:TableHeading.customTextStyle(context))),
      );
    });
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
  bool _isLoading = false;

  var deptId = 0;
  int? firstDeptId;
  String? selectedDeptName;
  int? selectedDeptId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
      //  mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 36.0),
                child: Container(
                  width: 300,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ///Enroll Button
                      Container(
                        height: AppSize.s30,
                        width: AppSize.s140,
                        child:  CustomIconButton(
                          icon: Icons.add,
                          text: 'Enroll User',
                          onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialog(
                                  title: "Enroll User",
                                  //userIdController: userIdController,
                                  lastNameController: newUserLastNameController,
                                  emailController: newUserEmailController,
                                  firstNameController: newUserFirstNameController,
                                  // roleController: roleController,
                                  passwordController: newUserPasswordController,
                                  onCancel: () {
                                    //widget.onRefresh();
                                    setState(() {
                                      fetchData();
                                    });},
                                );
                              },
                            );
                          setState((){});
                          },
                        ),
                      ),

                      SizedBox(width: 10,),
                      /// Select Dropdown button
                      buildDropdownButton(context),
                     // const SizedBox(width: 50),
                    ],
                  ),
                ),
              ),
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
                      "No Register available!",
                      style: CustomTextStylesCommon.commonStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: FontSize.s14,
                          color: ColorManager.mediumgrey),
                      // AppString.dataNotFound,
                      //style:DocumentTypeDataStyle.customTextStyle(context),
                    ),
                  ),
                );
              }

              return Wrap(
                spacing: 10,
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
          )

        ],
      ),
    );

  }
  Widget buildDropdownButton(BuildContext context) {
    return  Column(
      children: [
        Container(
          height: 31,
          width: 130,
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
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue!;
                filterData();
              });
            },
            style: TransparentButtonTextConst.customTextStyle(context),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(0xff50B5E5),
            ),
            iconSize: 20,
            focusColor: Colors.transparent,
            underline: const SizedBox(),
            selectedItemBuilder: (BuildContext context) {
              return <String>[
                'Sort',
                'Opened',
                'Notopen',
                'Partial',
                'Completed',
              ].map<Widget>((String value) {
                return Container(
                  alignment: Alignment.center,
                  child: Text(
                    value,
                    style: TransparentButtonTextConst.customTextStyle(context),
                  ),
                );
              }).toList();
            },
            items: <String>[
              'Sort',
              'Opened',
              'Notopen',
              'Partial',
              'Completed',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );

  }
  ///dont delete
  // Widget buildDropdownButton(BuildContext context) {
  //   return Column(
  //     children: [
  //       Container(
  //         height: 31,
  //         width: 130,
  //         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           border: Border.all(color: const Color(0xff50B5E5), width: 1.2),
  //           borderRadius: BorderRadius.circular(12.0),
  //           boxShadow: [
  //             BoxShadow(
  //               color: const Color(0xff000000).withOpacity(0.25),
  //               blurRadius: 2,
  //               offset: const Offset(0, 2),
  //             ),
  //           ],
  //         ),
  //         child: DropdownButton<String>(
  //           value: _selectedValue,
  //           onChanged: (String? newValue) {
  //             setState(() {
  //               _selectedValue = newValue!;
  //               filterData();
  //             });
  //           },
  //           style: TransparentButtonTextConst.customTextStyle(context),
  //           icon: const Icon(
  //             Icons.arrow_drop_down,
  //             color: Color(0xff50B5E5),
  //           ),
  //           iconSize: 20,
  //           focusColor: Colors.transparent,
  //           underline: const SizedBox(),
  //           dropdownColor: Colors.white,
  //           isDense: true,
  //           selectedItemBuilder: (BuildContext context) {
  //             return <String>[
  //               'Sort',
  //               'Opened',
  //               'Notopen',
  //               'Partial',
  //               'Completed',
  //             ].map<Widget>((String value) {
  //               return Row(
  //                 children: [
  //                   Text(
  //                     _selectedValue ?? 'Sort',
  //                     style: TransparentButtonTextConst.customTextStyle(context),
  //                   ),
  //                   SizedBox(width: 6,)
  //                 ],
  //               );
  //             }).toList();
  //           },
  //           items: _getDropdownItems(),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  List<DropdownMenuItem<String>> _getDropdownItems() {
    List<String> items = ['Sort', 'Opened', 'Notopen', 'Partial', 'Completed'];

    if (_selectedValue != null && items.contains(_selectedValue)) {
      items.remove(_selectedValue);
      items.insert(0, _selectedValue!);
    }

    return items.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Container(
          alignment: Alignment.center,
          child: Text(value),
        ),
      );
    }).toList();
  }

  void filterData() {
    String selectedStatus = _selectedValue.trim().toLowerCase();

    if (selectedStatus == 'sort') {
      registerController.add(allData);
    } else {
      List<RegisterDataCompID> filteredData = allData.where((data) {
        String dataStatus = data.status.trim().toLowerCase();
        bool matches = dataStatus == selectedStatus;
        print("Checking ${data.status}: $matches");
        return matches;
      }).toList();
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
            Padding(
              padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 130),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    data.firstName.capitalizeFirst!,
                    style:  DefineWorkWeekStyle.customTextStyle(context),
                  ),
                  SizedBox(width: 4,),
                  Text(
                    data.lastName.capitalizeFirst!,
                    style:  DefineWorkWeekStyle.customTextStyle(context),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                data.status == 'Notopen'
                    ? Text('Not Opened',
                  style: DocumentTypeDataStyle.customTextStyle(context),)
                    : Text(
                  'Status',
                    style:DocumentTypeDataStyle.customTextStyle(context)
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
                   style: ConstTextFieldStyles.customTextStyle(textColor:  data.status == 'Opened'
                           ? Color(0xff51B5E6) : data.status == 'Partial'
                           ? Color(0xffCA8A04) : data.status == 'Completed'
                           ? Color(0xffB4DB4C)
                           :ColorManager.rednew,)

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
                          style:DocumentTypeDataStyle.customTextStyle(context)
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width / 20),
                      data.status == 'Notopen'
                          ? const Text('')
                          : TextButton(
                        onPressed: () async {
                          //html.window.open('/onBordingWelcome',"_blank");
                          const url = "http://localhost:50634/#/onBordingWelcome";
                          // const url = "${AppConfig.deployment}/#/onBordingWelcome";
                          //const url = "https://staging.symmetry.care/#/onBordingWelcome";
                          ///
                         // Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingWelcome()));
                          if (await canLaunch(url)) {
                           await launch(url);
                           } else {
                            throw 'Could not launch $url';
                          }
                        },
                        child: Text(
                          data.link!,
                          style: RegisterLinkDataStyle.customTextStyle(context),
                        ),
                      ),
                      data.status == 'Notopen'
                          ? const Text('')
                          : InkWell(onTap: (){
                            _copyToClipboard(
                                "${AppConfig.deployment}/#/onBordingWelcome"
                            );
                      },child: Icon(Icons.copy,size: 15,color: ColorManager.mediumgrey,)),
                    ],
                  ),
                  data.status == 'Notopen'
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: AppSize.s110,
                        margin: const EdgeInsets.only(right: AppMargin.m30),
                        child:CustomIconButton(
                          text: AppString.enroll,
                          onPressed: () async{
                            List<AEClinicalDiscipline> passData = await HrAddEmplyClinicalDisciplinApi(context,1);
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

                                  return
                                    RegisterEnrollPopup(
                                    employeeId: data.employeeId,
                                    firstName: firstNameController,
                                    lastName: lastNameController,
                                    email: emailController,
                                    userId: snapshotPrefill.data!.userId,
                                    role: snapshotPrefill.data!.role,
                                    status: snapshotPrefill.data!.status,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    onReferesh: (){
                                      setState(() {
                                        fetchData();
                                      });
                                    },
                                    aEClinicalDiscipline: passData,
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
                  data.status == 'Completed'
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [Container(
                      width: AppSize.s100,
                      margin: const EdgeInsets.only(right: AppMargin.m30),
                      child: CustomIconButton(
                        text: 'Onboard',
                        onPressed: () async{
                          showDialog(context: context, builder: (BuildContext context){
                            return ConfirmationPopup(
                              loadingDuration: _isLoading,
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onConfirm: () async {
                                setState(() {
                                  _isLoading = true;
                                });

                                try {
                                  var response =  await onboardingUserPatch(context,data.employeeId);
                                  if(response.statusCode == 200 || response.statusCode == 201){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Employee Onboarded'),backgroundColor: Colors.green,)
                                    );
                                    fetchData();
                                    Navigator.pop(context);
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Something went wrong!'),backgroundColor: Colors.red,)
                                    );
                                    Navigator.pop(context);
                                  }

                                } catch (e) {
                                  print("Error during Onboarding: $e");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Onboarding failed: $e')),
                                  );
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              title: 'Confirm Onboarding',
                              containerText: 'Do you really want to onboard?',
                            );
                          });
                        },),
                    )],
                  ) : const SizedBox(width: 10)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
