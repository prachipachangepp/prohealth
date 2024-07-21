import 'package:flutter/material.dart';

import '../../../../../app/resources/value_manager.dart';

///prachi
class DashBoardScreen extends StatefulWidget {
  DashBoardScreen({
    Key? key,
  }) : super(key: key);

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
          // ProfileBar(searchByEmployeeIdProfileData: widget.searchByEmployeeIdProfileData,),
          SizedBox(
            height: AppSize.s5,
          ),
        ]),
      ),
    );
  }
}
