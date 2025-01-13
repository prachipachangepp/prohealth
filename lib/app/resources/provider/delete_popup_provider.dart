import 'package:flutter/material.dart';

import '../../../presentation/screens/em_module/widgets/button_constant.dart';
import '../color.dart';
import '../common_resources/common_theme_const.dart';
import '../establishment_resources/establishment_string_manager.dart';
import '../value_manager.dart';

///provider
// class DeletePopupProvider extends StatelessWidget {
//   final VoidCallback onCancel;
//   final VoidCallback onDelete; // Accepts an async function for delete
//   final bool? loadingDuration; // Optional loading state
//   final String title;
//   final String? text;
//   final String? btnText;
//
//   const DeletePopupProvider({
//     Key? key,
//     required this.onCancel,
//     required this.onDelete,
//     this.loadingDuration, // Now optional, as per your original widget
//     required this.title,
//     this.text,
//     this.btnText,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(title),
//       content: loadingDuration == true
//           ? const Center(child: CircularProgressIndicator())
//           : Text(text ?? "Do you really want to delete this item?"),
//       actions: [
//         TextButton(
//           onPressed: loadingDuration == true ? null : onCancel,
//           child: Text(btnText ?? "Cancel"),
//         ),
//         TextButton(
//           onPressed: loadingDuration == true ? null : () async => onDelete(),
//           child: const Text("Delete"),
//         ),
//       ],
//     );
//   }
// }

class DeletePopupProvider extends StatelessWidget {
  final VoidCallback onCancel;
  final Future<void> Function() onDelete;
  final bool? loadingDuration;
  final String title;
  final String? text;
  final String? btnText;

  const DeletePopupProvider({
    Key? key,
    required this.onCancel,
    required this.onDelete,
    required this.loadingDuration,
    required this.title,
    this.text,
    this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: AppSize.s400,
        height: AppSize.s181,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            // Blue Top Bar with Title and Close Icon
            Container(
              decoration: BoxDecoration(
                color: ColorManager.bluebottom,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: AppPadding.p15),
                    child: Text(
                      title,
                      style: PopupBlueBarText.customTextStyle(context),
                    ),
                  ),
                  IconButton(
                    onPressed: onCancel,
                    icon: Icon(Icons.close, color: ColorManager.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            // Text Content
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p20,
                    horizontal: AppPadding.p15,
                  ),
                  child: Text(
                    text ?? 'Do you really want to delete?',
                    style: PopupTextConst.customTextStyle(context),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Action Buttons (Cancel and Delete)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p24),
                  child: SizedBox(
                    width: AppSize.s100,
                    child: ElevatedButton(
                      onPressed: loadingDuration == true ? null : onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(
                            color: ColorManager.bluebottom,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TransparentButtonTextConst.customTextStyle(context),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSize.s20),
                Padding(
                  padding:  EdgeInsets.only(
                    bottom: AppPadding.p24,
                    right: AppPadding.p15,
                  ),
                  child: loadingDuration == true
                      ?  SizedBox(
                    height: AppSize.s25,
                    width: AppSize.s25,
                    child: CircularProgressIndicator(
                      color: ColorManager.blueprime,
                    ),
                  )
                      : CustomElevatedButton(
                    width: AppSize.s105,
                    height: AppSize.s30,
                    text: btnText ?? AppStringEM.delete,
                    onPressed: () async {
                      await onDelete();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
