import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/button_constant.dart';
import 'package:prohealth/presentation/screens/sm_module/widgets/text_form_field_const.dart';
import 'package:prohealth/presentation/widgets/custom_icon_button_constant.dart';
import '../../../app/services/api_sm/company_identity/add_doc_company_manager.dart';
import '../hr_module/manage/widgets/custom_icon_button_constant.dart';

class CompanyIdentityScreen extends StatefulWidget {
  const CompanyIdentityScreen({super.key});

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
  }
  //
  // void fetchData() async {
  //   try {
  //     var companyData = await getCompany(1);
  //     print(companyData);
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///whitelabbeling
            CustomButton(
              borderRadius: 12,
              text: 'Whitelabelling',
              style: GoogleFonts.firaSans(fontSize: 10),
              width: 120,
              height: 30,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
//  padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(Icons.close),
                              ),
                            ],
                          ),
// Add your content here
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            SizedBox(
              width: 30,
            ),

            ///add new office
            CustomIconButtonConst(
              text: 'Add New Office',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        backgroundColor: Colors.white,
                        content: Container(
                          height: 425,
                          width: 300,
                          child: Column(
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
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SMTextFConst(
                                    controller: nameController,
                                    keyboardType: TextInputType.text,
                                    text: 'Name',
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SMTextFConst(
                                    controller: addressController,
                                    keyboardType: TextInputType.streetAddress,
                                    text: 'Address',
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SMTextFConst(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    text: 'Email',
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SMTextFConst(
                                    controller: mobNumController,
                                    keyboardType: TextInputType.number,
                                    text: 'Primary Phone',
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  SMTextFConst(
                                    controller: secNumController,
                                    keyboardType: TextInputType.number,
                                    text: 'Secondary Phone',
                                  ),
                                  SizedBox(
                                    height: 5,
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
                                  onPressed: () {
// Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) =>
//             LoginScreen()));
                                  })
                            ],
                          ),
                        ));
                  },
                );
              },
              icon: Icons.add,
            )
          ],
        ),
        SizedBox(height: 20),

        ///heading row
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(''),
              Text(
                'Sr No',
                style: GoogleFonts.firaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
// SizedBox(width: MediaQuery.of(context).size.width/7.5,),
              Text('Office Name',
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),

//SizedBox(width: MediaQuery.of(context).size.width/5.5,),
              Text('Address  ',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.firaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    decoration: TextDecoration.none,
                  )),
