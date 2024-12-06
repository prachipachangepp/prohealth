import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/services/api/managers/sm_module_manager/scheduler/scheduler_create_manager.dart';
import 'package:prohealth/data/api_data/sm_data/scheduler_create_data/schedular_data.dart';
import 'package:prohealth/presentation/screens/scheduler_model/sm_scheduler/widget/schedular_create/widget/calender_const.dart';

class SmCalenderScreen extends StatefulWidget {
   SmCalenderScreen({super.key});

  @override
  State<SmCalenderScreen> createState() => _SmCalenderScreenState();
}

class _SmCalenderScreenState extends State<SmCalenderScreen> {
  final StreamController<SchedularData> _schedulerController =
  StreamController<SchedularData>();

   final PageController _pageController = PageController();

   int selectedIndex = 0;

   void selectButton(int index) {
     setState(() {
       selectedIndex = index;
     });

     _pageController.animateToPage(
       index,
       duration: const Duration(milliseconds: 500),
       curve: Curves.ease,
     );
   }

   void goBack() {
     if (selectedIndex > 0) {
       setState(() {
         selectedIndex--;
       });
       _pageController.animateToPage(
         selectedIndex,
         duration: const Duration(milliseconds: 500),
         curve: Curves.ease,
       );
     }
   }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<SchedularData>(
          stream: _schedulerController.stream,
          builder: (context,snapshot) {
            getSchedularByClinitian(context: context, clinicialId: 134).then((data) {
              _schedulerController.add(data);
            }).catchError((error) {
// Handle error
            });
            if(snapshot.connectionState == ConnectionState.waiting){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: Center(child: CircularProgressIndicator(color: ColorManager.blueprime,),),
              );
            }
            if(snapshot.data!.isBlank!){
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 150),
                child: Center(child: Text('No record found!'),),
              );
            }
            if(snapshot.hasData){
              return Container(
                    height: MediaQuery.of(context).size.height / 1,
                    child: CalenderConstant(schedularData: snapshot.data!, onBack: goBack,));

            }
            else{
              return const SizedBox();
            }

          }
      ),
    );
  }
}
