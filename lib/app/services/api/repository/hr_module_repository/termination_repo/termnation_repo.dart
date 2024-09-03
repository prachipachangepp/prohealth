class TerminationRepository{

  static String empTerminate = "/employees/terminate/";

  static String terminationPatch({required employeeId}){
    return "$empTerminate$employeeId";
  }
}