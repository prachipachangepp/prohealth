// import 'package:flutter/material.dart';
// import 'package:prohealth/app/theme_manager.dart';
// import 'package:prohealth/presentation/widgets/profile_bar/widget/profil_custom_widget.dart';
//
// ///parchi
// class ProfileBar extends StatelessWidget {
//   const ProfileBar({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(children: [
//       Material(
//         elevation: 4,
//         child: Container(
//             height: MediaQuery.of(context).size.height / 4,
//             width: 50,
//             decoration: BoxDecoration(
//               color: Color(0xFF52A889),
//             ),
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Text(
//                 "Profile\n100%",
//                 style: ThemeManagerWhite.customTextStyle(context),
//               ),
//             ])),
//       ),
//       Material(
//         elevation: 4,
//         borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
//         child: Container(
//             height: MediaQuery.of(context).size.height / 4,
//             width: MediaQuery.of(context).size.width / 1.1,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomRight: Radius.circular(8),
//                   topRight: Radius.circular(8)),
//               color: Color(0xffB1D6F4).withOpacity(0.25),
//             ),
//             child: Row(
//               children: [
//                 ///1st column
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16, left: 15, bottom: 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ///image
//                       SizedBox(
//                         width: 70,
//                         height: 70,
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Image.asset(
//                               'images/profile.png',
//                               height: 50,
//                               width: 50,
//                             ),
//                             // you can replace
//                             SizedBox(
//                               height: 53,
//                               width: 53,
//                               child: const CircularProgressIndicator(
//                                 valueColor:
//                                     AlwaysStoppedAnimation<Color>(Colors.green),
//                                 strokeWidth: 3,
//                                 value: 0.70,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Text(
//                         "Active",
//                         style: ThemeManagerBlack.customTextStyle(context),
//                       ),
//                       Text(
//                         "Annual skills 92%",
//                         style: ThemeManager.customTextStyle(context),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 50,
//                 ),
//
//                 ///2 nd column
//                 Padding(
//                   padding: const EdgeInsets.only(top: 16, bottom: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ///text john scott
//                       Text(
//                         "John Scott",
//                         style: ThemeManagerBlack.customTextStyle(context),
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height / 40,
//                         width: MediaQuery.of(context).size.width / 10,
//                         child: ElevatedButton(
//                           child: Text(
//                             "Physical Therapy",
//                             style: ThemeManagerWhite.customTextStyle(context),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.zero,
//                             ),
//                             backgroundColor: Color(0xff6928A).withOpacity(0.45),
//                             elevation: 3,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                       Text(
//                         "Employment Type",
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         "Saan joes.24",
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         "Address",
//                         style: ThemeManagerBlack.customTextStyle(context),
//                       ),
//                       Text(
//                         "House No., Street No.\n Area City, Zip Code",
//                         textAlign: TextAlign.start,
//                         style: ThemeManagerAccentblue.customTextStyle(context),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 50,
//                 ),
//
//                 /// 3rd column
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     bottom: 10,
//                     top: 10,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: MyConstants.personalInfoTexts(context),
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 50,
//                 ),
//
//                 /// 4th column
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, bottom: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ///text john scott
//                       Text(
//                         "05-03-1997(27)",
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         "Male",
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         "****-**-***",
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//
//                       ///phone, comment
//                       Row(
//                         children: [
//                           Text(
//                             "(+1)-123-567",
//                             style: ThemeManagerDark.customTextStyle(context),
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Icon(
//                             Icons.phone,
//                             color: Colors.green,
//                             size: 13,
//                           ),
//                           Icon(
//                             Icons.comment,
//                             color: Colors.blue,
//                             size: 13,
//                           )
//                         ],
//                       ),
//
//                       ///phone, comment
//                       Row(
//                         children: [
//                           Text(
//                             "(+1)-123-567",
//                             style: ThemeManagerDark.customTextStyle(context),
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Icon(
//                             Icons.phone,
//                             color: Colors.green,
//                             size: 13,
//                           ),
//                           Icon(
//                             Icons.comment,
//                             color: Colors.blue,
//                             size: 13,
//                           )
//                         ],
//                       ),
//
//                       ///phone, comment
//                       Row(
//                         children: [
//                           Text(
//                             "(+1)-123-567",
//                             style: ThemeManagerDark.customTextStyle(context),
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Icon(
//                             Icons.phone,
//                             color: Colors.green,
//                             size: 13,
//                           ),
//                           Icon(
//                             Icons.comment,
//                             color: Colors.blue,
//                             size: 13,
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 15,
//                 ),
//
//                 ///5th column
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     bottom: 10,
//                     top: 10,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: MyConstantsColumn.personalInfoTexts(context),
//                   ),
//                 ),
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width / 50,
//                 ),
//
//                 /// 6th column
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, bottom: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       ///text john scott
//                       Text("personal@gmail.com",
//                           style: TextStyle(
//                             fontFamily: 'FiraSans',
//                             fontSize: 9,
//                             color: Colors.blueAccent,
//                             decoration: TextDecoration.underline,
//                             decorationColor: Colors.blueAccent,
//                           )),
//                       Text(
//                         "personal@gmail.com",
//                         style: TextStyle(
//                           fontFamily: 'FiraSans',
//                           fontSize: 9,
//                           color: Colors.blueAccent,
//                           decoration: TextDecoration.underline,
//                           decorationColor: Colors.blueAccent,
//                         ),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Prohealth San Joes 74",
//                             style: ThemeManagerDark.customTextStyle(context),
//                           ),
//                           SizedBox(
//                               width: MediaQuery.of(context).size.width / 99),
//                           // CustomIconButton(text: 'View Zone', onPressed: (){})
//                           // Container(
//                           //   height: MediaQuery.of(context).size.height / 40,
//                           //   width: MediaQuery.of(context).size.width / 17,
//                           //   margin: EdgeInsets.only(right: 40),
//                           //   child: CustomIconButton(
//                           //       text: 'View Zone', onPressed: () {}),
//                           // ),
//                           // ElevatedButton(
//                           //   onPressed: (){}, // Conditionally include the icon
//                           //    child: Text('View Zone',
//                           //     style: TextStyle(
//                           //       fontFamily: 'FiraSans',
//                           //       fontSize: 12,
//                           //       fontWeight: FontWeight.w700,
//                           //       color: Colors.white,
//                           //     ),
//                           //   ),
//                           //   style: ElevatedButton.styleFrom(
//                           //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                           //     backgroundColor: Color(0xFF50B5E5),
//                           //     shadowColor: Colors.grey,
//                           //     shape: RoundedRectangleBorder(
//                           //       borderRadius: BorderRadius.circular(12),
//                           //     ),
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                       Text(
//                         "Phone No.",
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         "Physical Thearpy",
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                       Text(
//                         "NA",
//                         style: ThemeManagerDark.customTextStyle(context),
//                       ),
//                     ],
//                   ),
//                 ),
//
//                 ///7th column
//                 Padding(
//                   padding: EdgeInsets.only(
//                       top: 10,
//                       left: MediaQuery.of(context).size.width / 20,
//                       right: MediaQuery.of(context).size.height / 50),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       ///Hide Date
//                       Row(
//                         children: [
//                           Text(
//                             "Hide Date",
//                             style: ThemeManagerDark.customTextStyle(context),
//                           ),
//                           SizedBox(
//                             width: MediaQuery.of(context).size.width / 40,
//                           ),
//                           Text(
//                             "09/02/2024(11 PM)",
//                             style: ThemeManagerDark.customTextStyle(context),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 8,
//                       ),
//
//                       ///"Expired License"
//                       Row(
//                         children: [
//                           Text(
//                             "Expired License",
//                             style:
//                                 ThemeManagerAccentblue.customTextStyle(context),
//                           ),
//                           ClipOval(
//                               child: Container(
//                             height: MediaQuery.of(context).size.height / 55,
//                             width: MediaQuery.of(context).size.width / 99,
//                             decoration:
//                                 BoxDecoration(color: Colors.red, boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey.shade600,
//                                   spreadRadius: 1,
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 15))
//                             ]),
//                             child: Text(
//                               "0",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize:
//                                       MediaQuery.of(context).size.width / 140,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           )),
//                         ],
//                       ),
//
//                       ///"About To Expired License"
//                       Row(
//                         children: [
//                           Text(
//                             "About To Expired License",
//                             style:
//                                 ThemeManagerAccentblue.customTextStyle(context),
//                           ),
//                           ClipOval(
//                               child: Container(
//                             height: MediaQuery.of(context).size.height / 55,
//                             width: MediaQuery.of(context).size.width / 99,
//                             decoration:
//                                 BoxDecoration(color: Colors.green, boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey.shade600,
//                                   spreadRadius: 1,
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 15))
//                             ]),
//                             child: Text(
//                               "2",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize:
//                                       MediaQuery.of(context).size.width / 140,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           )),
//                         ],
//                       ),
//
//                       ///"Up To Date License"
//                       Row(
//                         children: [
//                           Text(
//                             "Up To Date License",
//                             style:
//                                 ThemeManagerAccentblue.customTextStyle(context),
//                           ),
//                           ClipOval(
//                               child: Container(
//                             height: MediaQuery.of(context).size.height / 55,
//                             width: MediaQuery.of(context).size.width / 99,
//                             decoration:
//                                 BoxDecoration(color: Colors.yellow, boxShadow: [
//                               BoxShadow(
//                                   color: Colors.grey.shade600,
//                                   spreadRadius: 1,
//                                   blurRadius: 10,
//                                   offset: const Offset(0, 15))
//                             ]),
//                             child: Text(
//                               "1",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   fontSize:
//                                       MediaQuery.of(context).size.width / 140,
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           )),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             )),
//       ),
//     ]);
//   }
// }

