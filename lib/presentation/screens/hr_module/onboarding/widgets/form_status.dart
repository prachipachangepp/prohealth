import 'dart:async';

import 'package:flutter/material.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/download_doc_const.dart';
import 'package:prohealth/presentation/screens/hr_module/onboarding/widgets/widgets/banking_tab_constant.dart';
import '../../../../../app/resources/color.dart';
import '../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../app/resources/const_string.dart';
import '../../../../../app/resources/font_manager.dart';
import '../../../../../app/resources/theme_manager.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../../../app/services/api/managers/hr_module_manager/onboarding_manager/form_status_manager.dart';
import '../../../../../data/api_data/hr_module_data/onboarding_data/form_status_data.dart';
import '../../manage/widgets/icon_button_constant.dart';

class FormStatusScreen extends StatefulWidget {
  final int employeeId;
   FormStatusScreen({super.key,required this.employeeId});

  @override
  State<FormStatusScreen> createState() => _FormStatusScreenState();
}

class _FormStatusScreenState extends State<FormStatusScreen> {
  final StreamController<List<FormModel>> formController =
  StreamController<List<FormModel>>();
  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }
  @override
  void initState() {
    super.initState();
    getFormStatus(context,widget.employeeId,).then((data){
      formController.add(data);
    }).catchError((error){});
  }
  @override
  Widget build(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.59;

    return Column(
      children: [
        Expanded(
          child: StreamBuilder<List<FormModel>>(
            stream: formController.stream,
            builder: (context, snapshot) {
              print('1111111');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorManager.blueprime,
                  ),
                );
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    AppStringHRNoData.noOnboardFormStatus,
                    style: AllNoDataAvailable.customTextStyle(context),
                  ),
                );
              }
              if (snapshot.hasData) {
                // int totalItems = snapshot.data!.length;
                // int totalPages = (totalItems / itemsPerPage).ceil();
                // List<FormModel> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();
                 return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                           FormModel formStatus = snapshot.data![index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 60.0),
                                  child: Material(
                                    color: ColorManager.white,
                                    elevation: 4,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      width: containerWidth,
                                      height: AppSize.s88,
                                      decoration: BoxDecoration(
                                        color: ColorManager.white,
                                        borderRadius: BorderRadius.circular(20),
                                        // border: Border.all(
                                        //   width: AppSize.s1,
                                        //   color: ColorManager.white,
                                        // ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              ///status
                                              Container(
                                                  width: AppSize.s88,
                                                  height: AppSize.s20,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    formStatus.signed == false
                                                        ?  ColorManager.redSign
                                                        : ColorManager.greenF,
                                                    borderRadius: BorderRadius.only(
                                                        topRight:
                                                        Radius.circular(20)),),
                                                  child: Center(
                                                    child: Text(
                                                     formStatus.signed == true ? 'Signed' : 'Unsigned',
                                                        textAlign: TextAlign.center,
                                                        style: CustomTextStylesCommon.commonStyle(
                                                            color: ColorManager.white,
                                                            fontSize: FontSize.s12,
                                                            fontWeight: FontWeight.w600)),
                                                  )),
                                            ],
                                          ),
                                          SizedBox(height: AppSize.s5),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p40),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                    width: 62,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: ColorManager.faintGrey),
                                                    ),
                                                    child: Image.asset('images/Vector.png')),
                                                SizedBox(width: AppSize.s30),
                                                Expanded(
                                                  child: Text(
                                                  formStatus.htmlname,
                                                    style: AknowledgementStyleConst.customTextStyle(context),
                                                  ),
                                                ),
                                                formStatus.signed == true ?
                                                // Container(
                                                //   height: 32,
                                                //   decoration: BoxDecoration(
                                                //     border: Border.all(color: const Color(0xff1696C8)),
                                                //     borderRadius: BorderRadius.circular(8),
                                                //   ),
                                                //   padding: EdgeInsets.only(bottom: 5,left: 10),
                                                //   child:
                                                  // Row(
                                                  //   children: [
                                                  //     Padding(
                                                  //       padding: const EdgeInsets.only(top: 6.0),
                                                  //       child: Text('Download',style: TextStyle(
                                                  //         fontWeight: FontWeight.w700,
                                                  //         fontSize: FontSize.s12,
                                                  //         color: Color(0xff1696C8),
                                                  //       ),),
                                                  //     ),
                                                      PdfDownloadButton(apiUrl: formStatus.url, documentName: formStatus.htmlname,)
                                                  //   ],
                                                  // ),
                                                  // IconButtonWidget(
                                                  //   width: AppSize.s110,
                                                  //   iconData1: Icons.save_alt_outlined,
                                                  //   buttonText: 'Download',
                                                  //   onPressed: (){
                                                  //     downloadFile(formStatus.url);
                                                  //   },
                                                  // ),
                                              //  )
                                              : SizedBox(width: AppSize.s110,),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppSize.s5,
                                )
                              ],
                            );
                          }),
                    ),
                    SizedBox(height: AppSize.s5),
                  ],
                                   );
             }
              return Offstage();
            },
          ),
        )
      ],
    );
  }
}
///dynamic list
// class FormStatusScreen extends StatefulWidget {
//   final int employeeId;
//   FormStatusScreen({super.key, required this.employeeId});
//
//   @override
//   State<FormStatusScreen> createState() => _FormStatusScreenState();
// }
//
// class _FormStatusScreenState extends State<FormStatusScreen> {
//   final StreamController<List<dynamic>> formController =
//   StreamController<List<dynamic>>();
//
//   int currentPage = 1;
//   final int itemsPerPage = 10;
//
//   @override
//   void initState() {
//     super.initState();
//     getFormStatus(context: context, employeeId: 169).then((data) {
//       /// Combine signedForms and unsignedForms into a single list
//       List<dynamic> allForms = [
//         ...data?.signedForms ?? [],
//         ...data?.unsignedForms ?? [],
//       ];
//       formController.add(allForms);
//     }).catchError((error) {
//       print("Error: $error");
//     });
//   }
//
//   void onPageNumberPressed(int pageNumber) {
//     setState(() {
//       currentPage = pageNumber;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double containerWidth = MediaQuery.of(context).size.width * 0.9;
//
//     return Column(
//       children: [
//         Expanded(
//           child: StreamBuilder<List<dynamic>>(
//             stream: formController.stream,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: ColorManager.blueprime,
//                   ),
//                 );
//               }
//               if (snapshot.data == null || snapshot.data!.isEmpty) {
//                 return Center(
//                   child: Text(
//                     AppStringHRNoData.noOnboardingData,
//                     style: AllNoDataAvailable.customTextStyle(context),
//                   ),
//                 );
//               }
//
//               if (snapshot.hasData) {
//                 int totalItems = snapshot.data!.length;
//                 int totalPages = (totalItems / itemsPerPage).ceil();
//                 List<dynamic> paginatedData = snapshot.data!
//                     .skip((currentPage - 1) * itemsPerPage)
//                     .take(itemsPerPage)
//                     .toList();
//
//                 return Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                         itemCount: paginatedData.length,
//                         itemBuilder: (context, index) {
//                           var formStatus = paginatedData[index];
//
//                           return Column(
//                             children: [
//                               Material(
//                                 color: ColorManager.white,
//                                 elevation: 4,
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: Container(
//                                   width: containerWidth,
//                                   height: AppSize.s88,
//                                   decoration: BoxDecoration(
//                                     color: ColorManager.white,
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.end,
//                                         crossAxisAlignment: CrossAxisAlignment.end,
//                                         children: [
//                                           /// Status Indicator
//                                           Container(
//                                             width: AppSize.s88,
//                                             height: AppSize.s20,
//                                             decoration: BoxDecoration(
//                                               color: formStatus.signed
//                                                   ? ColorManager.greenF
//                                                   : ColorManager.redSign,
//                                               borderRadius: const BorderRadius.only(
//                                                 topRight: Radius.circular(20),
//                                               ),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 formStatus.signed ? "Signed" : "Unsigned",
//                                                 textAlign: TextAlign.center,
//                                                 style: CustomTextStylesCommon.commonStyle(
//                                                   color: ColorManager.white,
//                                                   fontSize: FontSize.s12,
//                                                   fontWeight: FontWeight.w600,
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: AppSize.s5),
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: AppPadding.p40),
//                                         child: Row(
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                           children: [
//                                             Container(
//                                               width: 62,
//                                               height: 45,
//                                               decoration: BoxDecoration(
//                                                 borderRadius: BorderRadius.circular(4),
//                                                 border: Border.all(
//                                                   width: 2,
//                                                   color: ColorManager.faintGrey,
//                                                 ),
//                                               ),
//                                               child: Image.asset('images/Vector.png'),
//                                             ),
//                                             SizedBox(width: AppSize.s30),
//                                             Expanded(
//                                               child: Text(
//                                                 formStatus.htmlname,
//                                                 style: AknowledgementStyleConst.customTextStyle(context),
//                                               ),
//                                             ),
//                                             Container(
//                                               height: 32,
//                                               decoration: BoxDecoration(
//                                                 border: Border.all(
//                                                   color: const Color(0xff1696C8),
//                                                 ),
//                                                 borderRadius: BorderRadius.circular(8),
//                                               ),
//                                               child: IconButtonWidget(
//                                                 width: AppSize.s110,
//                                                 iconData1: Icons.save_alt_outlined,
//                                                 buttonText: 'Download',
//                                                 onPressed: () {
//                                                   // Handle download action
//                                                 },
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: AppSize.s5),
//                             ],
//                           );
//                         },
//                       ),
//                     ),
//                     SizedBox(height: AppSize.s5),
//                   ],
//                 );
//               }
//               return Offstage();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
