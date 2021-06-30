import 'package:demo_projec/constants/circular_progressbar_fullscreen.dart';
import 'package:demo_projec/constants/palette.dart';
import 'package:demo_projec/constants/route_generator.dart';
import 'package:demo_projec/constants/router_constants.dart';
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
            backgroundColor: Colors.blueAccent,
            toolbarHeight: 100,
            leading: MaterialButton(
              onPressed: () {
                showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.black45,
                    transitionDuration: const Duration(milliseconds: 200),
                    pageBuilder: (BuildContext buildContext,
                        Animation animation, Animation secondaryAnimation) {
                      return Center(
                        child: Container(
                          width: 300,
                          height: 200,
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Scaffold(
                            body: Card(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: new Icon(Icons.close),
                                        color: Colors.black,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context,
                                        RouterConstants
                                            .CreateEmployeeScreenRoute,
                                        arguments:
                                            EmployeeArgument(employeeId: ""));
                                  },
                                  minWidth: 250.0,
                                  height: 35,
                                  color: Colors.blueAccent,
                                  child: new Text('Create Employee',
                                      style: new TextStyle(
                                          fontSize: 16.0, color: Colors.white)),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        RouterConstants.HomeScreenRoute);
                                  },
                                  minWidth: 250.0,
                                  height: 35,
                                  color: Colors.blueAccent,
                                  child: new Text('Employee List',
                                      style: new TextStyle(
                                          fontSize: 16.0, color: Colors.white)),
                                )
                              ],
                            )),
                          ),
                        ),
                      );
                    });
              },
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                      backgroundImage: AssetImage('assets/icons/logo.png'),
                      radius: 20),
                  MaterialButton(
                    onPressed: () {},
                    child: Icon(Icons.search, color: Colors.white),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child:
                        Icon(Icons.account_circle_rounded, color: Colors.white),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Conaug",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      Text(
                        "Flutter",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ],
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
