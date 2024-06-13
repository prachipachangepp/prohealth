import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';

class TimeOffHeadTabbar extends StatefulWidget {
  const TimeOffHeadTabbar({super.key});

  @override
  State<TimeOffHeadTabbar> createState() => _TimeOffHeadTabbarState();
}

class _TimeOffHeadTabbarState extends State<TimeOffHeadTabbar> {
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
                      AppString.znNo,
                      style: GoogleFonts.firaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    //SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                    Text('Action',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('Time off Request',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('Reason',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('Hours',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('Start Time',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('End Time',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('Sick Time',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('  ',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('  ',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        )),
                    Text('  ',
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
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 10,
                                                backgroundColor: ColorManager.faintGrey,
                                              ),
                                              Text(
                                                "John Thomas",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.firaSans(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff686464),
                                                  decoration: TextDecoration.none,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "1 Day",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          Text(
                                            "Headache",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          Text(
                                            "12 Hours",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          Text(
                                            "13 April 2023 10.00 AM",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          Text(
                                            "15 April 2023 5.00 PM",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          Text(
                                            "2 days",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.firaSans(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff686464),
                                              decoration: TextDecoration.none,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButtonWidget(buttonText: "Approve", onPressed: (){}),
                                              IconButtonWidget(buttonText: "Reject", onPressed: (){}),
                                              IconButtonWidget(buttonText: "Edit", onPressed: (){})
                                            ],
                                          )
                                         //  Text(''),
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
