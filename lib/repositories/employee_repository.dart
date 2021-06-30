import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/employee_model.dart';

class EmployeeRepository {
  Future<bool> save(EmployeeDetailModel employeeModel) async {
    bool success = false;
    DocumentReference employeeDetails =
        FirebaseFirestore.instance.collection("Employees").doc();
    print("key${employeeDetails.id}");
    await employeeDetails.set({
      'name': employeeModel.name.toString(),
      'emailId': employeeModel.emailId.toString(),
      'designation': employeeModel.designation.toString(),
      'key': employeeDetails.id.toString(),
    }).whenComplete(() {
      print("Employee added");
      success = true;
    }).onError((error, stackTrace) {
      print("Failed to add employee: $error");
    });

    return success;
  }

  /// Fetch drivers data
  Future<List<EmployeeDetailModel>> fetchEmployeeDetails() async {
    List<EmployeeDetailModel> employeeDetailModel = [];

    await FirebaseFirestore.instance
        .collection("Employees")
        .get()
        .then((QuerySnapshot querySnapshot) async {
      print("emp==${querySnapshot.docs}");

      querySnapshot.docs.forEach((doc) async {
        EmployeeDetailModel empModel = EmployeeDetailModel();

        empModel.name = doc['name'];
        empModel.emailId = doc['emailId'];
        empModel.designation = doc['designation'];
        empModel.key = doc.id;
        //  empModel.key = doc['key'];
        print("emp==${empModel.emailId}");
        employeeDetailModel.add(empModel);
      });
    });
    print(employeeDetailModel.length);
    return employeeDetailModel;
  }

  Future<bool> deleteEmployeeRecord(String employeeId) async {
    bool success = false;
    print("key4 == ${employeeId}");

    List<EmployeeDetailModel> employeeDetailModel = [];
    employeeDetailModel = await fetchEmployeeDetails();
    String employeeKey = "";
    employeeDetailModel.forEach((element) {
      print(element.key.toString() + "==" + employeeId);
      if (element.key.toString() == employeeId) {
        employeeKey = element.key.toString();
      }
    });

    /// Delete driver data from drivers collection
    await FirebaseFirestore.instance
        .collection("Employees")
        .doc(employeeKey)
        .delete()
        .whenComplete(() => success = true)
        .onError((error, stackTrace) => print(error));
    return success;
  }

  Future<EmployeeDetailModel> fetchSingleEmployeeRecord(
      String employeeId) async {
    print("key4 == ${employeeId.toString()}");

//    List<EmployeeDetailModel> employeeDetailModel = [];
    EmployeeDetailModel singleEmployeeRecord = EmployeeDetailModel();
    DocumentReference reference =
        FirebaseFirestore.instance.collection("Employees").doc(employeeId);
    await reference.get().then((DocumentSnapshot doc) {
      singleEmployeeRecord.name = doc["name"];
      singleEmployeeRecord.emailId = doc["emailId"];
      singleEmployeeRecord.designation = doc["designation"];
      singleEmployeeRecord.key = doc.id;
    });
    print("fetchdeepak == ${singleEmployeeRecord.name}");

    return singleEmployeeRecord;
  }

  Future<bool> updateEmployeeDetails(
      EmployeeDetailModel employeeDetailModel) async {
    bool success = false;

    DocumentReference employeeDetails = FirebaseFirestore.instance
        .collection("Employees")
        .doc(employeeDetailModel.key);
    await employeeDetails.update({
      'name': employeeDetailModel.name.toString(),
      'emailId': employeeDetailModel.emailId.toString(),
      'designation': employeeDetailModel.designation.toString(),
      'key': employeeDetailModel.key.toString(),
    }).whenComplete(() {
      print("Employee added");
      success = true;
    }).onError((error, stackTrace) {
      print("Failed to add employee: $error");
    });
    return success;
  }
}
