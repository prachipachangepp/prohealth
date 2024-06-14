import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';

import '../../../../../../../app/resources/hr_resources/string_manager.dart';

class InventoryHeadTabbar extends StatefulWidget {
  const InventoryHeadTabbar({super.key});

  @override
  State<InventoryHeadTabbar> createState() => _InventoryHeadTabbarState();
}

class _InventoryHeadTabbarState extends State<InventoryHeadTabbar> {
  TextEditingController vendorName = TextEditingController();

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
    return Expanded(
      child: Container(
        //height: MediaQuery.of(context).size.height/3,
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
                      AppString.srNo,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
      //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                    Text(AppStringHr.inventoryid,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text(AppStringHr.docName,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('Device Description',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('Assign Date',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
      

                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: 8,
                          itemBuilder: (context, index) {
                            int serialNumber =
                                index + 1 + (currentPage - 1) * itemsPerPage;
                            String formattedSerialNumber =
                            serialNumber.toString().padLeft(2, '0');
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xff000000)
                                                .withOpacity(0.25),
                                            spreadRadius: 0,
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      height: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              formattedSerialNumber,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            // Text(''),
                                            Text(
                                              "8374682",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            Text(
                                              "Lorem Ipsum is simply dummy text of the printing",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            Text(
                                              "Cellular",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            Text(
                                              "22-03-23",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                            //  Text(''),
                                          ],
                                        ),
                                      )),
                                ),
                              ],
                            );
                          }),
      
            ),
          ],
        ),
      ),
    );
  }
}

// Column(
// children: [
// Container(
// height: 30,
// margin: EdgeInsets.symmetric(horizontal: 35),
// decoration: BoxDecoration(
// color: Colors.grey,
// borderRadius: BorderRadius.circular(12),
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Center(
// child: Text(
// 'Sr No.',
// style: RegisterTableHead.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'ID of the Inventory',
// style: RegisterTableHead.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Name of the Document',
// style: RegisterTableHead.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Device Description',
// style: RegisterTableHead.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Assign Date',
// style: RegisterTableHead.customTextStyle(context),
// )),
// ],
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Expanded(
// child: ListView.builder(
// scrollDirection: Axis.vertical,
// itemCount: 10,
// itemBuilder: (context, index) {
// return Column(
// children: [
// SizedBox(height: 5),
// Container(
// padding: EdgeInsets.only(bottom: 5),
// margin: EdgeInsets.symmetric(horizontal: 50),
// decoration: BoxDecoration(
// color:Colors.white,
// borderRadius: BorderRadius.circular(4),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 1,
// blurRadius: 4,
// offset: Offset(0, 2),
// ),
// ],
// ),
// height: 56,
//
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Center(
// child: Text(
// '01',style: ThemeManagerDark.customTextStyle(context),
// textAlign: TextAlign.start,
// )),
// Center(
// child: Text(
// '8374682',
// textAlign: TextAlign.start,
// style: ThemeManagerDark.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Lorem Ipsum is simply dummy text of the printing',
// style: ThemeManagerDark.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Cellular',
// style: ThemeManagerDark.customTextStyle(context),
// )),
// Center(
// child: Text(
// '22-03-23',
// style: ThemeManagerDark.customTextStyle(context),
// )),
// ],
// ),
// ),
// ],
// );
// },
// ),
// ),
// ],
// );