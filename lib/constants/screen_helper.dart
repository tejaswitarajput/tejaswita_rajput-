import 'package:demo_projec/constants/fetures/record_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Screen {
  recordList,
  detail,
  settings,
  delete,
}

class ScreenHelper {
  static void openScreen(BuildContext context, Screen screen) async {
    // String helpLink = await UrlHelper.getUrlForTag('support_ticket');
    // String myScoreLink = await UrlHelper.getUrlForTag('my_score');
    // String updateProfile = await UrlHelper.getUrlForTag('updateProfile');
    // String logoutUrl = await UrlHelper.getUrlForTag("logout");

    switch (screen) {
      case Screen.detail:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RecordListScreen()));
        break;

        break;
      case Screen.settings:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RecordListScreen()));
        break;
      case Screen.delete:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RecordListScreen()));
        break;
      case Screen.recordList:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RecordListScreen()));
        break;
      default:
    }
  }
}
