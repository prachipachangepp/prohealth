class ProgressBarRepository{

  static String grneralpage ="/employees/add";

 static String employmentpage ="/employee-employment-histories/add";

 static String educationpage ="/employee-educations/add";

 static String  referencepage  ="/reference/add";


 static String licensespage   = "/employee-licenses/add";

 static String   bankingpage  = "/employee-bankings/add";


  static String employeedocSetup = "/employee-document-type-setup";

static String verifyuserpopup = "/auth/Otp";


///patch api
  ///
  static String educationscreen  ="/employee-educations";


  ///  degree api
  static String educationdegree ="/employee-degree";



  ///get api

 static  String educationformprifill ="/employee-educations";
 static  String employmentformprifill ="/employee-employment-histories";
 static  String referenceformprifill ="/reference";
 static  String bankingformprifill ="/employee-bankings";
 static  String licensesformprifill ="/employee-licenses";


   String getEmployeeByEmpID({required int employeeID} ){
    return "$educationformprifill/ByemployeeId/$employeeID/no";
  }

  String getEmploymentByEmpID({required int employeeID} ){
    return "$employmentformprifill/ByemployeeId/$employeeID/no";
  }

  String getReferenceByEmpID({required int employeeID} ){
    return "$referenceformprifill/ByemployeeId/$employeeID/no";
  }

  String getBankingByEmpID({required int employeeID} ){
    return "$bankingformprifill/ByemployeeId/$employeeID/no";


  }  String getLicensesByEmpID({required int employeeID} ){
    return "$licensesformprifill/ByemployeeId/$employeeID/no";
  }

  ///
///////
  static String postgeneralscreen(){
    return "$grneralpage";
  }
  ////
static String postemploymentscreen(){
   return "$employmentpage";
}
//////
static String posteducationscreen(){
    return "$educationpage";
}
///////
static String postreferencescreen(){
    return "$referencepage";
}
///////
static String postlicensesscreen(){
    return "$licensespage";
}
 static String postbankingscreen(){
    return "$bankingpage";
 }



 ////
  ///employee doc list
  static String getEmployeeDocSetUpMetaIdHR({
    /// required int metaDocId
    required int pageNo, required int rowsNo,
    required int employeeDocTypeMetaDataId
  }){
    /// return "$employeedocSetup/$metaDocId";
    return "$employeedocSetup/$employeeDocTypeMetaDataId/$pageNo/$rowsNo";
  }


 ///////
static String postverifyuser(){
    return "$verifyuserpopup";
}



///patch api

  static String patchEmployeeDucationForm({required int educationId}){
    return "$educationscreen/$educationId";
  }


 ///degree dropdown

  static String patchEmployeeDegree(){
    return "$educationdegree";
  }


  ///prifillapi education

  static String educationformget({required int educationId }){
    return "$educationformprifill/$educationId";
  }
}

