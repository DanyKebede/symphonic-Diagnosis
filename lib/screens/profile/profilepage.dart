import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usersmodel.dart';
import '../../repository/user_repository.dart';
import '../../widget/custom_bottom_sheet.dart';
import '../../widget/cutom_cachednetworkimage.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ProfilePage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UsersRepository>(context);
    final UsersModel user = userProvider.currentUserData;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              alignment: Alignment.center,
              height: size.height * 0.133,
              width: size.width * 0.297,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromRGBO(13, 133, 72, 1),
                  width: 2,
                ),
              ),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CustomCachedNetworkImage(image: user.imageUrl),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          // Add your edit profile logic here
                        },
                        icon: const Icon(Icons.edit_square),
                        color: const Color.fromRGBO(13, 133, 72, 1),
                        iconSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              '${user.title}. ${user.firstName} ${user.lastName}',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          CardElement(
            leadingIcon: Icons.person_outline,
            title: 'Your Profile',
            onTap: () {
              Navigator.of(context).pushNamed('/profileDataUpdatePage');
            },
          ),
          CardElement(
            leadingIcon: Icons.description_outlined,
            title: 'Description',
            onTap: () {
              Navigator.of(context).pushNamed('/descriptionUpdatePage');
            },
          ),
          CardElement(
            leadingIcon: Icons.password,
            title: 'Change Password',
            onTap: () {
              Navigator.of(context).pushNamed('/changePasswordPage');
            },
          ),
          CardElement(
            leadingIcon: Icons.lock_outline_rounded,
            title: 'Privacy Policy',
            onTap: () {
              Navigator.of(context).pushNamed('/privacyPolicyPage');
            },
          ),
          CardElement(
            leadingIcon: Icons.question_mark_outlined,
            title: 'Help',
            onTap: () {
              Navigator.of(context).pushNamed('/helpPage');
            },
          ),
          CardElement(
            leadingIcon: Icons.logout,
            title: 'Log out',
            onTap: () async {
              bool? confirmation =
                  await BottomSheetHelper.showLogoutConfirmationBottomSheet(
                      context: context,
                      headingTitle: 'Logout',
                      bodyText: 'Are you sure you want to log out?');

              if (confirmation!) {
                try {
                  FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/authPage', (route) => false);
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Logout failed. Please try again.'),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

class CardElement extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;
  const CardElement({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 0.7,
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            leadingIcon,
            color: const Color.fromRGBO(13, 133, 72, 1),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Color.fromRGBO(13, 133, 72, 1),
          ),
        ),
      ),
    );
  }
}
