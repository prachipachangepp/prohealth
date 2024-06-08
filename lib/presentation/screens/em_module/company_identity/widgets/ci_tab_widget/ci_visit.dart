import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/widget/visit_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
import '../../../../hr_module/manage/controller/controller.dart';
import '../ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import '../policies_procedures/widgets/add_policies_popup.dart';

class CiVisitScreen extends StatefulWidget {
  const CiVisitScreen({super.key});

  @override
  State<CiVisitScreen> createState() => _CiVisitScreenState();
}

class _CiVisitScreenState extends State<CiVisitScreen> {
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  String? selectedValue;
  TextEditingController docNamecontroller = TextEditingController();
  TextEditingController docIdController = TextEditingController();
  late List<Color> hrcontainerColors;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 6;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    hrcontainerColors = List.generate(20, (index) => Color(0xffE8A87D));
    _loadColors();
  }
  void _loadColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      for (int i = 0; i < hrcontainerColors.length; i++) {
        int? colorValue = prefs.getInt('containerColor$i');
        if (colorValue != null) {
          hrcontainerColors[i] = Color(colorValue);
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    List<String> currentPageItems = items.sublist(
      (currentPage - 1) * itemsPerPage,
      min(currentPage * itemsPerPage, items.length),
    );
    final RegisterController _controller = Get.put(RegisterController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: AppSize.s150,
              margin: EdgeInsets.only(right: AppMargin.m30),
              child: CustomIconButtonConst(
                // heightContainer: 30,
                //   widthContainer: 120,
                  text: AppString.addnewvisit,
                  icon: Icons.add,
                  onPressed: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return AddVisitPopup(
                        nameOfDocumentController: docNamecontroller, idOfDocumentController: docIdController, onSavePressed: () {  },
                        child:  CICCDropdown(
                          initialValue: 'Select',
                          items: [
                            DropdownMenuItem(value: 'Select', child: Text('Policies & Procedures')),
                            DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                            DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                            DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                          ],),);
                    });
                  }),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Container(
          height: AppSize.s30,
          margin: EdgeInsets.symmetric(horizontal: AppMargin.m35),
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Center(
                  child: Text(
                    AppString.srNo,
                    // style: RegisterTableHead.customTextStyle(context),
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.white
                      // color: isSelected ? Colors.white : Colors.black,
                    ),
                  )),
              // Expanded(
              //     child: SizedBox(width: AppSize.s16,
              //     )),
              Center(
                  child: Text(
                    AppString.visit,
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white
                      // color: isSelected ? Colors.white : Colors.black,
                    ),
                    // style: RegisterTableHead.customTextStyle(context),
                  )),
              Center(child:
                Text(AppString.eligibleClinician,
    style: GoogleFonts.firaSans(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: ColorManager.white
    // color: isSelected ? Colors.white : Colors.black,
    ),),),
                  // style: RegisterTableHead.customTextStyle(context),),),
              Center(
                  child: Text(
                    AppString.actions,
                    style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ColorManager.white
                      // color: isSelected ? Colors.white : Colors.black,
                    ),
                    // style: RegisterTableHead.customTextStyle(context),
                  )
              ),
            ],
          ),
        ),
        SizedBox(height: AppSize.s10,),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: currentPageItems.length,
            itemBuilder: (context, index) {
              int serialNumber =
                  index + 1 + (currentPage - 1) * itemsPerPage;
              String formattedSerialNumber =
              serialNumber.toString().padLeft(2, '0');
              return Column(
                children: [
                  SizedBox(height: AppSize.s5),
                  Container(
                    padding: EdgeInsets.only(bottom: AppPadding.p5),
                    margin: EdgeInsets.symmetric(horizontal: AppMargin.m50),
                    decoration: BoxDecoration(
                      color:ColorManager.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: AppSize.s56,

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                            child: Text(
                               formattedSerialNumber,
                              style: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff686464)
                                // color: isSelected ? Colors.white : Colors.black,
                              ),
                              // style: ThemeManagerDark.customTextStyle(context),
                              textAlign: TextAlign.start,
                            )),

                        Center(
                            child: Text(
                              AppString.pincode,
                              style: GoogleFonts.firaSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xff686464)
                                // color: isSelected ? Colors.white : Colors.black,
                              ),
                              // style: ThemeManagerDark.customTextStyle(context),
                            )),
                        Center(
                          child: Row(
                            children: [
                              Container(
                                height:30,
                                width: 30,
                                color: Color(0xffF37F81),
                                child: Center(child: Text(
                                  "PT",
                                  style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff686464)
                                    // color: isSelected ? Colors.white : Colors.black,
                                  ),
                                )),),
                              SizedBox(width: 3,),
                              Container(
                                height:30,
                                width: 30,
                                color: Color(0xfFE7E8E6),
                                child: Center(
                                    child: Text(
                                        "PTO",
                                      style: GoogleFonts.firaSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff686464)
                                        // color: isSelected ? Colors.white : Colors.black,
                                      ),
                                    )
                                )
                                ,
                              )],
                          ),
                        ),

                        Center(
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                                showDialog(context: context, builder: (BuildContext context){
                                  return AddVisitPopup(
                                    nameOfDocumentController: docNamecontroller, idOfDocumentController: docIdController, onSavePressed: () {  },
                                    child:  CICCDropdown(
                                      initialValue: 'Select',
                                      items: [
                                        DropdownMenuItem(value: 'Select', child: Text('Policies & Procedures')),
                                        DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                                        DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                                        DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                      ],),);
                                });
                              }, icon: Icon(Icons.edit_outlined,color: ColorManager.bluebottom,)),                              SizedBox(width: 3,),
                              Icon(Icons.delete_outline_outlined, size:20,color: Color(0xffF6928A),),
                            ],
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
        ///
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
