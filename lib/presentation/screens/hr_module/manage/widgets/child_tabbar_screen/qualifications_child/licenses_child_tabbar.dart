import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/hr_module_manager/manage_emp/qulification_licenses_manager.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/const_wrap_widget.dart';
import '../../../../../../../../app/resources/theme_manager.dart';
import '../../../../../../../data/api_data/hr_module_data/manage/qualification_licenses.dart';
import '../../custom_icon_button_constant.dart';
import '../../row_container_widget_const.dart';
///done by saloni
class LicensesChildTabbar extends StatefulWidget {
  const LicensesChildTabbar({super.key});

  @override
  State<LicensesChildTabbar> createState() => _LicensesChildTabbarState();
}

class _LicensesChildTabbarState extends State<LicensesChildTabbar> {
  final StreamController<List<QulificationLicensesData>> streamController = StreamController<List<QulificationLicensesData>>();
  @override
  void initState() {
    // TODO: implement initState
    getEmployeeLicenses(context,0).then((data) {
      streamController.add(data);
    }).catchError((error) {
      // Handle error
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QulificationLicensesData>>(
      stream: streamController.stream,
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: CircularProgressIndicator(
                color: ColorManager.blueprime,
              ),
            ),
          );
        }
        if (snapshot.data!.isEmpty) {
          return Center(
              child: Text(
                AppString.dataNotFound,
                style: CustomTextStylesCommon.commonStyle(
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSize.s12,
                    color: ColorManager.mediumgrey),
              ));
        }
        if(snapshot.hasData){
          return WrapWidget(
              childern:
              List.generate(snapshot.data!.length, (index){
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                  child: Container(
                    //height:300,
                    width: MediaQuery.of(context).size.width/2.5,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 80,
                        vertical: MediaQuery.of(context).size.height / 120,
                      ),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text('License #1',
                                style: TextStyle(
                                  fontFamily: 'FiraSans',
                                  fontSize: 13,
                                  color: Color(0xFF333333),
                                  fontWeight: FontWeight.bold,
                                ),),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/50,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Licensure/Certification',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 10,),
                                  Text('Issuing Organization',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 10,),
                                  Text('Country',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 10,),
                                  Text('Number/ID',
                                      style: ThemeManager.customTextStyle(context)),
                                ],),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].licenure,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 10,),
                                  Text(snapshot.data![index].org,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 10,),
                                  Text(snapshot.data![index].country,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 10,),
                                  Text(snapshot.data![index].licenseNumber,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                ],
                              ),
                              Column(
                                children: [
                                  Text('Issue Date',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 10,),
                                  Text('End Date',
                                      style: ThemeManager.customTextStyle(context)),
                                  const SizedBox(height: 50,)
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].issueDate,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 10,),
                                  Text(snapshot.data![index].expData,
                                    style: ThemeManagerDark.customTextStyle(context),),
                                  const SizedBox(height: 50,)

                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height/40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              snapshot.data![index].approved == false ?
                              CustomButtonTransparent(text: 'Reject', onPressed: () async{
                                await rejectLicensePatch(context, snapshot.data![index].licenseId);
                              }) :SizedBox() ,
                              const SizedBox(width: 5,),
                              snapshot.data![index].approved == true ?
                              Text('Approved',
                                  textAlign: TextAlign.center,
                                  style: CustomTextStylesCommon.commonStyle(
                                      fontSize: FontSize.s12,
                                      fontWeight: FontWeightManager.bold,
                                      color: ColorManager.blueprime)) :  CustomIconButton(
                                  text: 'Approve', onPressed: () async{
                                await approveLicensePatch(context, snapshot.data![index].licenseId);
                              })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })

            //   Container(
            //   height: 200,
            //   width: MediaQuery.of(context).size.width/5,
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           Text('License #1',
            //             style: TextStyle(
            //               fontFamily: 'FiraSans',
            //               fontSize: 13,
            //               color: Color(0xFF333333),
            //               fontWeight: FontWeight.bold,
            //             ),),
            //         ],
            //       ),
            //       SizedBox(height: MediaQuery.of(context).size.height/50,),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text('Licensure/Certification',
            //                   style: ThemeManager.customTextStyle(context)),
            //               SizedBox(height: 10,),
            //               Text('Issuing Organization',
            //                   style: ThemeManager.customTextStyle(context)),
            //               SizedBox(height: 10,),
            //               Text('Country',
            //                   style: ThemeManager.customTextStyle(context)),
            //               SizedBox(height: 10,),
            //               Text('Number/ID',
            //                   style: ThemeManager.customTextStyle(context)),
            //             ],),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text('Driving',
            //                 style: ThemeManagerDark.customTextStyle(context),),
            //               SizedBox(height: 10,),
            //               Text('Health Ministry',
            //                 style: ThemeManagerDark.customTextStyle(context),),
            //               SizedBox(height: 10,),
            //               Text('USA',
            //                 style: ThemeManagerDark.customTextStyle(context),),
            //               SizedBox(height: 10,),
            //               Text('123345555',
            //                 style: ThemeManagerDark.customTextStyle(context),),
            //             ],
            //           ),
            //           Column(
            //             children: [
            //               Text('Issue Date',
            //                   style: ThemeManager.customTextStyle(context)),
            //               SizedBox(height: 10,),
            //               Text('End Date',
            //                   style: ThemeManager.customTextStyle(context)),
            //               SizedBox(height: 50,)
            //             ],
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text('2023-08-09',
            //                 style: ThemeManagerDark.customTextStyle(context),),
            //               SizedBox(height: 10,),
            //               Text('2024-03-20',
            //                 style: ThemeManagerDark.customTextStyle(context),),
            //               SizedBox(height: 50,)
            //
            //             ],
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: MediaQuery.of(context).size.height/40,),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           CustomButtonTransparent(text: 'Reject', onPressed: (){}),
            //           SizedBox(width: 5,),
            //           CustomIconButton(
            //               text: 'Approve', onPressed: (){}),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            //   Container(
            //     height: 200,
            //     width: MediaQuery.of(context).size.width/2,
            //     child: Column(
            //       children: [
            //         Row(
            //           children: [
            //             Text('License #1',
            //               style: TextStyle(
            //                 fontFamily: 'FiraSans',
            //                 fontSize: 13,
            //                 color: Color(0xFF333333),
            //                 fontWeight: FontWeight.bold,
            //               ),),
            //           ],
            //         ),
            //         SizedBox(height: MediaQuery.of(context).size.height/50,),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Licensure/Certification',
            //                     style: ThemeManager.customTextStyle(context)),
            //                 SizedBox(height: 10,),
            //                 Text('Issuing Organization',
            //                     style: ThemeManager.customTextStyle(context)),
            //                 SizedBox(height: 10,),
            //                 Text('Country',
            //                     style: ThemeManager.customTextStyle(context)),
            //                 SizedBox(height: 10,),
            //                 Text('Number/ID',
            //                     style: ThemeManager.customTextStyle(context)),
            //               ],),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('Driving',
            //                   style: ThemeManagerDark.customTextStyle(context),),
            //                 SizedBox(height: 10,),
            //                 Text('Health Ministry',
            //                   style: ThemeManagerDark.customTextStyle(context),),
            //                 SizedBox(height: 10,),
            //                 Text('USA',
            //                   style: ThemeManagerDark.customTextStyle(context),),
            //                 SizedBox(height: 10,),
            //                 Text('123345555',
            //                   style: ThemeManagerDark.customTextStyle(context),),
            //               ],
            //             ),
            //             Column(
            //               children: [
            //                 Text('Issue Date',
            //                     style: ThemeManager.customTextStyle(context)),
            //                 SizedBox(height: 10,),
            //                 Text('End Date',
            //                     style: ThemeManager.customTextStyle(context)),
            //                 SizedBox(height: 50,)
            //               ],
            //             ),
            //             Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text('2023-08-09',
            //                   style: ThemeManagerDark.customTextStyle(context),),
            //                 SizedBox(height: 10,),
            //                 Text('2024-03-20',
            //                   style: ThemeManagerDark.customTextStyle(context),),
            //                 SizedBox(height: 50,)
            //
            //               ],
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: MediaQuery.of(context).size.height/40,),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             CustomButtonTransparent(text: 'Reject', onPressed: (){}),
            //             SizedBox(width: 5,),
            //             CustomIconButton(
            //                 text: 'Approve', onPressed: (){}),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
          );
        }
        else{
          return const SizedBox();
        }
      }
    );
    //   Padding(
    //   padding: EdgeInsets.symmetric(
    //       horizontal: MediaQuery.of(context).size.width/80,
    //       vertical: MediaQuery.of(context).size.height/100),
    //   child: TwoContainersRow(
    //     child1: Column(
    //       children: [
    //         Row(
    //           children: [
    //             Text('License #1',
    //               style: TextStyle(
    //                 fontFamily: 'FiraSans',
    //                 fontSize: 13,
    //                 color: Color(0xFF333333),
    //                 fontWeight: FontWeight.bold,
    //               ),),
    //           ],
    //         ),
    //         SizedBox(height: MediaQuery.of(context).size.height/50,),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //               Text('Licensure/Certification',
    //                   style: ThemeManager.customTextStyle(context)),
    //               SizedBox(height: 10,),
    //               Text('Issuing Organization',
    //                   style: ThemeManager.customTextStyle(context)),
    //               SizedBox(height: 10,),
    //               Text('Country',
    //                   style: ThemeManager.customTextStyle(context)),
    //               SizedBox(height: 10,),
    //               Text('Number/ID',
    //                   style: ThemeManager.customTextStyle(context)),
    //             ],),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text('Driving',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 10,),
    //                 Text('Health Ministry',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 10,),
    //                 Text('USA',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 10,),
    //                 Text('123345555',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 Text('Issue Date',
    //                     style: ThemeManager.customTextStyle(context)),
    //                 SizedBox(height: 10,),
    //                 Text('End Date',
    //                     style: ThemeManager.customTextStyle(context)),
    //                 SizedBox(height: 50,)
    //               ],
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text('2023-08-09',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 10,),
    //                 Text('2024-03-20',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 50,)
    //
    //               ],
    //             ),
    //           ],
    //         ),
    //         SizedBox(height: MediaQuery.of(context).size.height/40,),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: [
    //             CustomButtonTransparent(text: 'Reject', onPressed: (){}),
    //             SizedBox(width: 5,),
    //             CustomIconButton(
    //                 text: 'Approve', onPressed: (){}),
    //           ],
    //         )
    //       ],
    //     ),
    //     child2: Column(
    //       children: [
    //         Row(
    //           children: [
    //             Text('License #2',
    //               style: TextStyle(
    //                 fontFamily: 'FiraSans',
    //                 fontSize: 13,
    //                 color: Color(0xFF333333),
    //                 fontWeight: FontWeight.bold,
    //               ),),
    //           ],
    //         ),
    //         SizedBox(height: MediaQuery.of(context).size.height/50,),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text('Licensure/Certification',
    //                     style: ThemeManager.customTextStyle(context)),
    //                 SizedBox(height: 10,),
    //                 Text('Issuing Organization',
    //                     style: ThemeManager.customTextStyle(context)),
    //                 SizedBox(height: 10,),
    //                 Text('Country',
    //                     style: ThemeManager.customTextStyle(context)),
    //                 SizedBox(height: 10,),
    //                 Text('Number/ID',
    //                     style: ThemeManager.customTextStyle(context)),
    //               ],),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text('Driving',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 10,),
    //                 Text('Health Ministry',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 10,),
    //                 Text('USA',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 10,),
    //                 Text('123345555',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //               ],
    //             ),
    //             Column(
    //               children: [
    //                 Text('Issue Date',
    //                     style: ThemeManager.customTextStyle(context)),
    //                 SizedBox(height: 10,),
    //                 Text('End Date',
    //                     style: ThemeManager.customTextStyle(context)),
    //                 SizedBox(height: 50,)
    //               ],
    //             ),
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text('2023-08-09',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 10,),
    //                 Text('2024-03-20',
    //                   style: ThemeManagerDark.customTextStyle(context),),
    //                 SizedBox(height: 50,)
    //
    //               ],
    //             ),
    //           ],
    //         ),
    //         SizedBox(height: MediaQuery.of(context).size.height/40,),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: [
    //             CustomButtonTransparent(text: 'Reject', onPressed: (){}),
    //             SizedBox(width: 5,),
    //             CustomIconButton(
    //                 text: 'Approve', onPressed: (){}),
    //           ],
    //         )
    //       ],
    //     ),),
    // );
  }
}