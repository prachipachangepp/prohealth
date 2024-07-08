import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/employee_doc_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/org_doc_ccd.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/emp_documents/health.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/emp_documents/performance.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_employee_documents/widgets/radio_button_tile_const.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/widgets/admin_emp_data.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../data/api_data/establishment_data/employee_doc/employee_doc_data.dart';

class ManageEmployDocument extends StatefulWidget {

  const ManageEmployDocument({super.key});

  @override
  State<ManageEmployDocument> createState() => _ManageEmployDocumentState();
}

class _ManageEmployDocumentState extends State<ManageEmployDocument> {
  final PageController _managePageController = PageController();
  int _selectedIndex = 1;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _managePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ManageEmpDocWidget(
      managePageController: _managePageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
    );
  }
}

class ManageEmpDocWidget extends StatefulWidget {
  final PageController managePageController;
  final int selectedIndex;
  final Function(int) selectButton;
  ManageEmpDocWidget({
    Key? key,
    required this.managePageController,
    required this.selectedIndex,
    required this.selectButton,
  }) : super(key: key);

  @override
  State<ManageEmpDocWidget> createState() => _ManageEmpDocWidgetState();
}

class _ManageEmpDocWidgetState extends State<ManageEmpDocWidget> {
  TextEditingController nameDocController = TextEditingController();
  TextEditingController idDocController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // final List<String> _categories = [
  //   'Health',
  //   'Certifications',
  //   'Employment',
  //   'Clinical Verification',
  //   'Acknowledgement',
  //   'Compensation',
  //   'Performance'
  // ];

  final PageController _managePageController = PageController();

  int _selectedIndex = 1;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _managePageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmployeeDocTab(context);
  }
  String selectType = "Health";
  void onChange(String select){
    setState(() {
      selectType = select;
    });
  }
  void radioOnChnage(String select){
    setState(() {
      expiryType = select;
    });
  }

  var metaDocID = 1;
  String? expiryType;
  int docMetaId = 0;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          _selectedIndex == 1 ? Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p50,
                vertical: AppPadding.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconButtonConst(text: 'Add Document', onPressed: (){
                  showDialog(context: context, builder: (BuildContext context){
                    return EmpDocEditPopup(
                      title:  'Add Document',
                      //expiryType: expiryType,
                      idDocController: idDocController, nameDocController: nameDocController,
                      calenderController: dateController,
                      onSavePredded: () async{
                      await addEmployeeDocSetup(context,
                          docMetaId,
                          nameDocController.text,
                          expiryType.toString(),
                          dateController.text);
                      Navigator.pop(context);
                      nameDocController.clear();
                      dateController.clear();
                      },
                    radioButton: StatefulBuilder(
                      builder: (BuildContext context, void Function(void Function()) setState) {
                       return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRadioListTile(
                              value: "Not Applicable",
                              groupValue: expiryType.toString(),
                              onChanged: (value) {
                                setState(() {
                                  expiryType = value!;
                                });
                              },
                              title: "Not Applicable",
                            ),
                            CustomRadioListTile(
                              value: 'Scheduled',
                              groupValue: expiryType.toString(),
                              onChanged: (value) {
                                setState(() {
                                  expiryType = value!;
                                });
                              },
                              title: 'Scheduled',
                            ),
                            CustomRadioListTile(
                              value: 'Issuer Expiry',
                              groupValue: expiryType.toString(),
                              onChanged: (value) {
                                setState(() {
                                  expiryType = value!;
                                });
                              },
                              title: 'Issuer Expiry',
                            ),
                          ],
                        );
                      },

                    ),
                      child:  FutureBuilder<List<EmployeeDocTabModal>>(
                        future: getEmployeeDocTab(context),
                        builder: (context,snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 350,
                                  height: 30,
                                  decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                )
                            );
                          }
                          if (snapshot.data!.isEmpty) {
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
                          if(snapshot.hasData){
                            List dropDown = [];
                            int docType = 0;
                            List<DropdownMenuItem<String>> dropDownMenuItems = [];
                            for(var i in snapshot.data!){
                              dropDownMenuItems.add(
                                  DropdownMenuItem<String>(
                                    child: Text(i.employeeDocType),
                                    value: i.employeeDocType,
                                  ),
                              );
                            }
                            return CICCDropdown(
                              initialValue: dropDownMenuItems[0].value,
                              onChange: (val){
                                for(var a in snapshot.data!){
                                  if(a.employeeDocType == val){
                                    docType = a.employeeDocMetaDataId;
                                    docMetaId = docType;
                                  }
                                }
                                print(":::${docType}");
                                print(":::<>${docMetaId}");
                              },
                              items:dropDownMenuItems
                            );
                          }else{
                            return SizedBox();
                          }
                        }
                      ),);
                  });
                },icon: Icons.add,)
              ],
            ),
          ) : const SizedBox(height: 72,),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder<List<EmployeeDocTabModal>>(
                  future: getEmployeeDocTab(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 28,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorManager.blueprime,
                            // color: Colors.yellow,
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index){
                              if (snapshot.connectionState == ConnectionState.waiting){
                              }
                              if (snapshot.hasData){
                                return  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                        InkWell(
                                          child: Container(
                                            height: 30,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 8.42,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: _selectedIndex ==
                                                  snapshot.data![index].employeeDocMetaDataId
                                                  ? ColorManager.white
                                                  : Colors.transparent,
                                            ),
                                            child: Text(
                                              snapshot.data![index].employeeDocType,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 12,
                                                fontWeight: FontWeightManager
                                                    .semiBold,
                                                color: _selectedIndex ==
                                                    snapshot.data![index].employeeDocMetaDataId
                                                    ? ColorManager.mediumgrey
                                                    : ColorManager.white,
                                              ),
                                            ),
                                          ),
                                           onTap: () {
                                           _selectButton(snapshot.data![index].employeeDocMetaDataId);
                                           metaDocID = snapshot.data![index].employeeDocMetaDataId;
                                           }
                                        ),
                                ]);
                              }
                            }
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(height: 1,width: 1,);
                    }
                  }),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            flex: 10,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                     color: Color(0xFFF2F9FC),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                        color: ColorManager.faintGrey,
                        blurRadius: 2,
                        spreadRadius: -2,
                        offset: Offset(0, -4),
                      ),]
                  ),),
                Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 45,right: MediaQuery.of(context).size.width / 45,
                    top: MediaQuery.of(context).size.width / 45),
                child: PageView(
                    controller: _managePageController,
                    onPageChanged: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                       HealthEmpDoc(metaDocID: metaDocID),
                       HealthEmpDoc(metaDocID: metaDocID),
                       HealthEmpDoc(metaDocID: metaDocID),
                       HealthEmpDoc(metaDocID: metaDocID),
                       HealthEmpDoc(metaDocID: metaDocID),
                       HealthEmpDoc(metaDocID: metaDocID),
                       HealthEmpDoc(metaDocID: metaDocID),
                       HealthEmpDoc(metaDocID: metaDocID),
                      // CertificationEmpDoc(metaDocID: metaDocID,),
                      // EmplomentDoc(metaDocID: metaDocID,),
                      // ClinicalVerificationEmpDoc(metaDocID: metaDocID,),
                      // AcknowledgementEmpDoc(metaDocID: metaDocID,),
                      // CompansationEmpDoc(metaDocID: metaDocID,),
                      // PerformanceEmpDoc(metaDocID: metaDocID,),
                    ]),
              ),]
            ),
          ),
        ],
      ),
    );
  }
}

