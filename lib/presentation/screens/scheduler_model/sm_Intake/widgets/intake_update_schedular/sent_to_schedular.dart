import 'package:flutter/material.dart';
import 'package:prohealth/presentation/widgets/widgets/constant_textfield/const_textfield.dart';

import '../../../../../../app/resources/color.dart';
import '../../../../../../app/resources/font_manager.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../app/resources/value_manager.dart';

class SentToSchedularScreen extends StatelessWidget {
  const SentToSchedularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 55.0),
      child: Column(
        children: [
          ///button
          Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 320,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  textInputAction: TextInputAction.search,
                  //onSubmitted: (value) => _performSearch(),
                  decoration: InputDecoration(
                    hintText: "Search location",
                    suffixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 7),
                  ),
                ),
              ),
              Row(
                children: [
                  CustomDropdownTextField(
                    width: 150,
                    isAstric:false,
                    // Adjust headText based on depId
                    initialValue: 'Employee Type',
                    headText: "", // Default fallback if depId doesn't match any of the expected values
                    items: ['Employee 1','Employee 2','Employee 3'],
                    onChanged: (newValue) {
                      // for (var a in snapshot.data!) {
                      //   if (a.empType == newValue) {
                      //     clinicialName = a.empType!;
                      //     clinicalId = a.employeeTypesId!;
                      //     print("Dept ID'''''' ${clinicalId}");
                      //     print("';';';''''''''Dept ID ${clinicialName}");
                      //     // Do something with docType
                      //   }
                      // }
                    },
                  ),
                  SizedBox(width: 10,),
                  CustomDropdownTextField(
                    width:150,
                    isAstric:false,
                    // Adjust headText based on depId
                    initialValue: 'Clinician Type',
                    headText: "", // Default fallback if depId doesn't match any of the expected values
                    items: ['Clinical 1','Clinical 2','Clinical 3'],
                    onChanged: (newValue) {
                      // for (var a in snapshot.data!) {
                      //   if (a.empType == newValue) {
                      //     clinicialName = a.empType!;
                      //     clinicalId = a.employeeTypesId!;
                      //     print("Dept ID'''''' ${clinicalId}");
                      //     print("';';';''''''''Dept ID ${clinicialName}");
                      //     // Do something with docType
                      //   }
                      // }
                    },
                  ),
                ],
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 15,
                itemBuilder: (context, index) {
                  //int serialNumber = index + 1 + (currentPage - 1) * itemsPerPage;
                  // String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                  // EmployeeDocumentModal employeedoc = paginatedData[index];
                  return Column(
                    children: [
                      SizedBox(height: AppSize.s5),
                      Container(
                        height: AppSize.s88,
                        padding: EdgeInsets.symmetric(horizontal: AppPadding.p40),
                        margin: EdgeInsets.symmetric(horizontal: AppMargin.m2),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: ColorManager.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Image.asset(
                                        'images/hr_dashboard/man.png', // Replace with your image path
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "John smith",
                                      textAlign: TextAlign.center,
                                      style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w400,
                                        color: ColorManager.textBlack,),
                                    ),
                                    Text(
                                      "Intake Date: 09/15/2024",
                                      textAlign: TextAlign.center,
                                      style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                        fontWeight: FontWeight.w600,
                                        color: ColorManager.mediumgrey,),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                Image.asset(
                                  "images/sm/location.png",
                                  height: 25,width: 26,fit: BoxFit.fill,
                                ),
                                SizedBox(width: 25,),
                                Text(
                                  "Tufts International Center, 20 Sawyer Ave,\nMedford MA 02155 ",
                                  textAlign: TextAlign.start,
                                  style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.textBlack,),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                // Text("POC :",style: DocumentTypeDataStyle.customTextStyle(context),),
                                //  Padding(
                                //    padding: const EdgeInsets.all(8.0),
                                //    child: Container(
                                //      color: Color(0xFF527FB9),
                                //      width: 19,
                                //      height: 19,
                                //      child: Center(
                                //        child: Text("ST",style: TextStyle(
                                //          // fontWeight: FontWeight.w600,
                                //          // fontSize: FontSize.s13,
                                //          color: ColorManager.white,
                                //          decoration: TextDecoration.none,
                                //        ),),
                                //      ),
                                //    ),
                                //  ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    color: Color(0xFFFEBD4D),
                                    width: 19,
                                    height: 19,
                                    child: Center(
                                      child: Text("OT",style: TextStyle(
                                        // fontWeight: FontWeight.w600,
                                        //     fontSize: FontSize.s13,
                                        color: ColorManager.white,
                                        decoration: TextDecoration.none,
                                      ),),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: SizedBox(
                                      width: 50,
                                      height: 50,
                                      child: Image.asset(
                                        'images/hr_dashboard/man.png', // Replace with your image path
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(
                                  "Kia",
                                  textAlign: TextAlign.center,
                                  style: CustomTextStylesCommon.commonStyle(fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorManager.textBlack,),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: Image.asset("images/sm/contact_schedular.png",height: 33,width: 33,fit: BoxFit.fill,),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Text(
                                  "Scheduled",
                                  textAlign: TextAlign.start,
                                  style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.Violet,),
                                ),
                             SizedBox(width: 25,),
                                Text(
                                  "SOC Completed",
                                  textAlign: TextAlign.start,
                                  style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                    fontWeight: FontWeight.w500,
                                    color: ColorManager.greenDark,),
                                ),
                                ///dont delete these r conditional text
                                // Text(
                                //   "SMissed on 13/05/2022",
                                //   textAlign: TextAlign.start,
                                //   style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                //     fontWeight: FontWeight.w500,
                                //     color: ColorManager.tangerine,),
                                // ),
                                // Text(
                                //   "Rescheduled on 15/08/2022",
                                //   textAlign: TextAlign.start,
                                //   style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                //     fontWeight: FontWeight.w500,
                                //     color: ColorManager.mediumgrey,),
                                // ),
                                // Text(
                                //   "SOC Pending",
                                //   textAlign: TextAlign.start,
                                //   style: CustomTextStylesCommon.commonStyle( fontSize: FontSize.s12,
                                //     fontWeight: FontWeight.w500,
                                //     color: ColorManager.EMbrightred,),
                                // ),

                              ],
                            ),
                          ),
                        ],),
                      ),
                      SizedBox(height: AppSize.s5),
                    ],
                  );
                },
              )),
        ],
      ),
    );
  }
}
