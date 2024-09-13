import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileBarEditor extends StatefulWidget {
  const ProfileBarEditor({super.key});

  @override
  State<ProfileBarEditor> createState() => _ProfileBarEditorState();
}

class _ProfileBarEditorState extends State<ProfileBarEditor> {
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        height: 500,
        width: 500,
        color: Colors.green,
      ),
    );
  }
}
