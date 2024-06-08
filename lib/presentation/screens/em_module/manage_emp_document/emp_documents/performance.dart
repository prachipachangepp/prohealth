import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/widgets/emp_doc_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';

class PerformanceEmpDoc extends StatefulWidget {
  const PerformanceEmpDoc({super.key});

  @override
  State<PerformanceEmpDoc> createState() => _PerformanceEmpDocState();
}

class _PerformanceEmpDocState extends State<PerformanceEmpDoc> {
  TextEditingController nameDocController = TextEditingController();
  TextEditingController idDocController = TextEditingController();
  late CompanyIdentityManager _companyManager;
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 5;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    _companyManager = CompanyIdentityManager();
    // companyAllApi(context);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                  // Text(''),
                  Text(
                    'Sr No.',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                  Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Text('Name   ',textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ),
                  Text(
                    'Expiry  ',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    'Reminder Threshold',
                    style: GoogleFonts.firaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text('Actions',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child:
            ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 5,
                itemBuilder: (context, index) {
                  // int serialNumber =
                  //     index + 1 + (currentPage - 1) * itemsPerPage;
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
                                  Text(
                                    "01",
                                    // formattedSerialNumber,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  // Text(''),
                                  Text(
                                    "Personnel Counselling/ Disciplinary Docs",textAlign:TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    "Not Applicable",textAlign:TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    "Not Applicable",textAlign:TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  //  Text(''),
                                  Row(
                                    children: [
                                      IconButton(onPressed: (){
                                        showDialog(context: context, builder: (BuildContext context){
                                          return EmpDocEditPopup(idDocController: idDocController, nameDocController: nameDocController, onSavePressed: () {  },
                                            child:  CICCDropdown(
                                              initialValue: 'Performance',
                                              items: [
                                                DropdownMenuItem(value: 'Performance', child: Text('Performance')),
                                                DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                                                DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                                                DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                              ],),);
                                        });
                                      }, icon: const Icon(Icons.edit_outlined)),
                                      IconButton(onPressed: (){}, icon: Icon(Icons.delete_outline,color: ColorManager.red,)),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                    ],
                  );
                }),
          ),
          const SizedBox(
            height: 10,
          ),
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
      ),
    );
  }
}
