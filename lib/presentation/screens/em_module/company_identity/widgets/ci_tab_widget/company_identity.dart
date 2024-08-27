import 'dart:async';
// import 'dart:nativewrappers/_internal/vm/lib/math_patch.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/manage_button_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/add_office_submit_button.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/whitelabelling_screen.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../widgets/button_constant.dart';
import '../../../widgets/text_form_field_const.dart';

class CompanyIdentity extends StatefulWidget {
  const CompanyIdentity({Key? key}) : super(key: key);

  @override
  State<CompanyIdentity> createState() => _CompanyIdentityState();
}

class _CompanyIdentityState extends State<CompanyIdentity> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();
  late StreamController<List<CompanyIdentityModel>> _companyIdentityController;
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();
  bool showStreamBuilder = true;
  bool showManageScreen = false;
  // bool _isSubmitting = false;
  bool showWhitelabellingScreen = false;

  void loadData() {}

  @override
  void initState() {
    super.initState();
    // currentPage = 1;
    // itemsPerPage = 30;
  }

  String selectedOfficeID = '';
  String selectedOfficeName = '';
  int selectedCompId = 0;
  int selectedCompOfficeId = 0;
  // bool _isSubmitting = false;

  void showManageScreenFunction(
      {required String officeId, officeName, required int compId, required int companyOfficeId}) {
    setState(() {
      selectedOfficeID = officeId;
      selectedOfficeName = officeName;
      selectedCompId = compId;
      selectedCompOfficeId = companyOfficeId;
      showManageScreen = true;
      showStreamBuilder = false;
      showWhitelabellingScreen = false;
    });
  }

  void showWhitelabellingScreenFunction() {
    setState(() {
      showStreamBuilder = false;
      showWhitelabellingScreen = true;
      showManageScreen = false;
    });
  }

  int currentPage = 1;
  int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int page) {
    setState(() {
      currentPage = page;
    });
  }


  @override
  Widget build(BuildContext context) {

    _companyIdentityController = StreamController<List<CompanyIdentityModel>>();
    return Column(
      children: [
        /// Render top row with buttons only if both manage and whitelabelling screens are not shown
        if (!showManageScreen && !showWhitelabellingScreen)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  borderRadius: 12,
                  text: 'White-labelling',
                  style: CustomTextStylesCommon.commonStyle(
                    fontSize: FontSize.s12,
                    fontWeight: FontWeightManager.bold,
                    color: ColorManager.white,
                  ),
                  width: 120,
                  height: 30,
                  onPressed: showWhitelabellingScreenFunction,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: CustomIconButtonConst(
                  width: 140,
                  text: 'Add New Office',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddOfficeSumbitButton(
                          nameController: nameController,
                          addressController: addressController,
                          emailController: emailController,
                          mobNumController: mobNumController,
                          secNumController: secNumController,
                          OptionalController: OptionalController,
                          onPressed: () async{
                            await
                            addNewOffice(
                              context,
                              nameController.text,
                              addressController.text,
                              emailController.text,
                              mobNumController.text,
                              secNumController.text,
                            );
                            companyOfficeListGet(
                                context, 1, 30)
                                .then((data) {
                              _companyIdentityController
                                  .add(data);
                            }).catchError((error) {});
                          }, formKey: _formKey,);
                      },
                    );
                  },
                  icon: Icons.add,
                )
              ),
            ],
          ),
        /// Render heading only if both manage and whitelabelling screens are not shown
        if (!showManageScreen && !showWhitelabellingScreen)
          Container(
            height: 30,
            margin: EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              color: ColorManager.fmediumgrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      "Sr No.",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Office Name",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Address",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "Actions",
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        /// Render list only if both manage and whitelabelling screens are not shown
        if (!showManageScreen && !showWhitelabellingScreen)
          Expanded(
            child: showStreamBuilder
                ? FutureBuilder(
                future: companyOfficeListGet(context, 1, 30),
                builder: (context, snap) {
                  if (snap.hasData) {
                    _companyIdentityController.add(snap.data!);
                    return StreamBuilder<List<CompanyIdentityModel>>(
                      stream: _companyIdentityController.stream,
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(color: Colors.blue));
                        }
                        if (snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text(
                              "No Data!",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }
                        if (snapshot.hasData) {
                          int totalItems = snapshot.data!.length;
                          int totalPages = (totalItems / itemsPerPage).ceil();
                          List<CompanyIdentityModel> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: paginatedData.length,
                                  itemBuilder: (context, index) {
                                    int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                                    String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 5),
                                        Container(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          margin: const EdgeInsets.symmetric(horizontal: 50),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(4),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          height: 56,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    formattedSerialNumber,
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff686464),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    paginatedData[index].officeName.toString(),
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff686464),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Text(
                                                    paginatedData[index].address.toString(),
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 10,
                                                      fontWeight: FontWeight.w700,
                                                      color: const Color(0xff686464),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      CustomButtonTransparentSM(
                                                        text: 'Manage',
                                                        onPressed: () {
                                                          print(paginatedData[index].officeId);
                                                          showManageScreenFunction(
                                                            officeId: paginatedData[index].officeId,
                                                            officeName: paginatedData[index].officeName,
                                                            compId: paginatedData[index].companyId,
                                                            companyOfficeId: paginatedData[index].companyOfficeId,
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              /// Pagination Controls
                              PaginationControlsWidget(
                                currentPage: currentPage,
                                items: snapshot.data!,
                                itemsPerPage: itemsPerPage,
                                onPreviousPagePressed: () {
                                  setState(() {
                                    currentPage = currentPage > 1 ? currentPage - 1 : 1;
                                  });
                                },
                                onPageNumberPressed: (pageNumber) {
                                  setState(() {
                                    currentPage = pageNumber;
                                  });
                                },
                                onNextPagePressed: () {
                                  setState(() {
                                    currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                                  });
                                },
                              ),
                            ],
                          );
                        }
                            return const Scaffold();
                          },
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                            color: Colors.blue));
                      }
                    })
                : PageView(
                    controller: _pageController,
                    children: [
                      Container(
                        child: WhitelabellingScreen(officeId: selectedOfficeID,),
                      ),
                    ],
                  ),
          ),

        /// Render manage screen if showManageScreen is true
        if (showManageScreen)
          Expanded(
            child: ManageWidget(
              officeID: selectedOfficeID,
              officeName: selectedOfficeName,
              companyID: selectedCompId,
              backButtonCallBack: (bool val) {
                if (val) {
                  setState(() {
                    showWhitelabellingScreen = false;
                    showManageScreen = false;
                    showStreamBuilder = true;
                  });
                }
              }, companyOfficeId: selectedCompOfficeId,
            ),
          ),

        /// Render whitelabelling screen if showWhitelabellingScreen is true
        if (showWhitelabellingScreen)
          Expanded(
            child: WhitelabellingScreen(officeId: selectedOfficeID,),
          ),

      ],
    );
  }
}
