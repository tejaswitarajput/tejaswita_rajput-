import 'package:demo_projec/constants/route_generator.dart';
import 'package:demo_projec/constants/router_constants.dart';
import 'package:demo_projec/providers/employee_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeCardWidget extends StatelessWidget {
  final String name;
  final String designation;
  final String emailId;
  final String empKey;
  final Function onDelete;

  const EmployeeCardWidget({
    Key key,
    this.name,
    this.designation,
    this.emailId,
    this.empKey,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
        elevation: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      padding: new EdgeInsets.all(15.0),
                      child: CircleAvatar(
                          backgroundImage: AssetImage("assets/icons/logo.png"),
                          radius: 25),
                    ),
                  ],
                ),
              ),
              Container(
                padding: new EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      designation,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      emailId,
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ]),
            Container(
              child: Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.edit, size: 25.0),
                      onPressed: () async {
                        final prov = Provider.of<EmployeeProvider>(context,
                            listen: false);
                        prov.employeeDetailId = empKey;
                        prov.initDetails().whenComplete(() =>
                            Navigator.pushNamed(context,
                                RouterConstants.EditEmployeeScreenRoute,
                                arguments:
                                    EmployeeArgument(employeeId: empKey)));
                      }),
                  IconButton(
                      icon: Icon(Icons.delete, size: 25.0),
                      onPressed: () {
                        onDelete();
                        // Navigator.pushNamed(
                        //     context, RouterConstants.CreateEmployeeScreenRoute);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
