import 'package:demo_projec/constants/snackbar.dart';
import 'package:demo_projec/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../circular_progressbar_fullscreen.dart';
import '../palette.dart';

class CreateEmployeeScreen extends StatefulWidget {
  final String employeeId;

  const CreateEmployeeScreen({Key key, this.employeeId}) : super(key: key);
  @override
  _CreateEmployeeScreenState createState() => _CreateEmployeeScreenState();
}

class _CreateEmployeeScreenState extends State<CreateEmployeeScreen> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailIdController = TextEditingController();
  // TextEditingController designationController = TextEditingController();
  void initState() {
    var prov = Provider.of<EmployeeProvider>(context, listen: false);

    prov.init();
    print("id==${widget.employeeId}");
    if (widget.employeeId != null) {
      prov.employeeDetailId = widget.employeeId;
      print("Name==${prov.employeeDetailModel.name}");
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
            title: Text('Add New Employee'),
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
                                'Submit',
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

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     height: 50,
                //     width: double.infinity,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.stretch,
                //       children: [
                //         SizedBox(width: 10),
                //         Expanded(
                //           child: RaisedButton(
                //             onPressed: () async {
                //               String checkData = prov.checkData();
                //               if (checkData == '' || checkData == 'success') {
                //                 if (await prov.save()) {
                //                   prov.loading = false;
                //                   showSnackBar(
                //                       context: context,
                //                       message: "Data Saved Successfully");
                //                 } else {
                //                   showSnackBar(
                //                       context: context,
                //                       message: "Data Saved Filed");
                //                 }
                //               }
                //             },
                //             color: Colors.blue,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(18.0),
                //             ),
                //             child: Text(
                //               'Submit',
                //               style: TextStyle(color: Colors.white),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
