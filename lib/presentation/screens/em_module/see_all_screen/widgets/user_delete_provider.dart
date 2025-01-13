import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


///DeleteUserPopupProvider
class DeleteUserPopupProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> deleteUser(BuildContext context, int userId) async {

    try {

      print('User with ID $userId deleted');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}


///DeleteUserPopup
class DeleteUserPopup extends StatelessWidget {
  final String title;
  final bool isLoading; // Add this parameter
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const DeleteUserPopup({
    required this.title,
    required this.isLoading, // Add this parameter
    required this.onCancel,
    required this.onConfirm,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: isLoading
          ? Center(child: CircularProgressIndicator())
          : Text("Are you sure you want to delete this user?"),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text("Delete"),
        ),
      ],
    );
  }
}




///UserCustomButtonTransparentSM
class UserCustomButtonTransparentSM extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const UserCustomButtonTransparentSM({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 4,
      child: Container(
        height: 25,
        width: 100,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 10),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}