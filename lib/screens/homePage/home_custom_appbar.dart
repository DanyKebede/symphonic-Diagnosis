import 'package:flutter/material.dart';

import '../../widget/cutom_cachednetworkimage.dart';

class HomeCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String profileImageUrl;
  final String firstName;
  final String lastName;
  final String title;
  final VoidCallback onPressed;

  const HomeCustomAppbar({
    super.key,
    required this.profileImageUrl,
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.onPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      toolbarHeight: 70,
      elevation: 0,
      leading: Container(
        margin: const EdgeInsets.only(left: 12),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color.fromRGBO(13, 133, 72, 1),
            width: 1,
          ),
        ),
        child: CircleAvatar(
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CustomCachedNetworkImage(image: profileImageUrl),
            ),
          ),
        ),
      ),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome 👋',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            Text(
              '$title. $firstName $lastName',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.message),
          color: const Color.fromRGBO(13, 133, 72, 1),
          iconSize: 31,
        ),
      ],
    );
  }
}