// SizedBox(height: 1,),
//SizedBox(width: MediaQuery.of(context).size.width/150,),
              Text('Actions',
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
        SizedBox(
          height: 10,
        ),

        ///list
        Expanded(
          child: FutureBuilder<Map<String, dynamic>>(
            future: _companyManager.getCompany(1), // Fetch company data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: ColorManager.blueprime,),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else if (snapshot.hasData) {
                final companyData = snapshot.data!;
                final List<dynamic>? offices = companyData['offices'] as List<dynamic>?;

                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: offices?.length ?? 0,
                    itemBuilder: (context, index) {
                      final office = offices![index];
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5),
                            Container(
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.menu_sharp,
                                          color: Color(0xff686464),
                                        )
                                    ),
                                    Text('  '),
                                    Text(
                                      '${index + 1}',
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff686464),
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(''),
                                    Text(
                                      office['name'] ?? '',
                                      // office.name.isNull ? 'Pro Health' : '',
                                      //  'Pro Health',
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff686464),
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(''),
                                    Text(
                                      office['address'] ?? '',
                                      textAlign: TextAlign.end,
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff686464),
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                    Text(''),
                                    CustomButtonTransparentSM(
                                        text: 'Manage',
                                        onPressed: () {}
                                    )
                                  ],
                                )
                            )
                          ]
                      );
                    }
                );
              } else {
                return Center(
                  child: Text('No data available.'),
                );
              }
            },
          ),
        ),
        // Expanded(
        //   child:
        //   // FutureBuilder<CompanyDataGet>(
        //   //   future: _companyManager.getCompanyById(1),
        //   //   builder: (context, snapshot) {
        //   //     if (snapshot.connectionState == ConnectionState.waiting) {
        //   //       return Center(
        //   //         child: CircularProgressIndicator(color: ColorManager.blueprime,),
        //   //       );
        //   //     } else if (snapshot.hasError) {
        //   //       return Center(
        //   //         child: Text('Error: ${snapshot.error}'),
        //   //       );
        //   //     } else if (snapshot.hasData) {
        //   //       final companyData = snapshot.data!;
        //   //       final List<Office>? offices = companyData.offices as List<Office>?;
        //   //       return
        //           ListView.builder(
        //             scrollDirection: Axis.vertical,
        //             itemCount: 10,
        //             itemBuilder: (context, index) {
        //               // int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
        //               // String formattedSerialNumber =
        //               // serialNumber.toString().padLeft(2, '0');
        //               //final office = offices![index];
        //
        //               // var office =
        //               // Map<String, dynamic> office = offices[index];
        //               //  String officeName = office['name'];
        //               //  String officeAddress = office['address'];
        //               //  String officeId = office['id'];
        //
        //               return Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   SizedBox(height: 5),
        //                   Container(
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(4),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Color(0xff000000).withOpacity(0.25),
        //                             spreadRadius: 0,
        //                             blurRadius: 4,
        //                             offset: Offset(0, 2),
        //                           ),
        //                         ],
        //                       ),
        //                       height: 50,
        //                       child: Row(
        //                         mainAxisAlignment:
        //                             MainAxisAlignment.spaceEvenly,
        //                         children: [
        //                           IconButton(
        //                               onPressed: () {},
        //                               icon: Icon(
        //                                 Icons.menu_sharp,
        //                                 color: Color(0xff686464),
        //                               )),
        //                           Text('  '),
        //                           Text(
        //                             '${index + 1}',
        //                             // formattedSerialNumber,
        //                             style: GoogleFonts.firaSans(
        //                               fontSize: 10,
        //                               fontWeight: FontWeight.w500,
        //                               color: Color(0xff686464),
        //                               decoration: TextDecoration.none,
        //                             ),
        //                           ),
        //                           Text(''),
        //                           Text(
        //                              //office.name ?? '',
        //                            // office.name.isNull ? 'Pro Health' : '',
        //                              'Pro Health',
        //                             style: GoogleFonts.firaSans(
        //                               fontSize: 10,
        //                               fontWeight: FontWeight.w500,
        //                               color: Color(0xff686464),
        //                               decoration: TextDecoration.none,
        //                             ),
        //                           ),
        //                           Text(''),
        //                           Text(
        //                            // office.address ?? '',
        //                             //office.address.isNull ? '2700 Zankar Road': '',
        //                             '2700 Zankar Road Suite 180, San Jose, CA, USA',
        //                             textAlign: TextAlign.end,
        //                             style: GoogleFonts.firaSans(
        //                               fontSize: 10,
        //                               fontWeight: FontWeight.w500,
        //                               color: Color(0xff686464),
        //                               decoration: TextDecoration.none,
        //                             ),
        //                           ),
        //                           Text(''),
        //                           CustomButtonTransparentSM(
        //                               text: 'Manage', onPressed: () {})
        //                         ],
        //                       )),
        //                 ],
        //               );
        //             }
        //             )
        // ),
        //       } else {
        //         return Center(
        //           child: Text('No data available.'),
        //         );
        //       }
        //       return Container(
        //         color: Colors.red,
        //       );
        //     },
        //   ),
        // ),
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
                      margin: EdgeInsets.only(left: 5,right: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: currentPage == i ? ColorManager.blueprime : ColorManager.grey,
                          width: currentPage == i ? 2.0 : 1.0,
                        ),
                        color:
                        currentPage == i ? ColorManager.blueprime : Colors.transparent,
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
                  border:Border.all(
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
      ]),
    ));
  }
}

