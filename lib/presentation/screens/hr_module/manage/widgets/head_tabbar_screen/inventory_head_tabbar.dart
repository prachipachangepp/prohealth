import 'package:flutter/material.dart';

class InventoryHeadTabbar extends StatelessWidget {
  const InventoryHeadTabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigoAccent,
      child: Center(child: Text('Inventory'),),
    );
  }
}

// Column(
// children: [
// Container(
// height: 30,
// margin: EdgeInsets.symmetric(horizontal: 35),
// decoration: BoxDecoration(
// color: Colors.grey,
// borderRadius: BorderRadius.circular(12),
// ),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Center(
// child: Text(
// 'Sr No.',
// style: RegisterTableHead.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'ID of the Inventory',
// style: RegisterTableHead.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Name of the Document',
// style: RegisterTableHead.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Device Description',
// style: RegisterTableHead.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Assign Date',
// style: RegisterTableHead.customTextStyle(context),
// )),
// ],
// ),
// ),
// SizedBox(
// height: 10,
// ),
// Expanded(
// child: ListView.builder(
// scrollDirection: Axis.vertical,
// itemCount: 10,
// itemBuilder: (context, index) {
// return Column(
// children: [
// SizedBox(height: 5),
// Container(
// padding: EdgeInsets.only(bottom: 5),
// margin: EdgeInsets.symmetric(horizontal: 50),
// decoration: BoxDecoration(
// color:Colors.white,
// borderRadius: BorderRadius.circular(4),
// boxShadow: [
// BoxShadow(
// color: Colors.grey.withOpacity(0.5),
// spreadRadius: 1,
// blurRadius: 4,
// offset: Offset(0, 2),
// ),
// ],
// ),
// height: 56,
//
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Center(
// child: Text(
// '01',style: ThemeManagerDark.customTextStyle(context),
// textAlign: TextAlign.start,
// )),
// Center(
// child: Text(
// '8374682',
// textAlign: TextAlign.start,
// style: ThemeManagerDark.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Lorem Ipsum is simply dummy text of the printing',
// style: ThemeManagerDark.customTextStyle(context),
// )),
// Center(
// child: Text(
// 'Cellular',
// style: ThemeManagerDark.customTextStyle(context),
// )),
// Center(
// child: Text(
// '22-03-23',
// style: ThemeManagerDark.customTextStyle(context),
// )),
// ],
// ),
// ),
// ],
// );
// },
// ),
// ),
// ],
// );