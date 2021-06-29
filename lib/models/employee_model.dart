class EmployeeDetailModel {
  String name;
  String emailId;
  String designation;
  String key;
  EmployeeDetailModel({this.name, this.emailId, this.designation, this.key});

  // @Required(error: 'Firstname is required')
  // @StringLength(
  //     min: 3, max: 32, error: 'Firstname must have between 3 and 32 characters')
  // String name;
  //
  // @Required(error: 'designation is required')
  // @StringLength(
  //     min: 3,
  //     max: 32,
  //     error: 'designation must have between 3 and 32 characters')
  // String designation;
  //
  // @Required(error: 'designation is required')
  // @Email(error: 'enter proper email ')
  // String emailId;
}
