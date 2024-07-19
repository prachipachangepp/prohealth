class ProgressBarRepository{

  static String grneralpage ="/employees/add";

 static String employmentpage ="/employee-employment-histories/add";

 static String educationpage ="/employee-educations/add";

 static String  referencepage  ="/reference/add";


 static String licensespage   = "/employee-licenses/add";

 static String   bankingpage  = "/employee-bankings/add";



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

}

