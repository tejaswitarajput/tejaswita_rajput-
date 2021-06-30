import 'package:demo_projec/models/employee_model.dart';
import 'package:demo_projec/repositories/employee_repository.dart';
import 'package:flutter/cupertino.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeeDetailModel employeeDetailModel = EmployeeDetailModel();
  bool loading = false;
  List<EmployeeDetailModel> employeeDetailList = [];
  String employeeDetailId = "";

  init() async {
    employeeDetailModel = EmployeeDetailModel();
    await fetchSavedList();
    if (employeeDetailId != null) {
      print("employee==$employeeDetailId");
      await fetchSingleEmpRecord(employeeDetailId);
      notifyListeners();
      print("employee==${employeeDetailModel.name}.");
    }
  }

  checkData() {
    String message = "";
    if (employeeDetailModel.name == "" || employeeDetailModel.name == null)
      message = "Please enter employee name";
    else if (employeeDetailModel.emailId == "" ||
        employeeDetailModel.emailId == null)
      message = "Please enter email id";
    else if (employeeDetailModel.designation == "" ||
        employeeDetailModel.designation == null)
      message = "Please enter designation";
    else
      message = "success";
    return message;
  }

  Future<bool> save() async {
    loading = true;
    notifyListeners();
    return await EmployeeRepository()
        .save(employeeDetailModel)
        .whenComplete(() {
      loading = false;
      notifyListeners();
    });
  }

  Future<void> fetchSavedList() async {
    employeeDetailList = [];
    employeeDetailList = await EmployeeRepository().fetchEmployeeDetails();
    print("data==${employeeDetailList.length}");
    notifyListeners();
  }

  fetchEmployee(String empId) {}

  Future<bool> deleteEmployee(EmployeeDetailModel employeeDetailModel) async {
    bool status = false;
    String employeeId = '';
    print("key1 == ${employeeDetailModel.key}");
    if (employeeDetailModel != null) {
      print("key2 == ${employeeDetailModel.key}");

      if (employeeDetailModel.key.toString() != null) {
        print("key3 == ${employeeDetailModel.key}");

        employeeId = employeeDetailModel.key.toString();
        print("key4 == ${employeeId.toString()}");
        status = await EmployeeRepository().deleteEmployeeRecord(employeeId);
        employeeDetailList = await EmployeeRepository().fetchEmployeeDetails();
        notifyListeners();
      }
    }
    return status;
  }

  fetchSingleEmpRecord(String employeeId) async {
    employeeDetailModel =
        await EmployeeRepository().fetchSingleEmployeeRecord(employeeId);
    notifyListeners();
  }

  updateEmployeeRecord(String employeeId) async {
    bool success = false;
    employeeDetailModel =
        await EmployeeRepository().fetchSingleEmployeeRecord(employeeId);
    success = EmployeeRepository().updateEmployeeDetails(employeeDetailModel);

    return success;
  }
}
