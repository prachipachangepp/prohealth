import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/establishment_resources/establish_theme_manager.dart';
import 'package:prohealth/app/resources/establishment_resources/establishment_string_manager.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/work_schedule_manager.dart';
import 'package:prohealth/app/services/api/repository/establishment_manager/establishment_repository.dart';
import 'package:prohealth/presentation/screens/em_module/company_identity/widgets/whitelabelling/success_popup.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/screens/hr_module/manage/widgets/custom_icon_button_constant.dart';
import 'package:prohealth/presentation/widgets/error_popups/failed_popup.dart';
import 'package:prohealth/presentation/widgets/error_popups/four_not_four_popup.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';
import '../../../../../../app/resources/common_resources/common_theme_const.dart';
import '../../../../../../app/resources/const_string.dart';
import '../../../../../../app/resources/theme_manager.dart';
import '../../../../../../data/api_data/establishment_data/work_schedule/work_week_data.dart';
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
                return AddHolidayPopup(
                  buttonWidth:  AppSize.s110,
                  btnTitle: "Add holiday",
                  title: AddPopupString.addNewHoliday,
                  controller: holidayNameController,
                  onPressed: () async{
                  var response = await addHolidaysPost(context,
                      holidayNameController.text, calenderController.text, 2024,);

                  if(response.statusCode == 200 || response.statusCode == 201){
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddSuccessPopup(
                          message: 'Holiday Added Successfully',
                        );
                      },
                    );
                  }
                 else if(response.statusCode == 400 || response.statusCode == 404){
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => const FourNotFourPopup(),
                    );
                  }
                  else {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => FailedPopup(text: response.message),
                    );
                  }
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
              color: ColorManager.fmediumgrey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                                flex: flexVal,
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 10.0),
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
                                                                    var holidayName = snapshotPrefill.data?.holidayName.toString();
                                                                    var date = snapshotPrefill.data?.date;
                                                                    holidayNameController = TextEditingController(text:  snapshotPrefill.data?.holidayName.toString());
                                                                    calenderController = TextEditingController(text: snapshotPrefill.data?.date);
                                                                    return AddHolidayPopup(
                                                                      buttonWidth:  AppSize.s70,
                                                                      btnTitle: "Save Changes",
                                                                      title: EditPopupString.editholiday,
                                                                      controller:
                                                                          holidayNameController,
                                                                      calenderDateController:
                                                                      calenderController,
                                                                      onPressed: ()  async{
                                                                        var response = await updateHolidays(context, defineData.holidayId,
                                                                            holidayName == holidayNameController.text ? holidayName.toString() : holidayNameController.text,
                                                                            date == calenderController.text ? date! : calenderController.text, 2024,);
                                                                        if(response.statusCode == 200 || response.statusCode == 201){
                                                                          Navigator.pop(context);
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context) {
                                                                              return AddSuccessPopup(
                                                                                message: 'Holiday Edited Successfully',
                                                                              );
                                                                            },
                                                                          );
                                                                        }else if(response.statusCode == 400 || response.statusCode == 404){
                                                                          Navigator.pop(context);
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context) => const FourNotFourPopup(),
                                                                          );
                                                                        }
                                                                        else {
                                                                          Navigator.pop(context);
                                                                          showDialog(
                                                                            context: context,
                                                                            builder: (BuildContext context) => FailedPopup(text: response.message),
                                                                          );
                                                                        }
                                                                        holidaysListGet(
                                                                            context)
                                                                            .then((data) {
                                                                          _controller
                                                                              .add(data);
                                                                        }).catchError(
                                                                                (error) {
                                                                              // Handle error
                                                                            });
                                                                        holidayNameController.clear();
                                                                        calenderController.clear();
                                                                      },

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
                                                                               }, onDelete:
                                                                               () async {
                                                                             setState(() {
                                                                               _isLoading = true;
                                                                             });
                                                                             try {
                                                                               await deleteHolidays(
                                                                                   context,
                                                                                   defineData.holidayId);
                                                                               holidaysListGet(
                                                                                   context)
                                                                                   .then((data) {
                                                                                 _controller
                                                                                     .add(data);
                                                                               }).catchError(
                                                                                       (error) {
                                                                                     // Handle error
                                                                                   });

                                                                             } finally {
                                                                               setState(() {
                                                                                 _isLoading = false;
                                                                               });
                                                                               Navigator.pop(context);
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