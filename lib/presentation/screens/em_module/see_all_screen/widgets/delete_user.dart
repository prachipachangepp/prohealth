import 'package:flutter/material.dart';
import 'package:prohealth/app/resources/color.dart';
import 'package:prohealth/app/resources/const_string.dart';
import 'package:prohealth/presentation/screens/em_module/manage_hr/manage_work_schedule/work_schedule/widgets/delete_popup_const.dart';
import 'package:prohealth/presentation/widgets/error_popups/delete_success_popup.dart';
import 'package:provider/provider.dart';
import '../../../../../app/resources/font_manager.dart';

class DeleteProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> deleteUser(BuildContext context, String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      // Call your delete user API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      // Handle success
      Navigator.pop(context); // Close the DeletePopup
      showDialog(
        context: context,
        builder: (context) => DeleteSuccessPopup(),
      );
    } catch (error) {
      // Handle error
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class DeleteUserButton extends StatelessWidget {
  final String userId;
  final String userEmail;
  final String currentUserEmail;

  const DeleteUserButton({
    Key? key,
    required this.userId,
    required this.userEmail,
    required this.currentUserEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deleteProvider = Provider.of<DeleteProvider>(context);

    return userEmail != currentUserEmail
        ? InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DeletePopup(
            title: "Delete User",
            loadingDuration: deleteProvider.isLoading,
            onCancel: () {
              Navigator.pop(context);
            },
            onDelete: () async {
              await deleteProvider.deleteUser(context, userId);
            },
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 30,
        width: MediaQuery.of(context).size.width / 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorManager.bluebottom),
        ),
        child: Center(
          child: Text(
            AppString.delete,
            style: TextStyle(
              fontSize: FontSize.s12,
              fontWeight: FontWeight.w500,
              color: ColorManager.mediumgrey,
            ),
          ),
        ),
      ),
    )
        : SizedBox.shrink();
  }
}