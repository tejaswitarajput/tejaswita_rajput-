import 'package:demo_projec/constants/circular_progressbar_fullscreen.dart';
import 'package:demo_projec/constants/palette.dart';
import 'package:demo_projec/constants/snackbar.dart';
import 'package:demo_projec/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateEmployeeScreen extends StatefulWidget {
  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  @override
  void initState() {
    var prov = Provider.of<EmployeeProvider>(context, listen: false);
    prov.init();

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
            title: Text('Create Employee'),
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
                              // labelStyle: Constants().subtitle1,
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
                              //  labelStyle: Constants().subtitle1,
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
                          // ignore: deprecated_member_use
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   crossAxisAlignment: CrossAxisAlignment.stretch,
                          //   children: [
                          Container(
                            width: double.infinity,
                            child: RaisedButton(
                              onPressed: () async {
                                String checkData = prov.checkData();
                                print("check==${checkData.toString()}");
                                if (checkData == '' || checkData == 'success') {
                                  prov.loading = false;

                                  if (await prov.save()) {
                                    prov.loading = false;

                                    showSnackBar(
                                        context: context,
                                        message: "Data Saved Successfully");
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
                                'Create Employee',
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
