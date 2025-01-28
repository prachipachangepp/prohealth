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
  //   .value = value;
  // }

}






class AdminInfoChechBox extends GetxController{

  var ukp = false.obs;
  var ukn  = false.obs;
  var a = false.obs;
  var b = false.obs;
  var c = false.obs;
  var d = false.obs;
  var e = false.obs;
  var x = false.obs;
  var y = false.obs;
  var aa  = false.obs;
  var bb = false.obs;
  var cc = false.obs;
  var dd = false.obs;
  var  ee= false.obs;
  var ff = false.obs;
  var gg = false.obs;
  var hh = false.obs;
  var ii = false.obs;
  var jj = false.obs;
  var kk = false.obs;
  var ll = false.obs;
  var mm = false.obs;
  var nn = false.obs;
  var  xx= false.obs;
  var yy = false.obs;
  var zz = false.obs;
var zero  = false.obs;
var one  = false.obs;
var two = false.obs;
var three = false.obs;
var four  = false.obs;
var five = false.obs;
var six  = false.obs;
var seven = false.obs;
var eight = false.obs;
var nine = false.obs;
var  ten = false.obs;
var eleven = false.obs;
var tuk = false.obs;
 var na = false.obs;
var  nomedicaid = false.obs;
var noavaiable  = false.obs;
var nomedicare = false.obs;
// var  = false.obs;



  void toggleCheckukn(bool value) {
    ukn.value = value;
  }
  void toggleCheckukp(bool value) {
    ukp.value = value;
  }
  void toggleChecka(bool value) {
    a.value = value;
  }
  void toggleCheckb(bool value) {
    b.value = value;
  }
  void toggleCheckc(bool value) {
    c.value = value;
  }
  void toggleCheckd(bool value) {
    d.value = value;
  }
  void toggleChecke(bool value) {
    e.value = value;
  }
  void toggleCheckx(bool value) {
    x.value = value;
  }
  void toggleChecky(bool value) {
    y.value = value;
  }
  void toggleCheckaa(bool value) {
    aa.value = value;
  }
  void toggleCheckbb(bool value) {
    bb.value = value;
  }
  void toggleCheckcc(bool value) {
    cc.value = value;
  }

  void toggleCheckdd(bool value) {
    dd .value = value;
  }

  void toggleCheckee(bool value) {
    ee.value = value;
  }

  void toggleCheckff(bool value) {
    ff.value = value;
  }
  void toggleCheckgg(bool value) {
    gg .value = value;
  }

  void toggleCheckhh(bool value) {
    hh.value = value;
  }
  void toggleCheckii(bool value) {
    ii.value = value;
  }

  void toggleCheckjj(bool value) {
    jj.value = value;
  }
  void toggleCheckkk(bool value) {
    kk.value = value;
  }

  void toggleCheckll(bool value) {
    ll.value = value;
  }
  void toggleCheckmm(bool value) {
    mm.value = value;
  }

  void toggleChecknn(bool value) {
    nn.value = value;
  }
  void toggleCheckxx(bool value) {
    xx .value = value;
  }

  void toggleCheckyy(bool value) {
    yy.value = value;
  }
  void toggleCheckzz(bool value) {
    zz.value = value;
  }

  void toggleCheckzero(bool value) {
    zero.value = value;
  }
void toggleCheckone(bool value) {
  one.value = value;
}
void toggleChecktwo(bool value) {
  two.value = value;
}
   void toggleCheckthree(bool value) {
  three.value = value;
}
void toggleCheckfour(bool value) {
  four.value = value;
}
    void toggleCheckfive(bool value) {
  five.value = value;
}
void toggleChecksix(bool value) {
  six.value = value;
}
     void toggleCheckseven(bool value) {
  seven.value = value;
}
void toggleCheckeight(bool value) {
  eight.value = value;
}
    void toggleChecknine(bool value) {
  nine.value = value;
}
void toggleCheckten(bool value) {
  ten.value = value;
}
     void toggleCheckeleven(bool value) {
  eleven.value = value;
}
void toggleChecktuk(bool value) {
  tuk.value = value;
}
   void toggleCheckna(bool value) {
  na.value = value;
}
void toggleChecknomedicare(bool value) {
  nomedicare.value = value;
}

void toggleChecknoavaiable(bool value) {
  noavaiable.value = value;
}
void toggleChecknomedicaid(bool value) {
  nomedicaid.value = value;
}
// void toggleCheck(bool value) {
//   .value = value;
// }
// void toggleCheck(bool value) {
//   .value = value;
// }
// void toggleCheck(bool value) {
//   .value = value;
// }
//


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