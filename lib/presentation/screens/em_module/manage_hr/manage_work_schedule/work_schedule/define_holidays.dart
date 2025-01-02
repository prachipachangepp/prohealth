import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/work_schedule_manager.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../data/api_data/establishment_data/work_schedule/work_week_data.dart';
import '../../../../../widgets/error_popups/delete_success_popup.dart';
import '../../../../../widgets/widgets/profile_bar/widget/pagination_widget.dart';
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
  @override
  void initState() {
    super.initState();
    holidaysListGet(context).then((data) {
      _controller.add(data);
    }).catchError((error) {
      // Handle error
    });
    // companyAllApi(context);
  }
  String convertDayMonthYearToIso(String dayMonthYear) {
    List<String> parts = dayMonthYear.split(' ');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);
    DateTime dateTime = DateTime(day, month, year);
    DateFormat isoFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    String formattedDate = isoFormat.format(dateTime);

    return formattedDate;
  }
  bool _isLoading = false;

  int currentPage = 1;
  final int itemsPerPage = 10;
  final int totalPages = 5;

  void onPageNumberPressed(int pageNumber) {
    setState(() {
      currentPage = pageNumber;
    });
  }
  int flexVal = 2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width/30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            // top: 20,
            child: CustomIconButton(
                // width: 170,
                icon: Icons.add,
                text: AddPopupString.addNewHoliday,
                onPressed: () async {
                  holidayNameController.clear();
                  calenderController.clear();
              showDialog(context: context, builder: (BuildContext context){
                return AddHolidayPopup( );
              });
            }
            ),
          ),
          SizedBox(
            height: AppSize.s20,
          ),
          Container(
            height: AppSize.s30,
            decoration: BoxDecoration(
              color: ColorManager.fmediumgrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Text(''),
                  Expanded(
                    flex: flexVal,
                    child: Center(
                      child: Text(
                          AppStringEM.srno,
                        style: TableHeading.customTextStyle(context)
                      ),
                    ),
                  ),
               Expanded(
                   flex: 1,
                   child: SizedBox()),
                  Expanded(
                    flex: flexVal,
                    child: Text(AppStringEM.holidayName,
                        textAlign: TextAlign.start,
                        style: TableHeading.customTextStyle(context)),
                  ),
                  Expanded(
                    flex: flexVal,
                    child: Center(
                      child: Text(
                          AppStringEM.date,
                        style:TableHeading.customTextStyle(context)
                      ),
                    ),
                  ),

                  Expanded(
                    flex: flexVal,
                    child: Center(
                      child: Text(AppStringEM.actions,
                          textAlign: TextAlign.start,
                          style: TableHeading.customTextStyle(context)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          Expanded(
            child: StreamBuilder<List<DefineHolidayData>>(

              stream: _controller.stream,
              builder: (context, snapshot) {
                holidaysListGet(context).then((data) {
                  _controller.add(data);
                }).catchError((error) {
                  // Handle error
                });
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
                    ErrorMessageString.noHoliday,
                      style: AllNoDataAvailable.customTextStyle(context),
                    ),
                  );
                }
                if (snapshot.hasData) {
                  int totalItems = snapshot.data!.length;
                  int totalPages = (totalItems / itemsPerPage).ceil();
                  List<DefineHolidayData> paginatedData = snapshot.data!.skip((currentPage - 1) * itemsPerPage).take(itemsPerPage).toList();

                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                        scrollDirection: Axis.vertical,
                            itemCount: paginatedData.length,
                            itemBuilder: (context, index) {
                              // Ensure the serial number starts from 1, with newly added items at the top
                              int serialNumber = index + 1;

                              String formattedSerialNumber = serialNumber.toString().padLeft(2, '0');
                              DefineHolidayData defineData = paginatedData[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(AppSize.s8),
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
                                        height: AppSize.s50,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: AppPadding.p15),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                flex: flexVal,
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: AppPadding.p10),
                                                    child: Text(
                                                      formattedSerialNumber,
                                                      style: DocumentTypeDataStyle.customTextStyle(context)
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  flex: 1,
                                                  child: SizedBox()),
                                              Expanded(
                                                flex: flexVal,
                                                child: Text(
                                                  defineData.holidayName,
                                                  textAlign: TextAlign.start,
                                                  style:TableSubHeading.customTextStyle(context),
                                                ),
                                              ),
                                              Expanded(
                                                flex: flexVal,
                                                child: Center(
                                                  child: Text(
                                                    defineData.date.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TableSubHeading.customTextStyle(context),
                                                  ),
                                                ),
                                              ),
                                              //  Text(''),
                                              ///edit
                                              Expanded(
                                                flex: flexVal,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                  context) {
                                                                return FutureBuilder<DefinePrefillHolidayData>(
                                                                  future: holidaysPrefillGet(context, defineData.holidayId),
                                                                  builder: (context, snapshotPrefill) {
                                                                    if(snapshotPrefill.connectionState == ConnectionState.waiting){
                                                                      return Center(child:CircularProgressIndicator(color: ColorManager.blueprime,));
                                                                    }
                                                                    holidayNameController = TextEditingController(text:  snapshotPrefill.data?.holidayName.toString());
                                                                    calenderController = TextEditingController(text: snapshotPrefill.data?.date);
                                                                    return EditHolidayPopup(
                                                                      holidayId: defineData.holidayId,
                                                                      controller: holidayNameController,
                                                                      calenderDateController: calenderController,
                                                                    );
                                                                  }
                                                                );
                                                              });
                                                        },
                                                        icon: Icon(
                                                          Icons.edit_outlined,
                                                          size: IconSize.I18,
                                                          color: IconColorManager.bluebottom,
                                                        )),
                                                    IconButton(
                                                        splashColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                       StatefulBuilder(
                                                                         builder: (BuildContext context, void Function(void Function()) setState) {
                                                                           return DeletePopup(
                                                                               title: DeletePopupString.deleteholiday,
                                                                               loadingDuration: _isLoading,
                                                                               onCancel: () {
                                                                                 Navigator.pop(context);
                                                                               },
                                                                               onDelete: () async {
                                                                             setState(() {
                                                                               _isLoading = true;
                                                                             });
                                                                             try {
                                                                               await deleteHolidays(context, defineData.holidayId);
                                                                               Navigator.pop(context);
                                                                               showDialog(context: context, builder: (context) => DeleteSuccessPopup());
                                                                             } finally {
                                                                               setState(() {
                                                                                 _isLoading = false;
                                                                               });
                                                                             }
                                                                           });
                                                                         },
                                                                       ),
                                                                  );
                                                        },
                                                        icon: Icon(
                                                          Icons.delete_outline,
                                                          size: IconSize.I18,
                                                          color: IconColorManager.red,
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
                            }),
                      ),
                      // Pagination Controls
                      PaginationControlsWidget(
                        currentPage: currentPage,
                        items: snapshot.data!,
                        itemsPerPage: itemsPerPage,
                        onPreviousPagePressed: () {
                          setState(() {
                            currentPage = currentPage > 1 ? currentPage - 1 : 1;
                          });
                        },
                        onPageNumberPressed: (pageNumber) {
                          setState(() {
                            currentPage = pageNumber;
                          });
                        },
                        onNextPagePressed: () {
                          setState(() {
                            currentPage = currentPage < totalPages ? currentPage + 1 : totalPages;
                          });
                        },
                      ),
                    ],
                  );
                }
                return Offstage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
////