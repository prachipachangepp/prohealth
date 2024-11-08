// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:prohealth/app/resources/color.dart';
// import 'package:prohealth/app/resources/font_manager.dart';
// import 'package:prohealth/app/resources/hr_resources/string_manager.dart';
// import 'package:prohealth/app/resources/value_manager.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
// import 'package:prohealth/presentation/screens/hr_module/manage/widgets/icon_button_constant.dart';
//
// class HealthRecordsHeadTabbar extends StatefulWidget {
//   const HealthRecordsHeadTabbar({super.key});
//
//   @override
//   State<HealthRecordsHeadTabbar> createState() => _HealthRecordsHeadTabbarState();
// }
//
// class _HealthRecordsHeadTabbarState extends State<HealthRecordsHeadTabbar> {
//   TextEditingController calenderController = TextEditingController();
//   final DateTime _selectedDate = DateTime.now();
//   bool isSelect = false;
//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context).size;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: CustomIconButton(text: AppStringHr.edit, onPressed: () async{
//           setState(() {
//             isSelect = !isSelect;
//           });
//           },icon: Icons.edit_outlined,),
//         ),
//       isSelect == true?  Container(
//         height: mediaQuery.height / 3,
//         //color: Colors.green,
//         child: Expanded(
//           child: Padding(
//
//             padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 10),
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Go Back',style: GoogleFonts.firaSans(
//                       fontSize: FontSize.s15,
//                       fontWeight: FontWeight.w500,
//                       color: ColorManager.black,
//                       //decoration: TextDecoration.none,
//                     ),),
//                    Expanded(
//                      child: ListView.builder(
//                        itemCount: 2,
//                          itemBuilder: (BuildContext context,index){
//                          return Padding(
//                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 0),
//                            child: Material(
//                              elevation: 4,
//                              borderRadius: BorderRadius.circular(10),
//                              child: Container(
//                                height: MediaQuery.of(context).size.height/4,
//                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: ColorManager.faintGrey,)),
//                                child: Padding(
//                                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
//                                  child: Column(
//                                    crossAxisAlignment: CrossAxisAlignment.start,
//                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                    children: [
//                                      Text('Physical Exam',style:GoogleFonts.firaSans(
//                                        fontSize: FontSize.s15,
//                                        fontWeight: FontWeight.w700,
//                                        color: ColorManager.black,
//                                        //decoration: TextDecoration.none,
//                                      )),
//                                      Text('Valid within 1 year of test',style:GoogleFonts.firaSans(
//                                        fontSize: FontSize.s15,
//                                        fontWeight: FontWeight.w400,
//                                        color: ColorManager.black,
//                                        //decoration: TextDecoration.none,
//                                      )),
//                                      Row(
//
//                                        children: [
//                                          Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//                                              Text(
//                                                'Date Administrated',
//                                                style: GoogleFonts.firaSans(
//                                                  fontSize: FontSize.s15,
//                                                  fontWeight: FontWeight.w600,
//                                                  color: ColorManager.mediumgrey,
//                                                  decoration: TextDecoration.none,
//                                                ),
//                                              ),
//                                              FormField<String>(
//                                                builder: (FormFieldState<String> field) {
//                                                  return SizedBox(
//                                                    width: 200,
//                                                    height: 30,
//                                                    child: TextFormField(
//                                                      style: GoogleFonts.firaSans(
//                                                        fontSize: FontSize.s14,
//                                                        fontWeight: FontWeight.w600,
//                                                        color: ColorManager.mediumgrey,
//                                                        //decoration: TextDecoration.none,
//                                                      ),
//                                                      controller: calenderController,
//                                                      decoration: InputDecoration(
//                                                        hintText: 'dd/mm/yyyy',
//                                                        hintStyle: GoogleFonts.firaSans(
//                                                          fontSize: FontSize.s14,
//                                                          fontWeight: FontWeight.w600,
//                                                          color: ColorManager.mediumgrey,
//                                                          //decoration: TextDecoration.none,
//                                                        ),
//                                                        border: OutlineInputBorder(
//                                                          borderRadius: BorderRadius.circular(8),
//                                                          borderSide: BorderSide(width: 1),
//                                                        ),
//                                                        contentPadding:
//                                                        EdgeInsets.symmetric(horizontal: 16),
//                                                        suffixIcon: Icon(
//                                                          Icons.calendar_month_outlined,
//                                                          color: ColorManager.blueprime,
//                                                        ),
//                                                        errorText: field.errorText,
//                                                      ),
//                                                      readOnly: true,
//                                                      onTap: () async {
//                                                        DateTime? date = await showDatePicker(
//                                                          context: context,
//                                                          initialDate: _selectedDate,
//                                                          firstDate: DateTime(1100),
//                                                          lastDate: DateTime.now(),
//                                                        );
//                                                        if (date != null) {
//                                                          calenderController.text =DateFormat('dd/mm/yyyy').format(_selectedDate);
//                                                          field.didChange(
//                                                              date.toLocal().toString().split(' ')[0]);
//                                                        }
//                                                      },
//                                                      validator: (value) {
//                                                        if (value == null || value.isEmpty) {
//                                                          return 'please select birth date';
//                                                        }
//                                                        return null;
//                                                      },
//                                                    ),
//                                                  );
//                                                },
//                                              ),
//                                            ],
//                                          ),
//                                          Spacer(),
//                                          Text('Upload Immunization records in PDF format',style:GoogleFonts.firaSans(
//                                            fontSize: FontSize.s14,
//                                            fontWeight: FontWeight.w500,
//                                            color: ColorManager.black,
//                                            //decoration: TextDecoration.none,
//                                          )),
//                                          SizedBox(width: 10,),
//                                          Container(
//                                            width: MediaQuery.of(context).size.width/5,
//                                            height: 50,
//                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: ColorManager.faintGrey)),
//                                            child: Row(
//                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                              children: [
//                                                Container(
//                                                  width: 150,
//                                                  height: 30,
//                                                  color: Color(0xFFF5F5F5),
//                                                  child: Center(child: Text('Choose File',style: GoogleFonts.firaSans(
//                                                    fontSize: FontSize.s15,
//                                                    fontWeight: FontWeight.w600,
//                                                    color: ColorManager.black,
//                                                    //decoration: TextDecoration.none,
//                                                  ),)),
//                                                ),
//                                                Text('No file chosen',style: GoogleFonts.firaSans(
//                                                  fontSize: FontSize.s15,
//                                                  fontWeight: FontWeight.w300,
//                                                  color: ColorManager.faintGrey,
//                                                  //decoration: TextDecoration.none,
//                                                ),)
//                                              ],
//                                            ),
//                                          )
//                                        ],
//                                      )
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            ),
//                          );
//                      }),
//                    )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//       ):Container(
//           height: mediaQuery.height / 3,
//           child: ListView.builder(
//               itemCount: 4,
//               itemBuilder: (BuildContext context, index) {
//                 return Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: MediaQuery.of(context).size.width / 80,
//                       vertical: MediaQuery.of(context).size.height / 100),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 10),
//                             child: Container(
//                               height: mediaQuery.height / 9,
//                               width: mediaQuery.width / 2.6,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                       color: ColorManager.faintGrey)),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 60,
//                                       width: 60,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10),
//                                           border: Border.all(
//                                               color: ColorManager.faintGrey)),
//                                       child: Image.asset('images/file-document-green.png')
//                                     ),
//                                     SizedBox(width: 10,),
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text('Physical Exam',style: TextStyle(
//                                           fontSize: 12,
//                                           fontWeight: FontWeightManager.semiBold
//                                         ),),
//                                         SizedBox(height: 10,),
//                                         Text('2023-08-17',style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeightManager.lightbold
//                                         ),),
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     IconButtonWidget(iconData1: Icons.print_outlined, buttonText: 'Print', onPressed:(){},),
//                                     SizedBox(width: 5,),
//                                     IconButtonWidget(iconData1: Icons.file_copy_rounded, buttonText: 'Download', onPressed:(){},),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 10, horizontal: 10),
//                             child: Container(
//                               height: mediaQuery.height / 9,
//                               width: mediaQuery.width / 2.6,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                       color: ColorManager.faintGrey)),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
//                                 child: Row(
//                                   children: [
//                                     Container(
//                                       height: 60,
//                                       width: 60,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(10),
//                                           border: Border.all(
//                                               color: ColorManager.faintGrey)),
//                                       child: Image.asset('images/file-document-black.png')
//                                     ),
//                                     SizedBox(width: 10,),
//                                     Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text('Chest X-ray',style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeightManager.semiBold
//                                         ),),
//                                         SizedBox(height: 10,),
//                                         Text('2023-08-17',style: TextStyle(
//                                             fontSize: 12,
//                                             fontWeight: FontWeightManager.lightbold
//                                         ),),
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     IconButtonWidget(iconData1: Icons.print_outlined, buttonText: 'Print', onPressed:(){},),
//                                     SizedBox(width: 5,),
//                                     IconButtonWidget(iconData1: Icons.file_copy_rounded, buttonText: 'Download', onPressed:(){},),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }),
//         ),
//       ],
//     );
//   }
// }
