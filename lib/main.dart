import 'package:demo_projec/providers/employee_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/route_generator.dart' as router;
import 'constants/palette.dart';
import 'constants/router_constants.dart';
import 'fetures/splash_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmployeeProvider()),
      ],
      child: MaterialApp(
        color: Palette.primary, debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        onGenerateRoute: router.generateRoute,
        initialRoute: RouterConstants.MainRoute,
        //   routes: <String, WidgetBuilder>{
        // '/InitialScreen': (BuildContext context) => SplashScreen(),
      ),
    );
  }
}
