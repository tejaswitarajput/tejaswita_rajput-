import 'package:demo_projec/constants/route_generator.dart';
import 'package:demo_projec/providers/employee_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../router_constants.dart';
import '../snackbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController emailIdController = TextEditingController();
  // TextEditingController designationController = TextEditingController();
  void initState() {
    var prov = Provider.of<EmployeeProvider>(context, listen: false);

    prov.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(builder: (context, prov, child) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              primary: true,
              pinned: true,
              expandedHeight: 200,
              stretch: true,
              // title: Text("Demo App"),
              flexibleSpace: FlexibleSpaceBar(
                  background: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    MaterialButton(
                      onPressed: () {
                        showGeneralDialog(
                            context: context,
                            barrierDismissible: true,
                            barrierLabel: MaterialLocalizations.of(context)
                                .modalBarrierDismissLabel,
                            barrierColor: Colors.black45,
                            transitionDuration:
                                const Duration(milliseconds: 200),
                            pageBuilder: (BuildContext buildContext,
                                Animation animation,
                                Animation secondaryAnimation) {
                              return Center(
                                child: Container(
                                  width: 300,
                                  height: 200,
                                  padding: EdgeInsets.all(20),
                                  color: Colors.white,
                                  child: Scaffold(
                                    body: Container(
                                        child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                arguments: EmployeeArgument(
                                                    employeeId: ""));
                                          },
                                          minWidth: 250.0,
                                          height: 35,
                                          color: Colors.blueAccent,
                                          child: new Text('Create Employee',
                                              style: new TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white)),
                                        ),
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          minWidth: 250.0,
                                          height: 35,
                                          color: Colors.blueAccent,
                                          child: new Text('Employee List',
                                              style: new TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.white)),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/icons/logo.png'),
                            radius: 30),
                        Text("Demo App"),
                      ],
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Icon(Icons.search, color: Colors.white),
                    )
                  ])),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  print("key6 ==${prov.employeeDetailList[i].name}");
                  print("key6 ==${prov.employeeDetailList[i].key}");

                  return EmployeeCardWidget(
                    name: prov.employeeDetailList[i].name,
                    emailId: prov.employeeDetailList[i].emailId,
                    designation: prov.employeeDetailList[i].designation,
                    empKey: prov.employeeDetailList[i].key,
                    onDelete: () async {
                      print("key5 ==${prov.employeeDetailList[i].key}");
                      if (await prov
                          .deleteEmployee(prov.employeeDetailList[i])
                          .whenComplete(() {
                        showSnackBar(
                            context: context,
                            message: "Data deleted Successfully");
                      })) {
                      } else {
                        showSnackBar(
                            context: context, message: " Can't Data deleted");
                      }
                    },
                  );
                },
                childCount: prov.employeeDetailList.length,
              ),
            ),
          ],
        ),
      );
    });
  }
}

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
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouterConstants.CreateEmployeeScreenRoute,
                            arguments: EmployeeArgument(employeeId: empKey));
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
//SizedBox(height: 12),
