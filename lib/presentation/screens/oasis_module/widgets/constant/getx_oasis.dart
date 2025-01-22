import 'package:get/get.dart';


// TermsController to manage checkbox state globally
class CheckboxController extends GetxController {
  // Define a reactive RxBool for checkbox state
  var isChecked = false.obs;
  var pt = false.obs;
  var ot = false.obs;
  var slp = false.obs;
  var msw = false.obs;
  var aide = false.obs;
  var other = false.obs;
  var am = false.obs;
  var not  = false.obs;
  var medicare  = false.obs;
  var medicaid = false.obs;
  var Other = false.obs;
  var will  = false.obs;
  var dnr= false.obs;
  var healthcare  = false.obs;
  var  directives = false.obs;
  var notice = false.obs;
  var oasis = false.obs;
  var patientright = false.obs;
  var patientinfo  = false.obs;
  var advdirectives = false.obs;
  var homesafety = false.obs;
  var OTHER = false.obs;
  // var  = false.obs;
  // var  = false.obs;
  // var  = false.obs;

  // Function to toggle the checkbox state
  void toggleCheckbox(bool value) {
    isChecked.value = value;
  }
  void toggleCheckpt(bool value) {
    pt.value = value;
  }

  void toggleCheckboxot(bool value) {
    ot.value = value;
  }
  void toggleCheckslp(bool value) {
    slp.value = value;
  }
  void toggleCheckmsw(bool value) {
    msw.value = value;
  }
  void toggleCheckaide(bool value) {
    aide.value = value;
  }
  void toggleCheckother(bool value) {
    other.value = value;
  }
  void toggleCheckam(bool value) {
    am.value = value;
  }
  void toggleChecknot(bool value) {
    not.value = value;
  }
  void toggleCheckmedicare(bool value) {
  medicare.value = value;
  }
  void toggleCheckmedicaid(bool value) {
  medicaid.value = value;
  }
  void toggleCheckOther(bool value) {
  Other.value = value;
  }
  void toggleCheckwill(bool value) {
  will.value = value;
  }
  void toggleCheckdnr(bool value) {
  dnr.value = value;
  }
  void toggleCheckhealthcare(bool value) {
  healthcare.value = value;
  }
  void toggleCheckdirectives(bool value) {
  directives.value = value;
  }
  void toggleChecknotice(bool value) {
  notice.value = value;
  }
  void toggleCheckoasis(bool value) {
  oasis.value = value;
  }
  void toggleCheckpatientright(bool value) {
  patientright.value = value;
  }
  void toggleCheckpatientinfo(bool value) {
  patientinfo.value = value;
  }
  void toggleCheckadvdirectives(bool value) {
  advdirectives.value = value;
  }
  void toggleCheckhomesafety(bool value) {
  homesafety.value = value;
  }
  void toggleCheckOTHER(bool value) {
  OTHER.value = value;
  }
  void toggleCheck(bool value) {
  isChecked.value = value;
  }
  // void toggleCheck(bool value) {
  // isChecked.value = value;
  // }

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