import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_insurance/ci_insurance_pageview.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/company_identity_details.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/emp_documents/clinical_verification.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/emp_documents/employmentDoc.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/emp_documents/acknowledgement.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/emp_documents/certifications.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/emp_documents/compansation.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/emp_documents/health.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/emp_documents/performance.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';

class ManageEmployDocument extends StatefulWidget {
  const ManageEmployDocument({super.key});

  @override
  State<ManageEmployDocument> createState() => _ManageEmployDocumentState();
}

class _ManageEmployDocumentState extends State<ManageEmployDocument> {
  final PageController _managePageController = PageController();
  int _selectedIndex = 0;

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
  final List<String> _categories = [
    'Health',
    'Certifications',
    'Employment',
    'Clinical Verification',
    'Acknowledgement',
    'Compensation',
    'Performance'
  ];

  final PageController _managePageController = PageController();

  int _selectedIndex = 0;

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
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p50,vertical: AppPadding.p20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomIconButtonConst(text: 'Add Document', onPressed: (){
                  // showDialog(context: context, builder: (BuildContext context){
                  //   return EmpDocEditPopup(idDocController: idDocController, nameDocController: nameDocController, onSavePressed: () {  },
                  //     child:  CICCDropdown(
                  //       initialValue: 'Health',
                  //       items: [
                  //         DropdownMenuItem(value: 'Health', child: Text('Health')),
                  //         DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                  //         DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                  //         DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                  //       ],),);
                  // });
                },icon: Icons.add,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 28,
                    width: MediaQuery.of(context).size.width / 1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorManager.blueprime,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _categories
                          .asMap()
                          .entries
                          .map(
                            (entry) => InkWell(
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 8.42,
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: widget.selectedIndex == entry.key
                                  ? Colors.white
                                  : null,
                            ),
                            child: Text(
                              entry.value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeightManager.semiBold,
                                color: widget.selectedIndex == entry.key
                                    ? ColorManager.mediumgrey
                                    : Colors.white,
                              ),
                            ),
                          ),
                          onTap: () => widget.selectButton(entry.key),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Expanded(
            flex: 10,
            child: Stack(

              children: [
                Container(height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(color: Color(0xFFF2F9FC),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      boxShadow: [ BoxShadow(
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
                    controller: widget.managePageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: const [
                      HealthEmpDoc(),
                      CertificationEmpDoc(),
                      EmplomentDoc(),
                      ClinicalVerificationEmpDoc(),
                      AcknowledgementEmpDoc(),
                      CompansationEmpDoc(),
                      PerformanceEmpDoc(),
                    ]),
              ),]
            ),
          ),
        ],
      ),
    );
  }
}

