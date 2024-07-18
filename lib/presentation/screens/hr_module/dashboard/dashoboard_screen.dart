import 'package:flutter/material.dart';
import 'package:prohealth/data/api_data/hr_module_data/employee_profile/search_profile_data.dart';
import '../../../../../app/resources/value_manager.dart';
import '../../../widgets/widgets/profile_bar/profile_bar.dart';

///prachi
class DashBoardScreen extends StatefulWidget {
  final SearchByEmployeeIdProfileData? searchByEmployeeIdProfileData;
   DashBoardScreen({Key? key, this.searchByEmployeeIdProfileData}) : super(key: key);


  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 99),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          /// green blue container
          ProfileBar(searchByEmployeeIdProfileData: widget.searchByEmployeeIdProfileData,),
          SizedBox(
            height: AppSize.s5,
          ),
        ]),
      ),
    );
  }
}
