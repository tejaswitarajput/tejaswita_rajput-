import 'package:demo_projec/constants/circular_progressbar_fullscreen.dart';
import 'package:demo_projec/widgets/drawer_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants/palette.dart';
import 'constants/screen_helper.dart';

class HomescreenDrawer extends StatefulWidget {
  @override
  _HomescreenDrawerState createState() => new _HomescreenDrawerState();
}

class _HomescreenDrawerState extends State<HomescreenDrawer> {
  bool isLoading = false;
  String userName = '';
  String territory = '';

  Future<void> onLogOut(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isLoading ? true : false,
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Palette.primary,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: ClipOval(
                            child: Image.asset(
                          'assets/logo.png',
                          width: 80,
                        )),
                      ),
                      Text(
                        "userName ?? " "",
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      ),
                      Text(
                        " territory ?? " "",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              isLoading
                  ? CircularProgressbarFullscreen(title: 'Logging Out')
                  : SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          DrawerListTile(
                              icon: Icons.person,
                              title: "Doctor Data",
                              onTap: () => {
                                    Navigator.pop(context),
                                    ScreenHelper.openScreen(
                                        context, Screen.recordList)
                                  }),
                          DrawerListTile(
                              icon: Icons.web,
                              title: "Microsite View",
                              onTap: () => {
                                    Navigator.pop(context),
                                    ScreenHelper.openScreen(
                                        context, Screen.recordList)
                                  }),
                          DrawerListTile(
                              icon: Icons.settings,
                              title: "Settings",
                              onTap: () => {
                                    Navigator.pop(context),
                                    ScreenHelper.openScreen(
                                        context, Screen.settings)
                                  }),
                        ],
                      ),
                    ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutAlert() {
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are You sure you want to log out?"),
      actions: [
        FlatButton(
          child: Text(
            "No",
            style: TextStyle(fontSize: 16),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text("Yes", style: TextStyle(fontSize: 16)),
          onPressed: () async {
            Navigator.pop(context);
            await onLogOut(context);
          },
        ),
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
