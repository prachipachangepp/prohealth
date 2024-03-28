import 'package:flutter/material.dart';

///to do prachi
class HealthRecordTab extends StatelessWidget {
  const HealthRecordTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: 181,
          width: MediaQuery.of(context).size.width / 70,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
      ),
    );
  }
}
