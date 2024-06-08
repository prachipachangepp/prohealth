import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/model/company_data_model.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/ci_org_document.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/ci_role_manager.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/ci_tab_widget/ci_visit.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/hr_screen.dart';
import '../../../../../../app/services/api_sm/company_identity/add_doc_company_manager.dart';

class CompanyIdentityScreen extends StatefulWidget {
  final VoidCallback? onWhitelabellingPressed;
  const CompanyIdentityScreen({super.key, this.onWhitelabellingPressed});
  @override
  State<CompanyIdentityScreen> createState() => _CompanyIdentityScreenState();
}
class _CompanyIdentityScreenState extends State<CompanyIdentityScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();
  late CompanyIdentityManager _companyManager;
  final PageController _tabPageController = PageController();
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
    companyAllApi(context);
  }
  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _tabPageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          // padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 500,
              // color: Colors.green,
              child: Column(
                  children: [
                    /// visit , org , Document tab bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 400,
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () => _selectButton(0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Visit",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedIndex == 0 ?  ColorManager.blueprime : Colors.grey,
                                      ),
                                    ),
                                    Container(
                                      height: 2,
                                      width: 40,
                                      color: _selectedIndex == 0 ?  ColorManager.blueprime : Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => _selectButton(1),
                                child: Column(
                                  children: [
                                    Text(
                                      "Org Document",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedIndex == 1 ?  ColorManager.blueprime : Colors.grey,
                                      ),
                                    ),
                                    Container(
                                      height: 2,
                                      width: 60,
                                      color: _selectedIndex == 1 ?  ColorManager.blueprime : Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () => _selectButton(2),
                                child: Column(
                                  children: [
                                    Text(
                                      "Role Manager",
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: _selectedIndex == 2 ? ColorManager.blueprime : Colors.grey,
                                      ),
                                    ),
                                    Container(
                                      height: 2,
                                      width: 60,
                                      color: _selectedIndex == 2 ? ColorManager.blueprime: Colors.transparent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: NonScrollablePageView(
                        controller: _tabPageController,
                        onPageChanged: (index) {
                          setState(() {
                            _selectedIndex = index;
                          });
                        },
                        children: [
                          // Page 1
                          CiVisitScreen(),
                          // Page 2
                          CiOrgDocument(),
                          // Page 3
                          CiRoleManager()
                        ],
                      ),
                    ),

                    ///Company Identity screen data code
                    ///API integarted code do not delete
                    //           Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //             ///whitelabbeling
                    //             CustomButton(
                    //               borderRadius: 12,
                    //               text: 'Whitelabelling',
                    //               style: CustomTextStylesCommon.commonStyle(
                    //                   fontSize: FontSize.s12,
                    //                   fontWeight: FontWeightManager.bold,
                    //                   color: ColorManager.white),
                    //               width: 120,
                    //               height: 30,
                    //               onPressed: () {
                    //                 if (widget.onWhitelabellingPressed != null) {
                    //                   widget.onWhitelabellingPressed!();
                    //                 }
                    //
                    //               },
                    //             ),
                    //             SizedBox(
                    //               width: AppSize.s30,
                    //             ),
                    //             ///add new office
                    //             CustomIconButtonConst(
                    //               text: 'Add New Office',
                    //               onPressed: () {
                    //                 showDialog(
                    //                   context: context,
                    //                   builder: (BuildContext context) {
                    //                     return AlertDialog(
                    //                         backgroundColor: Colors.white,
                    //                         content: Container(
                    //                           height: 450,
                    //                           width: 300,
                    //                           child: Column(
                    //                             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                             children: [
                    //                               Row(
                    //                                 mainAxisAlignment: MainAxisAlignment.end,
                    //                                 crossAxisAlignment: CrossAxisAlignment.end,
                    //                                 children: [
                    //                                   IconButton(
                    //                                       onPressed: () {
                    //                                         Navigator.pop(context);
                    //                                       },
                    //                                       icon: Icon(Icons.close))
                    //                                 ],
                    //                               ),
                    //                               Column(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment.spaceBetween,
                    //                                 children: [
                    //                                   SMTextFConst(
                    //                                     controller: nameController,
                    //                                     keyboardType: TextInputType.text,
                    //                                     text: 'Name',
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 7,
                    //                                   ),
                    //                                   SMTextFConst(
                    //                                     controller: addressController,
                    //                                     keyboardType: TextInputType.streetAddress,
                    //                                     text: 'Address',
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 7,
                    //                                   ),
                    //                                   SMTextFConst(
                    //                                     controller: emailController,
                    //                                     keyboardType: TextInputType.emailAddress,
                    //                                     text: 'Email',
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 7,
                    //                                   ),
                    //                                   SMTextFConst(
                    //                                     controller: mobNumController,
                    //                                     keyboardType: TextInputType.number,
                    //                                     text: 'Primary Phone',
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 7,
                    //                                   ),
                    //                                   SMTextFConst(
                    //                                     controller: secNumController,
                    //                                     keyboardType: TextInputType.number,
                    //                                     text: 'Secondary Phone',
                    //                                   ),
                    //                                   SizedBox(
                    //                                     height: 7,
                    //                                   ),
                    //                                   SMTextFConst(
                    //                                     controller: OptionalController,
                    //                                     keyboardType: TextInputType.number,
                    //                                     text: 'Alternative Phone',
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               SizedBox(
                    //                                 height: 40,
                    //                               ),
                    //                               CustomElevatedButton(
                    //                                   width: 105,
                    //                                   height: 31,
                    //                                   text: 'Submit',
                    //                                   onPressed: () {
                    //                                     addNewOffice(
                    //                                         context,
                    //                                         nameController.text,
                    //                                         addressController.text,
                    //                                         emailController.text,
                    //                                         mobNumController.text,
                    //                                         secNumController.text);
                    //                                     Navigator.pop(context);
                    //                                     companyAllApi(context);
                    // // Navigator.push(
                    // //     context,
                    // //     MaterialPageRoute(
                    // //         builder: (context) =>
                    // //             LoginScreen()));
                    //                                   })
                    //                             ],
                    //                           ),
                    //                         ));
                    //                   },
                    //                 );
                    //               },
                    //               icon: Icons.add,
                    //             )
                    //           ],
                    //         ),
                    //           SizedBox(height: 20),
                    //          ///heading row
                    //           Container(
                    //           height: 30,
                    //           decoration: BoxDecoration(
                    //             color: Colors.grey,
                    //             borderRadius: BorderRadius.circular(12),
                    //           ),
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //             children: [
                    //               Text(''),
                    //               Text(
                    //                 'Sr No',
                    //                 style: GoogleFonts.firaSans(
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w700,
                    //                   color: Colors.white,
                    //                   decoration: TextDecoration.none,
                    //                 ),
                    //               ),
                    // // SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                    //               Text('Office Name',
                    //                   style: GoogleFonts.firaSans(
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.w700,
                    //                     color: Colors.white,
                    //                     decoration: TextDecoration.none,
                    //                   )),
                    //
                    // //SizedBox(width: MediaQuery.of(context).size.width/5.5,),
                    //               Text('Address  ',
                    //                   textAlign: TextAlign.start,
                    //                   style: GoogleFonts.firaSans(
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.w700,
                    //                     color: Colors.white,
                    //                     decoration: TextDecoration.none,
                    //                   )),
                    // // SizedBox(height: 1,),
                    // //SizedBox(width: MediaQuery.of(context).size.width/150,),
                    //               Text('Actions',
                    //                   textAlign: TextAlign.start,
                    //                   style: GoogleFonts.firaSans(
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.w700,
                    //                     color: Colors.white,
                    //                     decoration: TextDecoration.none,
                    //                   )),
                    //             ],
                    //           ),
                    //         ),
                    //           SizedBox(
                    //           height: 10,
                    //         ),
                    //          ///list
                    //           Expanded(
                    //           child: FutureBuilder<List<CompanyModel>>(
                    //             future: companyAllApi(context),
                    //             builder: (BuildContext context, snapshot) {
                    //               if (snapshot.connectionState == ConnectionState.waiting) {
                    //                 return Center(
                    //                   child: CircularProgressIndicator(
                    //                     color: ColorManager.blueprime,
                    //                   ),
                    //                 );
                    //               }
                    //               if (snapshot.hasData) {
                    //                 return ListView.builder(
                    //                     scrollDirection: Axis.vertical,
                    //                     itemCount: snapshot.data!.length,
                    //                     itemBuilder: (context, index) {
                    //                       int serialNumber =
                    //                           index + 1 + (currentPage - 1) * itemsPerPage;
                    //                       return Column(
                    //                         crossAxisAlignment: CrossAxisAlignment.start,
                    //                         children: [
                    //                           SizedBox(height: 5),
                    //                           Container(
                    //                               decoration: BoxDecoration(
                    //                                 color: Colors.white,
                    //                                 borderRadius: BorderRadius.circular(4),
                    //                                 boxShadow: [
                    //                                   BoxShadow(
                    //                                     color: Color(0xff000000).withOpacity(0.25),
                    //                                     spreadRadius: 0,
                    //                                     blurRadius: 4,
                    //                                     offset: Offset(0, 2),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                               height: 50,
                    //                               child: Row(
                    //                                 mainAxisAlignment:
                    //                                     MainAxisAlignment.spaceEvenly,
                    //                                 children: [
                    //                                   IconButton(
                    //                                       onPressed: () {},
                    //                                       icon: Icon(
                    //                                         Icons.menu_sharp,
                    //                                         color: Color(0xff686464),
                    //                                       )),
                    //                                   Text('  '),
                    //                                   Text(
                    //                                     snapshot.data![index].companyId.toString(),
                    //                                     // formattedSerialNumber,
                    //                                     style: GoogleFonts.firaSans(
                    //                                       fontSize: 10,
                    //                                       fontWeight: FontWeight.w500,
                    //                                       color: Color(0xff686464),
                    //                                       decoration: TextDecoration.none,
                    //                                     ),
                    //                                   ),
                    //                                   Text(''),
                    //                                   Text(
                    //                                     snapshot.data![index].name.toString(),
                    //                                     style: GoogleFonts.firaSans(
                    //                                       fontSize: 10,
                    //                                       fontWeight: FontWeight.w500,
                    //                                       color: Color(0xff686464),
                    //                                       decoration: TextDecoration.none,
                    //                                     ),
                    //                                   ),
                    //                                   Text(''),
                    //                                   Text(
                    //                                     snapshot.data![index].address.toString(),
                    //                                     textAlign: TextAlign.end,
                    //                                     style: GoogleFonts.firaSans(
                    //                                       fontSize: 10,
                    //                                       fontWeight: FontWeight.w500,
                    //                                       color: Color(0xff686464),
                    //                                       decoration: TextDecoration.none,
                    //                                     ),
                    //                                   ),
                    //                                   Text(''),
                    //
                    //                                   CustomButtonTransparentSM(
                    //                                       text: 'Manage', onPressed: () {
                    //
                    //                                   })
                    //                                 ],
                    //                               )),
                    //                         ],
                    //                       );
                    //                     });
                    //               }
                    //               return Scaffold();
                    //             },
                    //           ),
                    //         ),
                    //           SizedBox(
                    //           height: 10,
                    //         ),
                    //           Container(
                    //           height: 30,
                    //           // color: Colors.black12,
                    //           child: Row(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: <Widget>[
                    //               Container(
                    //                 width: 20,
                    //                 height: 20,
                    //                 decoration: BoxDecoration(
                    //                   shape: BoxShape.rectangle,
                    //                   borderRadius: BorderRadius.circular(6.39),
                    //                   border: Border.all(
                    //                     color: ColorManager.grey,
                    //                     width: 0.79,
                    //                   ),
                    //                 ),
                    //                 child: IconButton(
                    //                   padding: EdgeInsets.only(bottom: 1.5),
                    //                   icon: Icon(Icons.chevron_left),
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       currentPage = currentPage > 1 ? currentPage - 1 : 1;
                    //                     });
                    //                   },
                    //                   color: ColorManager.black,
                    //                   iconSize: 20,
                    //                 ),
                    //               ),
                    //               SizedBox(width: 3),
                    //               for (var i = 1; i <= (items.length / itemsPerPage).ceil(); i++)
                    //                 if (i == 1 ||
                    //                     i == currentPage ||
                    //                     i == (items.length / itemsPerPage).ceil())
                    //                   InkWell(
                    //                     onTap: () {
                    //                       setState(() {
                    //                         currentPage = i;
                    //                       });
                    //                     },
                    //                     child: Container(
                    //                       width: 20,
                    //                       height: 20,
                    //                       margin: EdgeInsets.only(left: 5, right: 5),
                    //                       alignment: Alignment.center,
                    //                       decoration: BoxDecoration(
                    //                         shape: BoxShape.rectangle,
                    //                         borderRadius: BorderRadius.circular(4),
                    //                         border: Border.all(
                    //                           color: currentPage == i
                    //                               ? ColorManager.blueprime
                    //                               : ColorManager.grey,
                    //                           width: currentPage == i ? 2.0 : 1.0,
                    //                         ),
                    //                         color: currentPage == i
                    //                             ? ColorManager.blueprime
                    //                             : Colors.transparent,
                    //                         // border: Border.all(
                    //                         //   color: currentPage == i
                    //                         //       ? Colors.blue
                    //                         //       : Colors.transparent,
                    //                         // ),
                    //                       ),
                    //                       child: Text(
                    //                         '$i',
                    //                         style: TextStyle(
                    //                           color: currentPage == i ? Colors.white : Colors.grey,
                    //                           fontWeight: FontWeightManager.bold,
                    //                           fontSize: 12,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   )
                    //                 else if (i == currentPage - 1 || i == currentPage + 1)
                    //                   Text(
                    //                     '..',
                    //                     style: TextStyle(
                    //                       color: ColorManager.black,
                    //                       fontWeight: FontWeightManager.bold,
                    //                       fontSize: 12,
                    //                     ),
                    //                   ),
                    //               Container(
                    //                 width: 20,
                    //                 height: 20,
                    //                 alignment: Alignment.center,
                    //                 decoration: BoxDecoration(
                    //                   shape: BoxShape.rectangle,
                    //                   borderRadius: BorderRadius.circular(4),
                    //                   border: Border.all(
                    //                     color: Colors.grey,
                    //                     width: 0.79,
                    //                   ),
                    //                 ),
                    //                 child: IconButton(
                    //                   padding: EdgeInsets.only(bottom: 2),
                    //                   icon: Icon(Icons.chevron_right),
                    //                   onPressed: () {
                    //                     setState(() {
                    //                       currentPage =
                    //                           currentPage < (items.length / itemsPerPage).ceil()
                    //                               ? currentPage + 1
                    //                               : (items.length / itemsPerPage).ceil();
                    //                     });
                    //                   },
                    //                   color: ColorManager.black,
                    //                   iconSize: 20,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         )
                  ]),
            ),
          ),
        ));
  }
}
///

class NonScrollablePageView extends StatelessWidget {
  final PageController controller;
  final ValueChanged<int> onPageChanged;
  final List<Widget> children;
  const NonScrollablePageView({
    Key? key,
    required this.controller,
    required this.onPageChanged,
    required this.children,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) => true,
      child: PageView(
        controller: controller,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(), // Disables scrolling
        children: children,
      ),
    );
  }
}