///updated future builder
// class _CompanyIdentityScreenState extends State<CompanyIdentityScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobNumController = TextEditingController();
//   TextEditingController secNumController = TextEditingController();
//   TextEditingController OptionalController = TextEditingController();
//
//   late int currentPage;
//   late int itemsPerPage;
//   late List<String> items;
//   late CompanyIdentityManager _companyManager;
//
//   @override
//   void initState() {
//     super.initState();
//     currentPage = 1;
//     itemsPerPage = 5;
//     items = List.generate(20, (index) => 'Item ${index + 1}');
//     _companyManager = CompanyIdentityManager();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
//       child: Column(children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ///whitelabbeling
//             CustomButton(
//               borderRadius: 12,
//               text: 'Whitelabelling',
//               style: GoogleFonts.firaSans(fontSize: 12),
//               width: 120,
//               height: 30,
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (BuildContext context) {
//                     return Container(
//                       height: MediaQuery.of(context).size.height * 0.7,
//                       width: double.maxFinite,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(12.0),
//                           topRight: Radius.circular(12.0),
//                         ),
//                       ),
//                       //  padding: EdgeInsets.all(20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 icon: Icon(Icons.close),
//                               ),
//                             ],
//                           ),
//                           // Add your content here
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//             SizedBox(
//               width: 30,
//             ),
//
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
//                           height: 425,
//                           width: 300,
//                           child: Column(
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
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   SMTextFConst(
//                                     controller: nameController,
//                                     keyboardType: TextInputType.text,
//                                     text: 'Name',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   SMTextFConst(
//                                     controller: addressController,
//                                     keyboardType: TextInputType.streetAddress,
//                                     text: 'Address',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   SMTextFConst(
//                                     controller: emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     text: 'Email',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   SMTextFConst(
//                                     controller: mobNumController,
//                                     keyboardType: TextInputType.number,
//                                     text: 'Primary Phone',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   SMTextFConst(
//                                     controller: secNumController,
//                                     keyboardType: TextInputType.number,
//                                     text: 'Secondary Phone',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
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
//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) =>
//                                     //             LoginScreen()));
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
//         SizedBox(height: 20),
//
//         ///heading row
//         Container(
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
//               // SizedBox(width: MediaQuery.of(context).size.width/7.5,),
//               Text('Office Name',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                     decoration: TextDecoration.none,
//                   )),
//
//               //SizedBox(width: MediaQuery.of(context).size.width/5.5,),
//               Text('Address  ',
//                   textAlign: TextAlign.start,
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                     decoration: TextDecoration.none,
//                   )),
//               // SizedBox(height: 1,),
//               //SizedBox(width: MediaQuery.of(context).size.width/150,),
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
//         SizedBox(
//           height: 10,
//         ),
//
//         ///list
//         Expanded(
//           child: FutureBuilder<CompanyDataGet>(
//             future: _companyManager.getCompanyById(1),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               } else if (snapshot.hasError) {
//                 return Center(
//                   child: Text('Error: ${snapshot.error}'),
//                 );
//               } else if (snapshot.hasData) {
//                 // Use the retrieved company data
//                 final companyData = snapshot.data!;
//                 final List<Office>? offices = companyData.offices;
//                 child:
//                 ListView.builder(
//                     scrollDirection: Axis.vertical,
//                     itemCount: offices?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       // int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
//                       // String formattedSerialNumber =
//                       // serialNumber.toString().padLeft(2, '0');
//                       final office = offices![index];
//
//                       // var office =
//                       // Map<String, dynamic> office = offices[index];
//                       //  String officeName = office['name'];
//                       //  String officeAddress = office['address'];
//                       //  String officeId = office['id'];
//
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
//                                     '${index + 1}',
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
//                                    // office.name ?? '',
//                                     office.name.isNull ? 'Pro Health' : '',
//                                     // 'Pro Health',
//                                     style: GoogleFonts.firaSans(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xff686464),
//                                       decoration: TextDecoration.none,
//                                     ),
//                                   ),
//                                   Text(''),
//                                   Text(
//                                     //office.address ?? '',
//                                     office.address.isNull ? '2700 Zankar Road' : '',
//                                     //'2700 Zankar Road Suite 180, San Jose, CA, USA',
//                                     textAlign: TextAlign.end,
//                                     style: GoogleFonts.firaSans(
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w500,
//                                       color: Color(0xff686464),
//                                       decoration: TextDecoration.none,
//                                     ),
//                                   ),
//                                   Text(''),
//                                   CustomButtonTransparentSM(
//                                       text: 'Manage', onPressed: () {})
//                                 ],
//                               )),
//                         ],
//                       );
//                     });
//               } else {
//                 return Center(
//                   child: Text('No data available.'),
//                 );
//               }
//               return Container(
//                 color: Colors.red,
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Container(
//           height: 30,
//           color: Colors.black12,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               (items.length / itemsPerPage).ceil(),
//               (index) => IconButton(
//                 icon: Text(
//                   '${index + 1}',
//                   style: TextStyle(
//                       color:
//                           currentPage == index + 1 ? Colors.blue : Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     currentPage = index + 1;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//       ]),
//     ));
//   }
// }

///code for get api data to show in listview
// class CompanyIdentityScreen extends StatefulWidget {
//   const CompanyIdentityScreen({super.key});
//
//   @override
//   State<CompanyIdentityScreen> createState() => _CompanyIdentityScreenState();
// }
//
// class _CompanyIdentityScreenState extends State<CompanyIdentityScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobNumController = TextEditingController();
//   TextEditingController secNumController = TextEditingController();
//   TextEditingController OptionalController = TextEditingController();
//
//   late int currentPage;
//   late int itemsPerPage;
//   late List<String> items;
//   late Future<CompanyDataGet> companyDataFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     currentPage = 1;
//     itemsPerPage = 5;
//     items = List.generate(20, (index) => 'Item ${index + 1}');
//     companyDataFuture = fetchCompanyData();
//   }
//   Future<CompanyDataGet> fetchCompanyData() async {
//     return CompanyIdentityManager().getCompanyById();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:FutureBuilder<CompanyDataGet>(
//         future: companyDataFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator(color: Color(0xFF50B5E5),));
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final companyData = snapshot.data!;
//             return buildCompanyData(companyData);
//           }
//         },
//       ),
//     );
//   }
//
//   Widget buildCompanyData(CompanyDataGet companyData) {
//     List<Office>? offices = companyData.offices;
//     List<Office>? currentPageItems = offices?.sublist(
//       (currentPage - 1) * itemsPerPage,
//       min(currentPage * itemsPerPage, offices.length),
//     );
//
//     return  Container(
//       padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
//       child: Column(children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             ///whitelabbeling
//             CustomButton(
//               borderRadius: 12,
//               text: 'Whitelabelling',
//               style: GoogleFonts.firaSans(
//                   fontSize: 12
//               ),
//               width: 120,
//               height: 30,
//               onPressed: () {
//                 showModalBottomSheet(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (BuildContext context) {
//                     return Container(
//                       height: MediaQuery.of(context).size.height * 0.7,
//                       width: double.maxFinite,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(12.0),
//                           topRight: Radius.circular(12.0),
//                         ),
//                       ),
//                       //  padding: EdgeInsets.all(20.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 icon: Icon(Icons.close),
//                               ),
//                             ],
//                           ),
//                           // Add your content here
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//             SizedBox(
//               width: 30,
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
//                           height: 425,
//                           width: 300,
//                           child: Column(
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
//                                 MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   SMTextFConst(
//                                     controller: nameController,
//                                     keyboardType: TextInputType.text,
//                                     text: 'Name',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   SMTextFConst(
//                                     controller: addressController,
//                                     keyboardType: TextInputType.streetAddress,
//                                     text: 'Address',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   SMTextFConst(
//                                     controller: emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     text: 'Email',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   SMTextFConst(
//                                     controller: mobNumController,
//                                     keyboardType: TextInputType.number,
//                                     text: 'Primary Phone',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
//                                   ),
//                                   SMTextFConst(
//                                     controller: secNumController,
//                                     keyboardType: TextInputType.number,
//                                     text: 'Secondary Phone',
//                                   ),
//                                   SizedBox(
//                                     height: 5,
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
//                                     // Navigator.push(
//                                     //     context,
//                                     //     MaterialPageRoute(
//                                     //         builder: (context) =>
//                                     //             LoginScreen()));
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
//         SizedBox(height: 20),
//         ///heading row
//         Container(
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
//               // SizedBox(width: MediaQuery.of(context).size.width/7.5,),
//               Text('Office Name',
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                     decoration: TextDecoration.none,
//                   )),
//
//               //SizedBox(width: MediaQuery.of(context).size.width/5.5,),
//               Text('Address  ',
//                   textAlign: TextAlign.start,
//                   style: GoogleFonts.firaSans(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                     decoration: TextDecoration.none,
//                   )),
//               // SizedBox(height: 1,),
//               //SizedBox(width: MediaQuery.of(context).size.width/150,),
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
//         SizedBox(
//           height: 10,
//         ),
//         ///list
//         Expanded(
//           child: ListView.builder(
//               scrollDirection: Axis.vertical,
//               itemCount: currentPageItems?.length,
//               itemBuilder: (context, index) {
//                 int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
//                 String formattedSerialNumber =
//                 serialNumber.toString().padLeft(2, '0');
//                 Office office = currentPageItems![index];
//                 // var office =
//                 // Map<String, dynamic> office = offices[index];
//                 //  String officeName = office['name'];
//                 //  String officeAddress = office['address'];
//                 //  String officeId = office['id'];
//
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 5),
//                     Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(4),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Color(0xff000000).withOpacity(0.25),
//                               spreadRadius: 0,
//                               blurRadius: 4,
//                               offset: Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         height: 50,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(
//                                   Icons.menu_sharp,
//                                   color: Color(0xff686464),
//                                 )),
//                             Text('  '),
//                             Text(
//                               formattedSerialNumber,
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xff686464),
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                             Text(''),
//                             Text(
//                              office.name.isNull? 'Pro Health' : office.name!,
//                               //    .isEmpty ?  'Pro Health' : office.name,
//                               // office.name?.isEmpty ?? true ? 'Pro Health' : office.name!,
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xff686464),
//                                 decoration: TextDecoration.none,
//                               ),
//                             ),
//                             Text(''),
//                             Text(
//                               office.address!,
//                                   //.isEmpty ? '2700 Zankar Road Suite 180, San Jose, CA, USA' : office.address,
//                               textAlign: TextAlign.end,
//                               style: GoogleFonts.firaSans(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w500,
//                                 color: Color(0xff686464),
//                                 decoration: TextDecoration.none,
//                               ),
//                              ),
//                             Text(''),
//                             CustomButtonTransparentSM(
//                                 text: 'Manage', onPressed: () {})
//                           ],
//                         )),
//                   ],
//                 );
//               }),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Container(
//           height: 30,
//           color: Colors.black12,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               (items.length / itemsPerPage).ceil(),
//                   (index) => IconButton(
//                 icon: Text(
//                   '${index + 1}',
//                   style: TextStyle(
//                       color:
//                       currentPage == index + 1 ? Colors.blue : Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 12),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     currentPage = index + 1;
//                   });
//                 },
//               ),
//             ),
//           ),
//         ),
//       ]),
//     );
//   }
// }

