class physicianInfo{

  static String physicianinfo ="/intake-physician-info/add";

static String piftof ="/intake-physician-f2-f/add";
static String  firstrd ="/intake-physician-rdignosis/add";
static String  pdrd ="/intake-physician-rdignosis/add";

static String stateDropdown ="/state";
static String cityDropdown ="/city";
static String relationshipDropdown ="/relationship";
static String languageSpokenDropdown ="/language-spoken";
static String metrialStatusDropdown ="/marital-status";
static String raceDropdown ="/race";
static String religionDropdown ="/religion";
static String statuspatient="/patient-status";







  static  String addPIinfo(){
    return "$physicianinfo";
  }

  ////
  static  String addPIftof(){
    return "$piftof";
  }

  ////
static String addfirstRD(){
    return "$firstrd";
}

  static String addpdrd(){
    return "$pdrd";
  }

  static String stateDD(){
    return "$stateDropdown";
  }


  static String cityDD(){
    return "$cityDropdown";
  }

  static String relationshipDD(){
    return "$relationshipDropdown";
  }

  static String languageSpokenDD(){
    return "$languageSpokenDropdown";
  }

  static String metrialstatusDD(){
    return "$metrialStatusDropdown";
  }

  static String raceDD(){
    return "$raceDropdown";
  }


  static String religionDD(){
    return "$religionDropdown";
  }

  static String statuschange(){
    return"$statuspatient";
  }
}