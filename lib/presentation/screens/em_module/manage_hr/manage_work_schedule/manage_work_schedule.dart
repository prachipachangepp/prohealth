import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/font_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';
import 'work_schedule/define_holidays.dart';
import 'work_schedule/define_work_weeks.dart';


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
            padding: const EdgeInsets.only(left: 15,top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    height: AppSize.s30,
                    width: MediaQuery.of(context).size.width / 4.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
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
                            width: MediaQuery.of(context).size.width / 8.40,
                            padding: EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: widget.selectedIndex == entry.key
                                  ? Colors.white
                                  : null,
                            ),
                            child: Text(
                              entry.value,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.firaSans(
                                fontSize: AppSize.s12,
                                fontWeight: FontWeightManager.semiBold,
                                color: widget.selectedIndex == entry.key
                                    ? ColorManager.mediumgrey
                                    : Colors.white,
                              )
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
                Padding(
                padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 45,right: MediaQuery.of(context).size.width / 45,
                ),
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