///
///code that shows get api data in terminal
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
// import 'package:prohealth/presentation/screens/sm_module/widgets/button_constant.dart';
// import 'package:prohealth/presentation/screens/sm_module/widgets/text_form_field_const.dart';
// import 'package:prohealth/presentation/widgets/custom_icon_button_constant.dart';
// import '../hr_module/manage/widgets/custom_icon_button_constant.dart';
//
// class CompanyIdentityScreen extends StatefulWidget {
//   const CompanyIdentityScreen({super.key});
//
//   @override
//   State<CompanyIdentityScreen> createState() => _CompanyIdentityScreenState();
// }
//
// class _CompanyIdentityScreenState extends State<CompanyIdentityScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController mobNumController = TextEditingController();
//   TextEditingController secNumController = TextEditingController();
//   TextEditingController OptionalController = TextEditingController();
//
//   late int currentPage;
//   late int itemsPerPage;
//   late List<String> items;
//
//   @override
//   void initState() {
//     super.initState();
//     currentPage = 1;
//     itemsPerPage = 5;
//     items = List.generate(20, (index) => 'Item ${index + 1}');
//     CompanyIdentityManager().getCompanyById();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> currentPageItems = items.sublist(
//       (currentPage - 1) * itemsPerPage,
//       min(currentPage * itemsPerPage, items.length),
//     );
//     // List<String> currentPageItems = items.sublist(
//     //   (currentPage - 1) * itemsPerPage,
//     //   min(currentPage * itemsPerPage, items.length),
//     // );
//
//     return Scaffold(
//         body: Container(
//           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 6),
//           child: Column(children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 CustomButton(
//                   borderRadius: 12,
//                   text: 'Whitelabelling',
//                   style: GoogleFonts.firaSans(
//                       fontSize: 12
//                   ),
//                   width: 120,
//                   height: 30,
//                   onPressed: () {
//                     showModalBottomSheet(
//                       context: context,
//                       isScrollControlled: true,
//                       builder: (BuildContext context) {
//                         return Container(
//                           height: MediaQuery.of(context).size.height * 0.7,
//                           width: double.maxFinite,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(12.0),
//                               topRight: Radius.circular(12.0),
//                             ),
//                           ),
//                           //  padding: EdgeInsets.all(20.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.stretch,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       Navigator.pop(context);
//                                     },
//                                     icon: Icon(Icons.close),
//                                   ),
//                                 ],
//                               ),
//                               // Add your content here
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   width: 30,
//                 ),
//                 CustomIconButtonConst(
//                   text: 'Add New Office',
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                             backgroundColor: Colors.white,
//                             content: Container(
//                               height: 425,
//                               width: 300,
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       IconButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           icon: Icon(Icons.close))
//                                     ],
//                                   ),
//                                   Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                     children: [
//                                       SMTextFConst(
//                                         controller: nameController,
//                                         keyboardType: TextInputType.text,
//                                         text: 'Name',
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       SMTextFConst(
//                                         controller: addressController,
//                                         keyboardType: TextInputType.streetAddress,
//                                         text: 'Address',
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       SMTextFConst(
//                                         controller: emailController,
//                                         keyboardType: TextInputType.emailAddress,
//                                         text: 'Email',
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       SMTextFConst(
//                                         controller: mobNumController,
//                                         keyboardType: TextInputType.number,
//                                         text: 'Primary Phone',
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       SMTextFConst(
//                                         controller: secNumController,
//                                         keyboardType: TextInputType.number,
//                                         text: 'Secondary Phone',
//                                       ),
//                                       SizedBox(
//                                         height: 5,
//                                       ),
//                                       SMTextFConst(
//                                         controller: OptionalController,
//                                         keyboardType: TextInputType.number,
//                                         text: 'Alternative Phone',
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     height: 40,
//                                   ),
//                                   CustomElevatedButton(
//                                       width: 105,
//                                       height: 31,
//                                       text: 'Submit',
//                                       onPressed: () {
//                                         // Navigator.push(
//                                         //     context,
//                                         //     MaterialPageRoute(
//                                         //         builder: (context) =>
//                                         //             LoginScreen()));
//                                       })
//                                 ],
//                               ),
//                             ));
//                       },
//                     );
//                   },
//                   icon: Icons.add,
//                 )
//               ],
//             ),
//             SizedBox(height: 20),
//             ///heading row
//             Container(
//               height: 30,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(''),
//                   Text(
//                     'Sr No',
//                     style: GoogleFonts.firaSans(
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.white,
//                       decoration: TextDecoration.none,
//                     ),
//                   ),
//                   // SizedBox(width: MediaQuery.of(context).size.width/7.5,),
//                   Text('Office Name',
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         decoration: TextDecoration.none,
//                       )),
//                   //SizedBox(width: MediaQuery.of(context).size.width/5.5,),
//                   Text('Address  ',
//                       textAlign: TextAlign.start,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         decoration: TextDecoration.none,
//                       )),
//                   // SizedBox(height: 1,),
//                   //SizedBox(width: MediaQuery.of(context).size.width/150,),
//                   Text('Actions',
//                       textAlign: TextAlign.start,
//                       style: GoogleFonts.firaSans(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w700,
//                         color: Colors.white,
//                         decoration: TextDecoration.none,
//                       )),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             ///list
//             Expanded(
//               child: ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: currentPageItems.length,
//                   itemBuilder: (context, index) {
//                     int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
//                     String formattedSerialNumber =
//                     serialNumber.toString().padLeft(2, '0');
//                     // var office =
//                     // Map<String, dynamic> office = offices[index];
//                     //  String officeName = office['name'];
//                     //  String officeAddress = office['address'];
//                     //  String officeId = office['id'];
//
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 5),
//                         Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(4),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Color(0xff000000).withOpacity(0.25),
//                                   spreadRadius: 0,
//                                   blurRadius: 4,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             height: 50,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 IconButton(
//                                     onPressed: () {},
//                                     icon: Icon(
//                                       Icons.menu_sharp,
//                                       color: Color(0xff686464),
//                                     )),
//                                 Text('  '),
//                                 Text(
//                                   formattedSerialNumber,
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xff686464),
//                                     decoration: TextDecoration.none,
//                                   ),
//                                 ),
//                                 Text(''),
//                                 Text(
//                                   'ProHealth San Jose',
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xff686464),
//                                     decoration: TextDecoration.none,
//                                   ),
//                                 ),
//                                 Text(''),
//                                 Text(
//                                   '2700 Zankar Road Suite 180, San Jose, CA, USA',
//                                   textAlign: TextAlign.end,
//                                   style: GoogleFonts.firaSans(
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.w500,
//                                     color: Color(0xff686464),
//                                     decoration: TextDecoration.none,
//                                   ),
//                                 ),
//                                 Text(''),
//                                 CustomButtonTransparentSM(
//                                     text: 'Manage', onPressed: () {})
//                               ],
//                             )),
//                       ],
//                     );
//                   }),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Container(
//               height: 30,
//               color: Colors.black12,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   (items.length / itemsPerPage).ceil(),
//                       (index) => IconButton(
//                     icon: Text(
//                       '${index + 1}',
//                       style: TextStyle(
//                           color:
//                           currentPage == index + 1 ? Colors.blue : Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12),
//                     ),
//                     onPressed: () {
//                       setState(() {
//                         currentPage = index + 1;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//         ));
//   }
// }
