import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/manage_button_screen.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/whitelabelling_screen.dart';
import '../../../../../../data/api_data/establishment_data/company_identity/company_identity_data_.dart';
import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';
import '../../../../../../app/services/api/managers/establishment_manager/company_identrity_manager.dart';
import '../../../../../../app/services/api_sm/company_identity/add_doc_company_manager.dart';
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
  late CompanyIdentityManager _companyManager;
  final StreamController<List<CompanyModel>> _controller = StreamController<List<CompanyModel>>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobNumController = TextEditingController();
  TextEditingController secNumController = TextEditingController();
  TextEditingController OptionalController = TextEditingController();
  final StreamController<List<CompanyIdentityModel>> _companyIdentityController = StreamController<List<CompanyIdentityModel>>();
  final PageController _pageController = PageController();
  late int currentPage;
  late int itemsPerPage;
  late List<String> items;
  bool showStreamBuilder = true;
  bool showManageScreen = false; // New state variable

  @override
  void initState() {
    super.initState();
    currentPage = 1;
    itemsPerPage = 5;
    items = List.generate(20, (index) => 'Item ${index + 1}');
    _companyManager = CompanyIdentityManager();
    companyOfficeListGet(context, 0, 1, 6).then((data) {
      _companyIdentityController.add(data);
    }).catchError((error) {
      // Handle error
    });
  }

  void toggleView(bool showStream) {
    setState(() {
      showStreamBuilder = showStream;
      showManageScreen = false;
    });
  }

  void showManageScreenFunction() {
    setState(() {
      showManageScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!showManageScreen)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  borderRadius: 12,
                  text: 'Whitelabelling',
                  style: CustomTextStylesCommon.commonStyle(
                      fontSize: FontSize.s12,
                      fontWeight: FontWeightManager.bold,
                      color: ColorManager.white),
                  width: 120,
                  height: 30,
                  onPressed: () {
                    toggleView(false);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: CustomIconButtonConst(
                  text: 'Add New Office',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            backgroundColor: Colors.white,
                            content: Container(
                              height: 450,
                              width: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.close))
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      SMTextFConst(
                                        controller: nameController,
                                        keyboardType: TextInputType.text,
                                        text: 'Name',
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: addressController,
                                        keyboardType: TextInputType.streetAddress,
                                        text: 'Address',
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        text: 'Email',
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: mobNumController,
                                        keyboardType: TextInputType.number,
                                        text: 'Primary Phone',
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: secNumController,
                                        keyboardType: TextInputType.number,
                                        text: 'Secondary Phone',
                                      ),
                                      SizedBox(
                                        height: 7,
                                      ),
                                      SMTextFConst(
                                        controller: OptionalController,
                                        keyboardType: TextInputType.number,
                                        text: 'Alternative Phone',
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  CustomElevatedButton(
                                      width: 105,
                                      height: 31,
                                      text: 'Submit',
                                      onPressed: () async{
                                        await addNewOffice(
                                            context,
                                            nameController.text,
                                            addressController.text,
                                            emailController.text,
                                            mobNumController.text,
                                            secNumController.text
                                        );
                                        companyOfficeListGet(context,0,1,6).then((data) {
                                          _companyIdentityController.add(data);
                                        }).catchError((error) {
                                        });
                                        Navigator.pop(context);
                                      })
                                ],
                              ),
                            ));
                      },
                    );
                  },
                  icon: Icons.add,
                ),
              )
            ],
          ),
        if (!showManageScreen)
          SizedBox(height: 10),
        if (!showManageScreen)
          Column(
            children: [
              Container(
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: 50),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: 25),
                    Padding(
                      padding: EdgeInsets.only(left: 85),
                      child: Text(
                        "Sr No.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Text(
                        "Office Name",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 70),
                      child: Text(
                        "Address",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text(
                        "Actions",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        if (!showManageScreen)
          Expanded(
            child: showStreamBuilder
                ? StreamBuilder<List<CompanyIdentityModel>>(
              stream: _companyIdentityController.stream,
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Center(
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
                  (currentPage - 1) * itemsPerPage;
                  (currentPage * itemsPerPage) > totalItems
                      ? totalItems
                      : (currentPage * itemsPerPage);

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                      String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            margin: EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 56,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.menu_sharp,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  formattedSerialNumber,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  snapshot.data![index].officeName.toString(),
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                Text(
                                  snapshot.data![index].address.toString(),
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.firaSans(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff686464),
                                  ),
                                ),
                                CustomButtonTransparentSM(
                                  text: 'Manage',
                                  onPressed: showManageScreenFunction,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
                return Scaffold();
              },
            )
                : PageView(
              controller: _pageController,
              children: [
                Container(
                  child: WhitelabellingScreen(),
                ),
              ],
            ),
          ),
        if (showManageScreen)
          Expanded(
            child: ManagePopUpScreen(), // Replace with your actual ManageScreen widget
          ),
      ],
    );
  }
}
////
// class CompanyIdentity extends StatefulWidget {
//   const CompanyIdentity({Key? key}) : super(key: key);
//
//   @override
//   State<CompanyIdentity> createState() => _CompanyIdentityState();
// }
//
// class _CompanyIdentityState extends State<CompanyIdentity> {
//   late CompanyIdentityManager _companyManager;
//   final StreamController<List<CompanyModel>> _controller = StreamController<List<CompanyModel>>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobNumController = TextEditingController();
//   TextEditingController secNumController = TextEditingController();
//   TextEditingController OptionalController = TextEditingController();
//   final StreamController<List<CompanyIdentityModel>> _companyIdentityController = StreamController<List<CompanyIdentityModel>>();
//   final PageController _pageController = PageController();
//   late int currentPage;
//   late int itemsPerPage;
//   late List<String> items;
//   bool showStreamBuilder = true;
//   bool showHeadings = true;
//   bool showManageScreen = false;
//
//   @override
//   void initState() {
//     super.initState();
//     currentPage = 1;
//     itemsPerPage = 5;
//     items = List.generate(20, (index) => 'Item ${index + 1}');
//     _companyManager = CompanyIdentityManager();
//     companyOfficeListGet(context,0,1,6 ).then((data) {
//       _companyIdentityController.add(data);
//     }).catchError((error) {
//       // Handle error
//     });
//
//   }
//
//   void toggleView(bool showStream) {
//     setState(() {
//       showStreamBuilder = showStream;
//       showHeadings = showStream;
//     });
//   }
//   void showManageScreenFunction() {
//     setState(() {
//       showManageScreen = true;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         /// Buttons
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             /// Whitelabelling
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomButton(
//                 borderRadius: 12,
//                 text: 'Whitelabelling',
//                 style: CustomTextStylesCommon.commonStyle(
//                     fontSize: FontSize.s12,
//                     fontWeight: FontWeightManager.bold,
//                     color: ColorManager.white),
//                 width: 120,
//                 height: 30,
//                 onPressed: () {
//                   toggleView(false);
//
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 50),
//               child: CustomIconButtonConst(
//                 text: 'Add New Office',
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                           backgroundColor: Colors.white,
//                           content: Container(
//                             height: 450,
//                             width: 300,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     IconButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         icon: Icon(Icons.close))
//                                   ],
//                                 ),
//                                 Column(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SMTextFConst(
//                                       controller: nameController,
//                                       keyboardType: TextInputType.text,
//                                       text: 'Name',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: addressController,
//                                       keyboardType: TextInputType.streetAddress,
//                                       text: 'Address',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: emailController,
//                                       keyboardType: TextInputType.emailAddress,
//                                       text: 'Email',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: mobNumController,
//                                       keyboardType: TextInputType.number,
//                                       text: 'Primary Phone',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: secNumController,
//                                       keyboardType: TextInputType.number,
//                                       text: 'Secondary Phone',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: OptionalController,
//                                       keyboardType: TextInputType.number,
//                                       text: 'Alternative Phone',
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 40,
//                                 ),
//                                 CustomElevatedButton(
//                                     width: 105,
//                                     height: 31,
//                                     text: 'Submit',
//                                     onPressed: () async{
//                                       await addNewOffice(
//                                           context,
//                                           nameController.text,
//                                           addressController.text,
//                                           emailController.text,
//                                           mobNumController.text,
//                                           secNumController.text
//                                       );
//                                       companyOfficeListGet(context,0,1,6).then((data) {
//                                         _companyIdentityController.add(data);
//                                       }).catchError((error) {
//                                       });
//                                       Navigator.pop(context);
//                                     })
//                               ],
//                             ),
//                           ));
//                     },
//                   );
//                 },
//                 icon: Icons.add,
//               ),
//             )
//           ],
//         ),
//         SizedBox(height: 10),
//         /// Heading Row (conditionally rendered)
//         if (showHeadings)
//           Column(
//             children: [
//               Container(
//                 height: 30,
//                 margin: EdgeInsets.symmetric(horizontal: 50),
//                 decoration: BoxDecoration(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(width: 25),
//                     Padding(
//                       padding: EdgeInsets.only(left: 85),
//                       child: Text(
//                         "Sr No.",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 35),
//                       child: Text(
//                         "Office Name",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(right: 70),
//                       child: Text(
//                         "Address",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(right: 40),
//                       child: Text(
//                         "Actions",
//                         style: TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 10),
//             ],
//           ),
//         /// List or PageView based on showStreamBuilder
//           Expanded(
//            child: showStreamBuilder
//               ? StreamBuilder<List<CompanyIdentityModel>>(
//             stream:_companyIdentityController.stream,
//             builder: (BuildContext context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: Colors.blue,
//                   ),
//                 );
//               }
//               if (snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     "No Data!",
//                     style: TextStyle(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 );
//               }
//               if (snapshot.hasData) {
//                 int totalItems = snapshot.data!.length;
//                 (currentPage - 1) * itemsPerPage;
//                 (currentPage * itemsPerPage) > totalItems
//                     ? totalItems
//                     : (currentPage * itemsPerPage);
//
//                 return ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
//                     String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 5),
//                         Container(
//                           padding: EdgeInsets.only(bottom: 5),
//                           margin: EdgeInsets.symmetric(horizontal: 50),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(4),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.grey.withOpacity(0.5),
//                                 spreadRadius: 1,
//                                 blurRadius: 4,
//                                 offset: Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           height: 56,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   Icons.menu_sharp,
//                                   color: Color(0xff686464),
//                                 ),
//                               ),
//                               Text(
//                                 formattedSerialNumber,
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                   color: Color(0xff686464),
//                                 ),
//                                 textAlign: TextAlign.start,
//                               ),
//                               Text(
//                                 snapshot.data![index].officeName.toString(),
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                   color: Color(0xff686464),
//                                 ),
//                               ),
//                               Text(
//                                 snapshot.data![index].address.toString(),
//                                 textAlign: TextAlign.end,
//                                 style: GoogleFonts.firaSans(
//                                   fontSize: 10,
//                                   fontWeight: FontWeight.w700,
//                                   color: Color(0xff686464),
//                                 ),
//                               ),
//                               CustomButtonTransparentSM(
//                               text: 'Manage', onPressed: () {
//                                 showManageScreenFunction();
//                               }),
//                             ],
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               }
//               return Scaffold();
//             },
//           )
//                : PageView(
//             controller: _pageController,
//             children: [
//               Container(
//                child: WhitelabellingScreen()
//               ),
//               // Container(
//               //   color: Colors.deepPurple,
//               // ),
//             ],
//           ),
//         ),
//         if (showManageScreen)
//           Expanded(
//             child: PopupCiManageScreen(), // Replace with your actual ManageScreen widget
//           ),
//       ],
//     );
//   }
// }




