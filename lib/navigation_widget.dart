import 'package:flutter/material.dart';
import 'package:symphonicdiagnosis/screens/firstaidPage/firstaid.dart';
import 'package:symphonicdiagnosis/screens/profile/profilepage.dart';

import '../../screens/screens.dart';
import 'screens/medicalPage/medicalinformation.dart';

class Navigation extends StatefulWidget {
  static const routeName = '/navigation';

  const Navigation({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const Navigation(),
    );
  }

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          HomePage(),
          SymptomPage(),
          DiseasePage(),
          FirstAidPage(),
          ProfilePage()
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          indicatorColor: Colors.transparent,
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (states) => Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: const Color.fromRGBO(58, 173, 115, 1)),
          ),
        ),
        child: NavigationBar(
          elevation: 0,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: [
            NavigationDestination(
              selectedIcon: imageAsset('assets/images/nav/home_active.png'),
              icon: imageAsset('assets/images/nav/home.png'),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon:
                  imageAsset('assets/images/nav/Disease_Prediction.png'),
              icon: imageAsset('assets/images/nav/Disease_Prediction.png'),
              label: 'Prediction',
            ),
            NavigationDestination(
              selectedIcon: imageAsset(
                  'assets/images/nav/Disease_Information_active.png'),
              icon: imageAsset('assets/images/nav/Disease_Information.png'),
              label: 'Diseases',
            ),
            NavigationDestination(
              selectedIcon:
                  imageAsset('assets/images/nav/first_aid_kit_active.png'),
              icon: imageAsset('assets/images/nav/first_aid_kit.png'),
              label: 'First Aid',
            ),
            NavigationDestination(
              selectedIcon: imageAsset('assets/images/nav/user_active.png'),
              icon: imageAsset('assets/images/nav/user.png'),
              label: 'Profile',
            )
          ],
        ),
      ),
    );
  }

  Image imageAsset(String path) {
    return Image.asset(
      path,
      width: 27,
      height: 29.5,
      fit: BoxFit.fill,
      color: const Color.fromRGBO(13, 133, 72, 1),
    );
  }
}
