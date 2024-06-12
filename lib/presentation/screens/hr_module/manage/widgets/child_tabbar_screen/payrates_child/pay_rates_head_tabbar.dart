import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';

class PayRatesHeadTabbar extends StatefulWidget {
  const PayRatesHeadTabbar({super.key});

  @override
  State<PayRatesHeadTabbar> createState() => _PayRatesHeadTabbarState();
}

class _PayRatesHeadTabbarState extends State<PayRatesHeadTabbar> {
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
    String? _expiryType;
    return  Expanded(
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
                      AppString.znNo,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text('Type of Visit',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Text('Rate         ',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 55),
                      child: Text('Action',
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
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 7,
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
                              height: 40,
                              child: Stack(
                                children: [
                                  Container(
                                    width: 10,
                                    color: ColorManager.blueprime,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                        "Lab Drop off",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.firaSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff686464),
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      Text(
                                        "0.00",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.firaSans(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff686464),
                                          decoration: TextDecoration.none,
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                          width: 150,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Color(0xFFF6928A)),
                                          child: ElevatedButton(onPressed: (){},
                                              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF6928A)),
                                              child: Text('Delete',style: TextStyle(color: ColorManager.white),)))//  Text(''),
                                    ],
                                                                    ),
                                  ),]
                              )),
                        ),
                      ],
                    );
                  }),

            ),
            // RadioListTile<String>(
            //   title: Text('Per zone',
            //     style: GoogleFonts.firaSans(
            //       fontSize: FontSize.s10,
            //       fontWeight: FontWeightManager.medium,
            //       color: ColorManager.mediumgrey,
            //       decoration: TextDecoration.none,
            //     ),),
            //   value: 'Per zone',
            //   groupValue: _expiryType,
            //   onChanged: (value) {
            //     setState(() {
            //       _expiryType = value;
            //     });
            //   },
            // ),
            // Row(
            //   children: [
            //     RadioListTile<String>(
            //       title: Text('Per zone',
            //         style: GoogleFonts.firaSans(
            //           fontSize: FontSize.s10,
            //           fontWeight: FontWeightManager.medium,
            //           color: ColorManager.mediumgrey,
            //           decoration: TextDecoration.none,
            //         ),),
            //       value: 'Per zone',
            //       groupValue: _expiryType,
            //       onChanged: (value) {
            //         setState(() {
            //           _expiryType = value;
            //         });
            //       },
            //     ),
            //     RadioListTile<String>(
            //       title: Text('Per milege',
            //         style: GoogleFonts.firaSans(
            //           fontSize: FontSize.s10,
            //           fontWeight: FontWeightManager.medium,
            //           color: ColorManager.mediumgrey,
            //           decoration: TextDecoration.none,
            //         ),),
            //       value: 'type2',
            //       groupValue: _expiryType,
            //       onChanged: (value) {
            //         setState(() {
            //           _expiryType = value;
            //         });
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}


