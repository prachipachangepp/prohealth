import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/theme_manager.dart';
import 'package:prohealth/app/resources/value_manager.dart';

class CardDetails extends StatefulWidget {
  final Widget childWidget;
  const CardDetails({super.key, required this.childWidget});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.26,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        // height: MediaQuery.of(context).size.height/3.6,
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 95,
              vertical: MediaQuery.of(context).size.height / 160,
            ),
            child: widget.childWidget),
      ),
    );
  }
}

class DetailsFormate extends StatefulWidget {
  final List<Widget> row1Child1;
  final List<Widget> row1Child2;
  final List<Widget> row2Child1;
  final List<Widget> row2Child2;
  String? title;
  final Widget button;
  final Widget? titleRow;
  DetailsFormate(
      {super.key,
      this.titleRow,
      this.title,
      required this.row1Child1,
      required this.row1Child2,
      required this.row2Child1,
      required this.row2Child2,
      required this.button});

  @override
  State<DetailsFormate> createState() => _DetailsFormateState();
}

class _DetailsFormateState extends State<DetailsFormate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.titleRow == null
            ? Text(widget.title!,
                // 'Employment #${snapshot.data![index].employmentId}',
                style: BoxHeadingStyle.customTextStyle(context))
            : widget.titleRow!,
        SizedBox(
          height: AppSize.s10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.row1Child1),
                SizedBox(
                  width: 5,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.row1Child2),
              ],
            ),
            //  SizedBox(width: MediaQuery.of(context).size.width/30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.row2Child1),
                SizedBox(
                  width: 5,
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: widget.row2Child2),
              ],
            ),
          ],
        ),
        SizedBox(
          height: AppSize.s10,
        ),
        widget.button
      ],
    );
  }
}
