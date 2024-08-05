import 'package:flutter/material.dart';


class ReferringDiagnososScreen extends StatefulWidget {
  const ReferringDiagnososScreen({super.key});

  @override
  State<ReferringDiagnososScreen> createState() => _ReferringDiagnososScreenState();
}

class _ReferringDiagnososScreenState extends State<ReferringDiagnososScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(

        )
      ],
    );
  }
}




// Container(
// height: 30,
// decoration: BoxDecoration(
// color: ColorManager.fmediumgrey,
// borderRadius: BorderRadius.circular(12),
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceAround,
// children: [
// Expanded(
// flex: 2,
// child: Padding(
// padding: const EdgeInsets.only(left: 80.0),
// child: Text(
// AppStringEM.srno,
// style: AllHRTableHeading.customTextStyle(context),
// ),
// ),
// ),
// Expanded(
// flex: 2,
// child: Padding(
// padding: const EdgeInsets.only(left: 5.0),
// child: Text(
// AppStringEM.type,
// style: AllHRTableHeading.customTextStyle(context),
// ),
// ),
// ),
// Expanded(
// flex: 3,
// child: Text(
// AppStringEM.name,
// style: AllHRTableHeading.customTextStyle(context),
// ),
// ),
// Expanded(
// flex: 3,
// child: Padding(
// padding: const EdgeInsets.only(left: 25.0),
// child: Text(
// AppStringEM.location,
// style: AllHRTableHeading.customTextStyle(context),
// ),
// ),
// ),
// Expanded(
// flex: 3,
// child: Padding(
// padding: const EdgeInsets.only(left: 50.0),
// child: Text(
// AppStringEM.specialization,
// style: AllHRTableHeading.customTextStyle(context),
// ),
// ),
// ),
// Expanded(
// flex: 2,
// child: Padding(
// padding: const EdgeInsets.only(left: 50.0),
// child: Text(
// AppStringEM.edit,
// style: AllHRTableHeading.customTextStyle(context),
// ),
// ),
// ),
// ],
// ),
// ),