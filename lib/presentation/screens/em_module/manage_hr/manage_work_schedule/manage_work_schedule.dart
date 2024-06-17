import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/services/api/managers/establishment_manager/work_schedule_manager.dart';
import 'package:prohealth/data/api_data/establishment_data/work_schedule/work_week_data.dart';
import 'package:prohealth/presentation/widgets/widgets/custom_icon_button_constant.dart';

import 'work_schedule/define_holidays.dart';
import 'work_schedule/define_work_weeks.dart';
import 'work_schedule/widgets/add_holiday_popup_const.dart';

class ManageWorkSchedule extends StatefulWidget {
  const ManageWorkSchedule({super.key});

  @override
  State<ManageWorkSchedule> createState() => _ManageWorkScheduleState();
}

class _ManageWorkScheduleState extends State<ManageWorkSchedule> {
  final PageController _managePageController = PageController();
  int _selectedIndex = 0;


  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _managePageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  @override
  Widget build(BuildContext context) {
    return WorkSchedule(
      managePageController: _managePageController,
      selectedIndex: _selectedIndex,
      selectButton: _selectButton,
    );
  }
}


class WorkSchedule extends StatefulWidget {
  final PageController managePageController;
  final int selectedIndex;
  final Function(int) selectButton;

  WorkSchedule({
    Key? key,
    required this.managePageController,
    required this.selectedIndex,
    required this.selectButton,
  }) : super(key: key);

  @override
  State<WorkSchedule> createState() => _WorkScheduleState();
}

class _WorkScheduleState extends State<WorkSchedule> {
  final List<String> _categories = [
    'Define Work Weeks',
    'Define Holidays',
  ];

  final PageController _managePageController = PageController();
  TextEditingController calenderController = TextEditingController();

  int _selectedIndex = 0;

  void _selectButton(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _managePageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
  @override
  void initState() {
    super.initState();
    // companyAllApi(context);
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController holidayNameController = TextEditingController();
    return Material(
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15,top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: 28,
                    width: MediaQuery.of(context).size.width / 4.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorManager.blueprime,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: _categories
                          .asMap()
                          .entries
                          .map(
                            (entry) => InkWell(
                          child: Container(
                            height: 30,
                            width: MediaQuery.of(context).size.width / 8.42,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: widget.selectedIndex == entry.key
                                  ? Colors.white
                                  : null,
                            ),
                            child: Text(
                              entry.value,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(textStyle:TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeightManager.semiBold,
                                color: widget.selectedIndex == entry.key
                                    ? ColorManager.mediumgrey
                                    : Colors.white,
                              ),)
                            ),
                          ),
                          onTap: () => widget.selectButton(entry.key),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
            flex: 10,
            child: Stack(
              children: [
            widget.selectedIndex == 1 ? Offstage():Container(height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(color: Color(0xFFF2F9FC),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                      boxShadow: [ BoxShadow(
                        color: ColorManager.faintGrey,
                        blurRadius: 2,
                        spreadRadius: -2,
                        offset: Offset(0, -4),
                      ),]
                  ),),
                widget.selectedIndex == 0 ? Offstage():   Positioned(
                  right: 40,
                  // top: 20,
                  child: CustomIconButtonConst(
                      icon: Icons.add,
                      text: "Add New Holiday", onPressed: (){
                    showDialog(context: context, builder: (BuildContext context){
                      return AddHolidayPopup(controller: holidayNameController, onPressed: () async{
                        await addHolidaysPost(context, holidayNameController.text, calenderController.text, 2024, 11);
                        holidaysListGet(context);
                      }, calenderDateController: calenderController,);
                    });
                  }),
                ),
                Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 45,right: MediaQuery.of(context).size.width / 45,
                    top: MediaQuery.of(context).size.width / 45 ),
                child: PageView(
                    controller: widget.managePageController,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      DefineWorkWeek(),
                      DefineHolidays(),
                    ]),
              ),]
            ),
          ),
        ],
      ),
    );
  }
}
