import 'package:flutter/material.dart';

import '../../../../app/resources/color.dart';
import '../../../../app/resources/establishment_resources/establish_theme_manager.dart';
import '../../../../app/resources/establishment_resources/establishment_string_manager.dart';
import '../../../../app/resources/value_manager.dart';

class ClinicalHrScreen extends StatefulWidget {
  const ClinicalHrScreen({super.key});

  @override
  State<ClinicalHrScreen> createState() => _ClinicalHrScreenState();
}

class _ClinicalHrScreenState extends State<ClinicalHrScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height/60,),
        Container(
          height: 30,
          decoration: BoxDecoration(
            color: ColorManager.fmediumgrey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Text(''),
                Text(
                    AppStringEM.srno,
                    style:  AllHRTableHeading.customTextStyle(context)
                ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(AppStringEM.type,textAlign: TextAlign.start,
                      style:  AllHRTableHeading.customTextStyle(context)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Text(
                      AppStringEM.name,
                      style:  AllHRTableHeading.customTextStyle(context)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                      AppStringEM.location,
                      style:  AllHRTableHeading.customTextStyle(context)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(AppStringEM.specialization,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(AppStringEM.edit,
                      textAlign: TextAlign.start,
                      style: AllHRTableHeading.customTextStyle(context)),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height/60,),
        // Container(
        //   height: 32,
        //   width: 1400,
        //   child: Row(
        //     children: [
        //       Text(
        //           '01',
        //         style: TextStyle(
        //           fontSize: 10,
        //           fontWeight: FontWeight.w500,
        //           color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         'RN',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         'Dhillon Amarpreet',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         'ProHealth Walnut Creek-EI Dorado Sacramento',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         'Infection control',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //
        //       Text(
        //         '01',
        //         style: TextStyle(
        //             fontSize: 10,
        //             fontWeight: FontWeight.w500,
        //             color: Color(0xff454545)
        //         ),
        //       ),
        //     ],
        //   ),
        // )


        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 2,
              itemBuilder: (context, index) {
                // int serialNumber =
                //     index + 1 + (currentPage - 1) * itemsPerPage;
                // String formattedSerialNumber =
                // serialNumber.toString().padLeft(2, '0');
          
                return Container(
                    margin: EdgeInsets.all(5,),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    height: AppSize.s56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Text(
                              '1',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                              // snapshot.data![index].empType.toString(),
                            "RN",
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                              // snapshot.data![index].abbrivation.toString(),
                            'Dhillon Amarpreet',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)
                          ),
                        ),

                        Expanded(
                          flex: 3,
                          child: Text(
                            // snapshot.data![index].abbrivation.toString(),
                              'ProHealth Walnut Creek-EI Dorado Sacramento',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)
                          ),
                        ),

                        Expanded(
                          flex: 2,
                          child: Text(
                            // snapshot.data![index].abbrivation.toString(),
                              'Infection control',
                              textAlign: TextAlign.center,
                              style: AllHRTableData.customTextStyle(context)
                          ),
                        ),
                        // Expanded(
                        //   flex: 2,
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width / 20,
                        //     height: AppSize.s22,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(8),
                        //       // color: snapshot.data![index].color?.toColor,
                        //     ),
                        //   ),
                        // ),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ///edit
                              IconButton(
                                onPressed: () {
                                  // showDialog(
                                  //   context: context, builder: (BuildContext context) {
                                  //   return FutureBuilder<HRGetEmpId>(
                                  //       future: HrGetById(context, snapshot.data![index].employeeTypesId),
                                  //       builder: (context, snapshot) {
                                  //         if(snapshot.connectionState == ConnectionState.waiting){
                                  //           return Center(child:CircularProgressIndicator(color: ColorManager.blueprime,));
                                  //         }
                                  //         var type = snapshot.data?.empType.toString();
                                  //         var shorthand = snapshot.data?.empType.toString();
                                  //         var hexColorData = snapshot.data!.color!.replaceAll("#","").toString();
                                  //         //hexColorData = i.color.replaceAll("#","");
                                  //         Color hexColor = Color(int.parse('0xFF$hexColorData'));
                                  //         print('Hex Color ::::${hexColor}');
                                  //         hrcontainerColors[index] = hexColor;
                                  //         var splitHexColor = hexColor.toString().substring(10,16);
                                  //         typeController = TextEditingController(text: snapshot.data?.empType.toString());
                                  //         shorthandController = TextEditingController(text: snapshot.data?.abbrivation.toString());
                                  //         return EditPopupWidget(
                                  //           typeController: typeController,
                                  //           shorthandController: shorthandController,
                                  //           containerColor: hrcontainerColors[index],
                                  //           onSavePressed: () async{
                                  //             await AllFromHrPatch(context, snapshot.data!.empTypeId, 1,
                                  //                 type == typeController.text ? type.toString() : typeController.text,
                                  //                 shorthand == shorthandController.text ? shorthand.toString() : shorthandController.text,
                                  //                 splitHexColor == hrcontainerColors[index] ? splitHexColor : color );
                                  //             getAllHrDeptWise(context,widget.deptId).then((data){
                                  //               _controller.add(data);
                                  //             }).catchError((error){});
                                  //             Navigator.pop(context);
                                  //             typeController.clear();
                                  //             shorthandController.clear();
                                  //             seletedType = "Administrative";
                                  //           },
                                  //           onColorChanged: (Color seletedColor) {
                                  //             setState(() {
                                  //               hrcontainerColors[index] = seletedColor;
                                  //               print("Color ${seletedColor}");
                                  //               color = seletedColor.toString().substring(10,16);
                                  //               _saveColor(index, seletedColor);
                                  //             });
                                  //           }, title: 'Edit Clinical',
                                  //           child:  FutureBuilder<List<HRHeadBar>>(
                                  //               future: companyHRHeadApi(context,widget.deptId),
                                  //               builder: (context,snapshot) {
                                  //                 if(snapshot.connectionState == ConnectionState.waiting){
                                  //                   return Shimmer.fromColors(
                                  //                       baseColor: Colors.grey[300]!,
                                  //                       highlightColor: Colors.grey[100]!,
                                  //                       child: Container(
                                  //                         width: 350,
                                  //                         height: 30,
                                  //                         decoration: BoxDecoration(color: ColorManager.faintGrey,borderRadius: BorderRadius.circular(10)),
                                  //                       )
                                  //                   );
                                  //                 }
                                  //                 if (snapshot.data!.isEmpty) {
                                  //                   return Center(
                                  //                     child: Text(
                                  //                       AppString.dataNotFound,
                                  //                       style: CustomTextStylesCommon.commonStyle(
                                  //                         fontWeight: FontWeightManager.medium,
                                  //                         fontSize: FontSize.s12,
                                  //                         color: ColorManager.mediumgrey,
                                  //                       ),
                                  //                     ),
                                  //                   );
                                  //                 }
                                  //                 if(snapshot.hasData){
                                  //                   List dropDown = [];
                                  //                   int docType = 0;
                                  //                   List<DropdownMenuItem<String>> dropDownMenuItems = [];
                                  //                   for(var i in snapshot.data!){
                                  //                     dropDownMenuItems.add(
                                  //                       DropdownMenuItem<String>(
                                  //                         child: Text(i.deptName),
                                  //                         value: i.deptName,
                                  //                       ),
                                  //                     );
                                  //                   }
                                  //                   return CICCDropdown(
                                  //                       initialValue: dropDownMenuItems[0].value,
                                  //                       onChange: (val){
                                  //                         for(var a in snapshot.data!){
                                  //                           if(a.deptName == val){
                                  //                             docType = a.deptId;
                                  //                             doceEditMetaId = docType;
                                  //                           }
                                  //                         }
                                  //                         print(":::${docType}");
                                  //                         print(":::<>${doceEditMetaId}");
                                  //                       },
                                  //                       items:dropDownMenuItems
                                  //                   );
                                  //                 }else{
                                  //                   return SizedBox();
                                  //                 }
                                  //               }
                                  //           ),
                                  //           // onColorChanged: (Color color) {
                                  //           //   setState(() {
                                  //           //     containerColors[index] =
                                  //           //      color; // Update color for this item
                                  //           //   });
                                  //           // },
                                  //         );
                                  //       }
                                  //   );
                                  // },
                                  // );
                                },
                                icon: Icon(Icons.edit_outlined,size: 18,),
                                color: ColorManager.blueprime,
                              ),
                              ///delete
                              IconButton(
                                onPressed: () {
                                  // showDialog(context: context,
                                  //     builder: (context) => DeletePopup(
                                  //         onCancel: (){
                                  //           Navigator.pop(context);
                                  //         }, onDelete: () async {
                                  //       await  allfromHrDelete(
                                  //           context, snapshot.data![index].employeeTypesId!);
                                  //       getAllHrDeptWise(context,widget.deptId).then((data){
                                  //         _controller.add(data);
                                  //       }).catchError((error){});
                                  //       Navigator.pop(context);
                                  //     }));
          
                                },
                                icon: Icon(
                                  size: 18,
                                  Icons.delete_outline,
                                  color: Color(0xffF6928A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ));
              }),
        )
      ],

    );
  }
}
