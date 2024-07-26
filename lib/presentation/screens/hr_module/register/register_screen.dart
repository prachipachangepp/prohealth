import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/register_manager/main_register_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import 'package:prohealth/presentation/screens/hr_module/register/register_enroll_popup.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/after_clicking_on_link/on_boarding_welcome.dart';
import 'package:prohealth/presentation/screens/hr_module/register/widgets/register_row_widget.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../app/resources/font_manager.dart';
import '../../../../data/api_data/hr_module_data/register_data/main_register_screen_data.dart';
import '../../../widgets/widgets/custom_icon_button_constant.dart';

///saloni
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final StreamController<List<RegisterDataCompID>> registerController =
  StreamController<List<RegisterDataCompID>>();
  final StreamController<List<RegisterDataCompIDStatus>> registerStatusController =
  StreamController<List<RegisterDataCompIDStatus>>();

  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  String _selectedValue = 'Select';

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 20;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    GetRegisterByCompId(context).then((data) {
      registerController.add(data);
    }).catchError((error) {});
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
              SizedBox(
                width: 50,
              )
            ],
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          StreamBuilder<List<RegisterDataCompID>>(
            stream: registerController.stream,
            builder: (context, snapshot) {
              print('1111111');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                );
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    AppString.dataNotFound,
                    style: CustomTextStylesCommon.commonStyle(
                      fontWeight: FontWeightManager.medium,
                      fontSize: FontSize.s12,
                      color: ColorManager.mediumgrey,
                    ),
                  ),
                );
              }
              if (_selectedValue != 'Select') {
                List<RegisterDataCompID> filteredData = snapshot.data!
                    .where((item) => item.status == _selectedValue)
                    .toList();
                if (filteredData.isEmpty) {
                  return Center(
                    child: Text(
                      AppString.dataNotFound,
                      style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  );
                }
                return buildDataList(filteredData);
              } else {
                return buildDataList(snapshot.data!);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget buildDataList(List<RegisterDataCompID> data) {
    return Container(
      height: double.maxFinite,
      child: WrapWidget(
          childern: List.generate(data.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: AppPadding.p10,
                  right: AppPadding.p10,
                  top: AppPadding.p5,
                  bottom: AppPadding.p40),
              child: Container(
                width: MediaQuery.of(context).size.width / 2.2,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff51B5E6),
                    width: 0.5,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                height: 156,
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
                            data[index].firstName.capitalizeFirst!,
                            style: GoogleFonts.firaSans(
                              fontWeight: FontWeightManager.medium,
                              color: Color(0xff333333),
                              fontSize: FontSize.s13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          data[index].status == 'Notopen'
                              ? SizedBox(width: 5,)
                              : Text(
                            'Status',
                            style: GoogleFonts.firaSans(
                              fontWeight: FontWeightManager.medium,
                              color: Color(0xff333333),
                              fontSize: FontSize.s12,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 100,
                          ),
                          data[index].status == 'Notopen'
                              ? SizedBox(
                            width: 10,
                          )
                              : Container(
                            width: 10.0,
                            height: 15.0,
                            decoration: BoxDecoration(
                              color: data[index].status == 'Opened'
                                  ? Color(0xff51B5E6)
                                  : data[index].status == 'Partial'
                                  ? Color(0xffCA8A04)
                                  : data[index].status == 'Completed'
                                ? Color(0xffB4DB4C)
                              :ColorManager.rednew,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 100,
                          ),
                          // data[index].status == 'Notopen'
                          //     ? SizedBox(
                          //   width: 10,
                          // )
                          //     :
                          Text(
                            data[index].status,
                            style: GoogleFonts.firaSans(
                              fontWeight: FontWeightManager.medium,
                               color: data[index].status == 'Opened'
                                ? Color(0xff51B5E6) : data[index].status == 'Partial'
                                ? Color(0xffCA8A04) : data[index].status == 'Notopen'
                              ? Color(0xff686464)
                      : data[index].status == 'Completed'
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
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            CustomRow(
                              icon: Icons.email_outlined,
                              text1: 'Email',
                              text2: data[index].email,
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height / 60,
                            ),
                            Row(
                              children: [
                                Icon(Icons.link,
                                    size: 15, color: ColorManager.mediumgrey),
                                SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 40),
                                Text('Link',
                                    style: GoogleFonts.firaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.mediumgrey)),
                                SizedBox(
                                    width:
                                    MediaQuery.of(context).size.width / 20),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OnBoardingWelcome()));
                                  },
                                  child: Text(
                                    data[index].status == 'Notopen'
                                        ? ''
                                        : data[index].role,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: ColorManager.blueprime,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            data[index].status == 'Notopen'
                                ? Row(
                              mainAxisAlignment:
                              MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: AppSize.s110,
                                  margin: EdgeInsets.only(
                                      right: AppMargin.m30),
                                  child: CustomIconButtonConst(
                                      text: AppString.enroll,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) =>

                                          ///prefill api
                                          FutureBuilder<
                                              RegisterDataUserIDPrefill>(
                                            future:
                                            getRegisterEnrollPrefillUserId(
                                                context,
                                                data[index]
                                                    .userId),
                                            builder: (context,
                                                snapshotPrefill) {
                                              if (snapshotPrefill
                                                  .connectionState ==
                                                  ConnectionState
                                                      .waiting) {
                                                return Center(
                                                  child:
                                                  CircularProgressIndicator(
                                                    color: ColorManager
                                                        .blueprime,
                                                  ),
                                                );
                                              }
                                              var firstName =
                                              snapshotPrefill
                                                  .data!
                                                  .firstName
                                                  .toString();
                                              firstNameController =
                                                  TextEditingController(
                                                      text:
                                                      firstName);

                                              var lastName =
                                              snapshotPrefill
                                                  .data!
                                                  .lastName
                                                  .toString();
                                              lastNameController =
                                                  TextEditingController(
                                                      text:
                                                      lastName);

                                              var email =
                                              snapshotPrefill
                                                  .data!.email
                                                  .toString();
                                              emailController =
                                                  TextEditingController(
                                                      text:
                                                      email);
                                              return RegisterEnrollPopup(
                                                firstName:
                                                firstNameController,
                                                lastName:
                                                lastNameController,
                                                email:
                                                emailController,
                                                userId:
                                                snapshotPrefill
                                                    .data!
                                                    .userId,
                                                role:
                                                snapshotPrefill
                                                    .data!
                                                    .role,
                                                status:
                                                snapshotPrefill
                                                    .data!
                                                    .status,
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context);
                                                },
                                              );
                                            },
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }

  Widget buildDropdownButton(BuildContext context) {
    List<String> dropDownList = ['Select', 'Opened', 'Notopen', 'Partial', 'Complete'];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 31,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xff50B5E5), width: 1.2),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Color(0xff000000).withOpacity(0.25),
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: DropdownButton<String>(
            value: _selectedValue,
            style: GoogleFonts.firaSans(
              fontSize: 12,
              fontWeight: FontWeightManager.bold,
              color: Color(0xff50B5E5),
              decoration: TextDecoration.none,
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Color(0xff50B5E5),
            ),
            iconSize: 20,
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedValue = newValue!;
                if (_selectedValue != 'Select') {
                  // Implement your status filtering logic here
                  GetRegisterByCompIdStatus(context, _selectedValue);
                } else {
                  GetRegisterByCompId(context);
                }
              });
            },
            items: dropDownList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(color: ColorManager.blueprime),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

}