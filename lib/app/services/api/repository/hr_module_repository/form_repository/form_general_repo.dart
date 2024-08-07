class ProgressBarRepository{

  static String grneralpage ="/employees/add";

 static String employmentpage ="/employee-employment-histories/add";

 static String educationpage ="/employee-educations/add";

 static String  referencepage  ="/reference/add";


 static String licensespage   = "/employee-licenses/add";

 static String   bankingpage  = "/employee-bankings/add";


  static String employeedocSetup = "/employee-document-type-setup";

static String verifyuserpopup = "/auth/Otp";


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
}