import 'package:flutter/material.dart';
import '../../../app/theme_manager.dart';
import '../profile_bar/widget/profil_custom_widget.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          elevation: 4,
          child: Container(
              height: MediaQuery.of(context).size.height / 4,
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xFF52A889),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Profile\n100%",
                      style: ThemeManagerWhite.customTextStyle(context),
                    ),
                  ])),
        ),
        Material(
          elevation: 4,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8), topRight: Radius.circular(8)),
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topRight: Radius.circular(8)),
              color: Color(0xffB1D6F4).withOpacity(0.25),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'images/profile.png',
                              height: 50,
                              width: 50,
                            ),
                            // you can replace
                            SizedBox(
                              height: 53,
                              width: 53,
                              child: const CircularProgressIndicator(
                                valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.green),
                                strokeWidth: 3,
                                value: 0.70,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Active",
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      Text(
                        "Annual skills 92%",
                        style: ThemeManager.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///text john scott
                      Text(
                        "John Scott",
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 40,
                        width: MediaQuery.of(context).size.width / 10,
                        child: ElevatedButton(
                          child: Text(
                            "Physical Therapy",
                            style: ThemeManagerWhite.customTextStyle(context),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            backgroundColor: Color(0xffF6928A).withOpacity(0.9),
                            elevation: 4,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      Text(
                        "Employment Type",
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        "Saan joes.24",
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        "Address",
                        style: ThemeManagerBlack.customTextStyle(context),
                      ),
                      Text(
                        "House No., Street No. Area City, Zip\nCode",
                        textAlign: TextAlign.start,
                        style: ThemeManagerAccentblue.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: MyConstants.personalInfoTexts(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///text john scott
                      Text(
                        "05-03-1997(27)",
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        "Male",
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        "****-**-***",
                        style: ThemeManagerDark.customTextStyle(context),
                      ),

                      ///phone, comment
                      Row(
                        children: [
                          Text(
                            "(+1)-123-567",
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 13,
                          ),
                          Icon(
                            Icons.comment,
                            color: Colors.blue,
                            size: 13,
                          )
                        ],
                      ),

                      ///phone, comment
                      Row(
                        children: [
                          Text(
                            "(+1)-123-567",
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 13,
                          ),
                          Icon(
                            Icons.comment,
                            color: Colors.blue,
                            size: 13,
                          )
                        ],
                      ),

                      ///phone, comment
                      Row(
                        children: [
                          Text(
                            "(+1)-123-567",
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.phone,
                            color: Colors.green,
                            size: 13,
                          ),
                          Icon(
                            Icons.comment,
                            color: Colors.blue,
                            size: 13,
                          )
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: MyConstantsColumn.personalInfoTexts(context),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("personal@gmail.com",
                          style: TextStyle(
                            fontFamily: 'FiraSans',
                            fontSize: 9,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blueAccent,
                          )),
                      Text(
                        "personal@gmail.com",
                        style: TextStyle(
                          fontFamily: 'FiraSans',
                          fontSize: 9,
                          color: Colors.blueAccent,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blueAccent,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Prohealth San Joes 74",
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 99),
                          Container(
                            height: MediaQuery.of(context).size.height / 35,
                            width: MediaQuery.of(context).size.width / 17,
                            margin: EdgeInsets.only(right: 40),
                            child: ElevatedButton(
                              onPressed:
                                  () {},
                              child: Text(
                                'View Zone',
                                style: TextStyle(
                                    fontFamily: 'FiraSans',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                    decorationColor: Colors.white
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                backgroundColor: Color(0xFF50B5E5),
                                shadowColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Phone No.",
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        "Physical Thearpy",
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                      Text(
                        "NA",
                        style: ThemeManagerDark.customTextStyle(context),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hide Date",
                            style:TextStyle(
                              fontFamily: 'FiraSans',
                              fontSize: 10,
                              color: Color(0xFF686464),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 35,
                          ),
                          Text(
                            "09/02/2024(11 PM)",
                            style: ThemeManagerDark.customTextStyle(context),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height / 10,
                      // ),

                      ///"Expired License"
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Expired License",
                                style:
                                ThemeManagerAccentblue.customTextStyle(context),
                              ),
                              ClipOval(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 55,
                                    width: MediaQuery.of(context).size.width / 99,
                                    decoration:
                                    BoxDecoration(color: Colors.red, boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade600,
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: const Offset(0, 15))
                                    ]),
                                    child: Text(
                                      "0",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width / 140,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                            ],
                          ),
                          ///"About To Expired License"
                          Row(
                            children: [
                              Text(
                                "About To Expired License",
                                style:
                                ThemeManagerAccentblue.customTextStyle(context),
                              ),
                              ClipOval(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 55,
                                    width: MediaQuery.of(context).size.width / 99,
                                    decoration:
                                    BoxDecoration(color: Colors.green, boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade600,
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: const Offset(0, 15))
                                    ]),
                                    child: Text(
                                      "2",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width / 140,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                            ],
                          ),

                          ///"Up To Date License"
                          Row(
                            children: [
                              Text(
                                "Up To Date License",
                                style:
                                ThemeManagerAccentblue.customTextStyle(context),
                              ),
                              ClipOval(
                                  child: Container(
                                    height: MediaQuery.of(context).size.height / 55,
                                    width: MediaQuery.of(context).size.width / 99,
                                    decoration:
                                    BoxDecoration(color: Colors.yellow, boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade600,
                                          spreadRadius: 1,
                                          blurRadius: 10,
                                          offset: const Offset(0, 15))
                                    ]),
                                    child: Text(
                                      "1",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize:
                                          MediaQuery.of(context).size.width / 140,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
