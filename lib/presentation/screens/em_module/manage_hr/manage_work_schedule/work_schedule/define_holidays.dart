import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/work_schedule_manager.dart';
import 'package:prohealth/app/services/api_sm/company_identity/add_doc_company_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/widgets/profile_bar/widget/pagination_widget.dart';

import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../data/api_data/establishment_data/work_schedule/work_week_data.dart';
import 'widgets/add_holiday_popup_const.dart';

class DefineHolidays extends StatefulWidget {
  const DefineHolidays({super.key});

  @override
  State<DefineHolidays> createState() => _DefineHolidaysState();
}

class _DefineHolidaysState extends State<DefineHolidays> {
  TextEditingController holidayNameController = TextEditingController();
  final StreamController<List<DefineHolidayData>> _controller =
      StreamController<List<DefineHolidayData>>();
  TextEditingController calenderController = TextEditingController();

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
    holidaysListGet(context).then((data) {
      _controller.add(data);
    }).catchError((error) {
      // Handle error
    });
    // companyAllApi(context);
  }
  String convertDayMonthYearToIso(String dayMonthYear) {
    // Split the dayMonthYear string into day, month, and year parts
    List<String> parts = dayMonthYear.split(' ');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    // Create a DateTime object from the parsed parts
    DateTime dateTime = DateTime(day, month, year);

    // Create a DateFormat object to format the date to ISO 8601 format
    DateFormat isoFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');

    // Format the date into ISO 8601 format
    String formattedDate = isoFormat.format(dateTime);

    return formattedDate;
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Positioned(
            right: 40,
            // top: 20,
            child: CustomIconButtonConst(
                icon: Icons.add,
                text: "Add New Holiday", onPressed: (){
              showDialog(context: context, builder: (BuildContext context){
                return AddHolidayPopup(controller: holidayNameController, onPressed: () async{
                  await addHolidaysPost(context, holidayNameController.text, calenderController.text, 2024, 11);
                  holidaysListGet(context).then((data) {
                    _controller.add(data);
                  }).catchError((error) {
                    // Handle error
                  });
                }, calenderDateController: calenderController,);
              });
            }),
          ),
          SizedBox(
            height: 20,
          ),
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
                  Expanded(
                    child: Center(
                      child: Text(
                        'Sr No.',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),
//SizedBox(width: MediaQuery.of(context).size.width/7.5,),
                  Expanded(
                    child: Center(
                      child: Text('Holiday Name',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Date',
                        style: GoogleFonts.firaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: Text('Actions',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.firaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            decoration: TextDecoration.none,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: StreamBuilder<List<DefineHolidayData>>(
              stream: _controller.stream,
              builder: (context, snapshot) {
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
                      AppString.dataNotFound,
                      style: CustomTextStylesCommon.commonStyle(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSize.s12,
                        color: ColorManager.mediumgrey,
                      ),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        int serialNumber =
                            index + 1 + (currentPage - 1) * itemsPerPage;
                        String formattedSerialNumber =
                        serialNumber.toString().padLeft(2, '0');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            Color(0xff000000).withOpacity(0.25),
                                        spreadRadius: 0,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  height: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              formattedSerialNumber,
                                              // formattedSerialNumber,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Text(''),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              snapshot.data![index].holidayName,
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: Text(
                                              snapshot.data![index].date.toString(),
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.firaSans(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xff686464),
                                                decoration: TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        //  Text(''),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return FutureBuilder<DefinePrefillHolidayData>(
                                                            future: holidaysPrefillGet(context, snapshot.data![index].holidayId),
                                                            builder: (context, snapshotPrefill) {
                                                              var holidayName = snapshotPrefill.data?.holidayName.toString();
                                                              var date = snapshotPrefill.data?.date.toString();
                                                              holidayNameController = TextEditingController(text:  snapshotPrefill.data?.holidayName.toString());
                                                              calenderController = TextEditingController(text: snapshotPrefill.data?.date);
                                                              return AddHolidayPopup(
                                                                controller:
                                                                    holidayNameController,
                                                                calenderDateController:
                                                                calenderController,
                                                                onPressed: ()  async{
                                                                  await updateHolidays(context, snapshot.data![index].holidayId,
                                                                      holidayName == holidayNameController.text ? holidayName.toString() : holidayNameController.text,
                                                                      date == calenderController.text ? DateFormat('mm-dd-yyy').format(date as DateTime) : calenderController.text, 2024, 1);
                                                                  holidaysListGet(
                                                                      context)
                                                                      .then((data) {
                                                                    _controller
                                                                        .add(data);
                                                                  }).catchError(
                                                                          (error) {
                                                                        // Handle error
                                                                      });
                                                                  Navigator.pop(context);
                                                                },

                                                              );
                                                            }
                                                          );
                                                        });
                                                  },
                                                  icon: Icon(
                                                    Icons.edit_outlined,
                                                    size: 18,
                                                    color: ColorManager.blueprime,
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            DeletePopup(
                                                                onCancel: () {
                                                              Navigator.pop(
                                                                  context);
                                                            }, onDelete:
                                                                    () async {
                                                              await deleteHolidays(
                                                                  context,
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .holidayId!);
                                                              holidaysListGet(
                                                                      context)
                                                                  .then((data) {
                                                                _controller
                                                                    .add(data);
                                                              }).catchError(
                                                                      (error) {
                                                                // Handle error
                                                              });
                                                            }));
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_outline,
                                                    size: 18,
                                                    color: ColorManager.red,
                                                  )),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        );
                      });
                }
                return Offstage();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          PaginationControlsWidget(
            currentPage: currentPage,
            items: items,
            itemsPerPage: itemsPerPage,
            onPreviousPagePressed: () {
              /// Handle previous page button press
              setState(() {
                currentPage = currentPage > 1 ? currentPage - 1 : 1;
              });
            },
            onPageNumberPressed: (pageNumber) {
              /// Handle page number tap
              setState(() {
                currentPage = pageNumber;
              });
            },
            onNextPagePressed: () {
              /// Handle next page button press
              setState(() {
                currentPage = currentPage < (items.length / itemsPerPage).ceil()
                    ? currentPage + 1
                    : (items.length / itemsPerPage).ceil();
              });
            },
          ),
        ],
      ),
    );
  }
}
