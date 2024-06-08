import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_corporate_compliance_doc/widgets/corporate_compliance_constants.dart';
import 'package:prohealth/presentation/screens/em_module/manage_emp_document/widgets/emp_doc_popup_const.dart';

class CompansationEmpDoc extends StatefulWidget {
  const CompansationEmpDoc({super.key});

  @override
  State<CompansationEmpDoc> createState() => _CompansationEmpDocState();
}

class _CompansationEmpDocState extends State<CompansationEmpDoc> {
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
                    'Sr No',
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
          SizedBox(
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
                                  color: Color(0xff000000).withOpacity(0.25),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
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
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  // Text(''),
                                  Text(
                                    "Void Check",textAlign:TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    "Not Applicable",textAlign:TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  Text(
                                    "Not Applicable",textAlign:TextAlign.center,
                                    style: GoogleFonts.firaSans(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff686464),
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
                                              initialValue: 'Compensation',
                                              items: [
                                                DropdownMenuItem(value: 'Compensation', child: Text('Compensation')),
                                                DropdownMenuItem(value: 'HCO Number      254612', child: Text('HCO Number  254612')),
                                                DropdownMenuItem(value: 'Medicare ID      MPID123', child: Text('Medicare ID  MPID123')),
                                                DropdownMenuItem(value: 'NPI Number     1234567890', child: Text('NPI Number 1234567890')),
                                              ],),);
                                        });
                                      }, icon: Icon(Icons.edit)),
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
          SizedBox(
            height: 10,
          ),
          Container(
            height: 30,
            // color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(6.39),
                    border: Border.all(
                      color: ColorManager.grey,
                      width: 0.79,
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.only(bottom: 1.5),
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        currentPage = currentPage > 1 ? currentPage - 1 : 1;
                      });
                    },
                    color: ColorManager.black,
                    iconSize: 20,
                  ),
                ),
                SizedBox(width: 3),
                for (var i = 1; i <= (items.length / itemsPerPage).ceil(); i++)
                  if (i == 1 ||
                      i == currentPage ||
                      i == (items.length / itemsPerPage).ceil())
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentPage = i;
                        });
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(left: 5, right: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: currentPage == i
                                ? ColorManager.blueprime
                                : ColorManager.grey,
                            width: currentPage == i ? 2.0 : 1.0,
                          ),
                          color: currentPage == i
                              ? ColorManager.blueprime
                              : Colors.transparent,
                          // border: Border.all(
                          //   color: currentPage == i
                          //       ? Colors.blue
                          //       : Colors.transparent,
                          // ),
                        ),
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: currentPage == i ? Colors.white : Colors.grey,
                            fontWeight: FontWeightManager.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  else if (i == currentPage - 1 || i == currentPage + 1)
                    Text(
                      '..',
                      style: TextStyle(
                        color: ColorManager.black,
                        fontWeight: FontWeightManager.bold,
                        fontSize: 12,
                      ),
                    ),
                Container(
                  width: 20,
                  height: 20,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.79,
                    ),
                  ),
                  child: IconButton(
                    padding: EdgeInsets.only(bottom: 2),
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        currentPage =
                        currentPage < (items.length / itemsPerPage).ceil()
                            ? currentPage + 1
                            : (items.length / itemsPerPage).ceil();
                      });
                    },
                    color: ColorManager.black,
                    iconSize: 20,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
