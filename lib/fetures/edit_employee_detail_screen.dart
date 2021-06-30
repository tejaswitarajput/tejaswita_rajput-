import 'package:demo_projec/constants/circular_progressbar_fullscreen.dart';
import 'package:demo_projec/constants/palette.dart';
import 'package:demo_projec/constants/snackbar.dart';
import 'package:demo_projec/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditEmployeeScreen extends StatefulWidget {
  final String employeeId;

  const EditEmployeeScreen({Key key, this.employeeId}) : super(key: key);

  @override
  _EditEmployeeScreenState createState() => _EditEmployeeScreenState();
}

class _EditEmployeeScreenState extends State<EditEmployeeScreen> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailIdController = TextEditingController();
  // TextEditingController designationController = TextEditingController();
  @override
  void initState() {
    var prov = Provider.of<EmployeeProvider>(context, listen: false);

    if (widget.employeeId != null) {
      // prov.employeeDetailId = widget.employeeId;
      // prov.initDetails();
      print("id==${widget.employeeId}");

      // prov.employeeDetailId = widget.employeeId;
      // prov.fetchSingleEmpRecord(widget.employeeId);
      // print("dddddd==${prov.employeeDetailModel.name}");
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(builder: (context, prov, child) {
      print("Name==${prov.employeeDetailModel.name}");

      return AbsorbPointer(
        absorbing: prov.loading ? true : false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Edit Employee'),
            backgroundColor: Palette.primary,
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: prov.loading ? Colors.white : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'First name',
                              border: UnderlineInputBorder(),
                            ),
                            initialValue: prov.employeeDetailModel.name,
                            onChanged: (value) {
                              prov.employeeDetailModel.name = value.toString();
                            },
                          ),
                          SizedBox(height: 15.0),
                          SizedBox(height: 15.0),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email-Id',
                              border: UnderlineInputBorder(),
                            ),
                            initialValue:
                                prov.employeeDetailModel.emailId ?? null,
                            onChanged: (value) {
                              prov.employeeDetailModel.emailId =
                                  value.toString();
                            },
                          ),
                          SizedBox(height: 15.0),
                          TextFormField(
                            keyboardType:
                                TextInputType.number, //to accept only numbers
                            decoration: InputDecoration(
                              labelText: 'Designation',
                              //labelStyle: Constants().subtitle1,
                              border: UnderlineInputBorder(),
                            ),
                            initialValue:
                                prov.employeeDetailModel.designation ?? null,
                            onChanged: (value) {
                              prov.employeeDetailModel.designation =
                                  value.toString();
                            },
                          ),
                          SizedBox(height: 65.0),
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () async {
                                String checkData = prov.checkData();
                                print("check==${checkData.toString()}");
                                if (checkData == '' || checkData == 'success') {
                                  prov.loading = false;

                                  if (await prov.update()) {
                                    prov.loading = false;

                                    showSnackBar(
                                        context: context,
                                        message:
                                            "Edited Data Saved Successfully");
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  } else {
                                    showSnackBar(
                                        context: context, message: checkData);
                                  }
                                } else {
                                  showSnackBar(
                                      context: context, message: checkData);
                                }
                              },
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                              //   ),
                              // ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                child: prov.loading
                    ? CircularProgressbarFullscreen(title: 'processing...')
                    : Container(),
              ),
            ],
          ),
        ),
      );
    });
  }
}
