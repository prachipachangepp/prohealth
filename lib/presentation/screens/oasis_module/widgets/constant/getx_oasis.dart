import 'package:get/get.dart';


// TermsController to manage checkbox state globally
class CheckboxController extends GetxController {
  // Define a reactive RxBool for checkbox state
  var isChecked = false.obs;

  // Function to toggle the checkbox state
  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }
}


class ButtonSelectionControlleroasis extends GetxController {
  // Reactive variables
  var selectedIndex = 0.obs;
  var selectedText = "Consent For Care".obs;

  // Method to update the selected index and text
  void selectButton(int index, String text) {
    selectedIndex.value = index;
    selectedText.value = text;
  }
}