//
// class CompanyIdentity extends StatefulWidget {
//   const CompanyIdentity({super.key});
//
//   @override
//   State<CompanyIdentity> createState() => _CompanyIdentityState();
// }
//
// class _CompanyIdentityState extends State<CompanyIdentity> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobNumController = TextEditingController();
//   TextEditingController secNumController = TextEditingController();
//   TextEditingController OptionalController = TextEditingController();
//   final StreamController<List<CompanyModel>> _controller = StreamController<List<CompanyModel>>();
//   late CompanyIdentityManager _companyManager;
//   final PageController _tabPageController = PageController();
//   late int currentPage;
//   late int itemsPerPage;
//   late List<String> items;
//   @override
//   void initState() {
//     super.initState();
//     currentPage = 1;
//     itemsPerPage = 5;
//     items = List.generate(20, (index) => 'Item ${index + 1}');
//     _companyManager = CompanyIdentityManager();
//     companyAllApi(context).then((data) {
//       _controller.add(data);
//     }).catchError((error) {
//       // Handle error
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         ///buttons
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ///whitelabbeling
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomButton(
//                 borderRadius: 12,
//                 text: 'Whitelabelling',
//                 style: CustomTextStylesCommon.commonStyle(
//                     fontSize: FontSize.s12,
//                     fontWeight: FontWeightManager.bold,
//                     color: ColorManager.white),
//                 width: 120,
//                 height: 30,
//                 onPressed: () {
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: CustomButton(
//                 borderRadius: 12,
//                 text: 'Whitelabelling',
//                 style: CustomTextStylesCommon.commonStyle(
//                     fontSize: FontSize.s12,
//                     fontWeight: FontWeightManager.bold,
//                     color: ColorManager.white),
//                 width: 120,
//                 height: 30,
//                 onPressed: () {
//                 },
//               ),
//             ),
//             ///add new office
//             Padding(
//               padding: const EdgeInsets.only(right: 50),
//               child: CustomIconButtonConst(
//                 text: 'Add New Office',
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                           backgroundColor: Colors.white,
//                           content: Container(
//                             height: 450,
//                             width: 300,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     IconButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         icon: Icon(Icons.close))
//                                   ],
//                                 ),
//                                 Column(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     SMTextFConst(
//                                       controller: nameController,
//                                       keyboardType: TextInputType.text,
//                                       text: 'Name',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: addressController,
//                                       keyboardType: TextInputType.streetAddress,
//                                       text: 'Address',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: emailController,
//                                       keyboardType: TextInputType.emailAddress,
//                                       text: 'Email',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: mobNumController,
//                                       keyboardType: TextInputType.number,
//                                       text: 'Primary Phone',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: secNumController,
//                                       keyboardType: TextInputType.number,
//                                       text: 'Secondary Phone',
//                                     ),
//                                     SizedBox(
//                                       height: 7,
//                                     ),
//                                     SMTextFConst(
//                                       controller: OptionalController,
//                                       keyboardType: TextInputType.number,
//                                       text: 'Alternative Phone',
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 40,
//                                 ),
//                                 CustomElevatedButton(
//                                     width: 105,
//                                     height: 31,
//                                     text: 'Submit',
//                                     onPressed: () async{
//                                       await addNewOffice(
//                                           context,
//                                           nameController.text,
//                                           addressController.text,
//                                           emailController.text,
//                                           mobNumController.text,
//                                           secNumController.text);
//                                       companyAllApi(context).then((data) {
//                                         _controller.add(data);
//                                       }).catchError((error) {
//                                         // Handle error
//                                       });
//                                       Navigator.pop(context);
//                                     })
//                               ],
//                             ),
//                           ));
//                     },
//                   );
//                 },
//                 icon: Icons.add,
//               ),
//             )
//           ],
//         ),
//         SizedBox(height: 10),
//         ///heading row
//         Container(
//           height: AppSize.s30,
//           margin: EdgeInsets.symmetric(horizontal: AppMargin.m50),
//           decoration: BoxDecoration(
//             color: ColorManager.fmediumgrey,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               SizedBox(width: 25,),
//               Padding(
//                 padding:  EdgeInsets.only(left: 85),
//                 child: Text(
//                  "Sr No.",
//                   style: GoogleFonts.firaSans(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: ColorManager.white
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding:  EdgeInsets.only(left: 35),
//                 child: Text(
//                 "Office Name",
//                   style: GoogleFonts.firaSans(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: ColorManager.white
//                     // color: isSelected ? Colors.white : Colors.black,
//                   ),
//                   // style: RegisterTableHead.customTextStyle(context),
//                 ),
//               ),
//               Padding(
//                 padding:  EdgeInsets.only(right: 70),
//                 child: Text(
//                   "Address",
//                   style: GoogleFonts.firaSans(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: ColorManager.white
//                     // color: isSelected ? Colors.white : Colors.black,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding:  EdgeInsets.only(right: 40),
//                 child: Text(
//                   AppString.actions,
//                   style: GoogleFonts.firaSans(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: ColorManager.white
//                     // color: isSelected ? Colors.white : Colors.black,
//                   ),
//                   // style: RegisterTableHead.customTextStyle(context),
//                 ),
//               ),
//             ],
//           ),
//         ),
//
//         SizedBox(
//           height: 10,
//         ),
//         ///list
//         Expanded(
//           child: StreamBuilder<List<CompanyModel>>(
//             stream: _controller.stream,
//             builder: (BuildContext context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: ColorManager.blueprime,
//                   ),
//                 );
//               }
//               if (snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     AppString.dataNotFound,
//                     style: CustomTextStylesCommon.commonStyle(
//                       fontWeight: FontWeightManager.medium,
//                       fontSize: FontSize.s12,
//                       color: ColorManager.mediumgrey,
//                     ),
//                   ),
//                 );
//               }
//               if (snapshot.hasData) {
//                 int totalItems = snapshot.data!.length;
//                   (currentPage - 1) * itemsPerPage;
//                   (currentPage * itemsPerPage) > totalItems
//                       ? totalItems
//                       : (currentPage * itemsPerPage);
//
//                 return ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
//                       String formattedSerialNumber =
//                       serialNumber.toString().padLeft(2, '0');
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 5),
//                           Container(
//                             padding: EdgeInsets.only(bottom: AppPadding.p5),
//                             margin: EdgeInsets.symmetric(horizontal: AppMargin.m50),
//                             decoration: BoxDecoration(
//                               color: ColorManager.white,
//                               borderRadius: BorderRadius.circular(4),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: ColorManager.grey.withOpacity(0.5),
//                                   spreadRadius: 1,
//                                   blurRadius: 4,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             height: AppSize.s56,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 IconButton(
//                                             onPressed: () {},
//                                             icon: Icon(
//                                               Icons.menu_sharp,
//                                               color: Color(0xff686464),
//                                             )),
//                                 Text(
//                                   formattedSerialNumber,
//                                   style: GoogleFonts.firaSans(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w700,
//                                       color: Color(0xff686464)
//                                     // color: isSelected ? Colors.white : Colors.black,
//                                   ),
//                                   // style: ThemeManagerDark.customTextStyle(context),
//                                   textAlign: TextAlign.start,
//                                 ),
//                                 Text(
//                                       snapshot.data![index].companyId.toString(),
//                                       // formattedSerialNumber,
//                                       style: GoogleFonts.firaSans(
//                                         fontSize: 10,
//                                         fontWeight: FontWeight.w500,
//                                         color: Color(0xff686464),
//                                         decoration: TextDecoration.none,
//                                       ),
//                                     ),
//                                 Text(
//                                           snapshot.data![index].address.toString(),
//                                           textAlign: TextAlign.end,
//                                           style: GoogleFonts.firaSans(
//                                             fontSize: 10,
//                                             fontWeight: FontWeight.w500,
//                                             color: Color(0xff686464),
//                                             decoration: TextDecoration.none,
//                                           ),
//                                         ),
//                                 CustomButtonTransparentSM(
//
//                                             text: 'Manage', onPressed: () {
//
//                                         }),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     });
//               }
//               return Scaffold();
//             },
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//
//       ],
//     );
//   }
// }
///
// PaginationControlsWidget(
//   currentPage: currentPage,
//   items: items,
//   itemsPerPage: itemsPerPage,
//   onPreviousPagePressed: () {
//     setState(() {
//       currentPage = currentPage > 1 ? currentPage - 1 : 1;
//     });
//   },
//   onPageNumberPressed: (pageNumber) {
//     setState(() {
//       currentPage = pageNumber;
//     });
//   },
//   onNextPagePressed: () {
//     setState(() {
//       int totalPages = (items.length / itemsPerPage).ceil();
//       currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
//     });
//   },
// ),