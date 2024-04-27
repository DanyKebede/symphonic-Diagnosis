import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/usersmodel.dart';
import '../../service/doctor.dart';
import '../../service/firebase_service.dart';
import '../../widget/banner_section.dart';
import '../../widget/cutom_cachednetworkimage.dart';
import '../../widget/heading_title.dart';
import 'home_custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false).loadDoctors();
  }

  final Future<UsersModel?> user = FirebaseService().getUsersData();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    List<dynamic> d = Provider.of<DoctorProvider>(context).doctorData;

    return FutureBuilder<UsersModel?>(
      future: user,
      builder: (BuildContext context, AsyncSnapshot<UsersModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(body: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          UsersModel? userModel = snapshot.data;
          return Scaffold(
            appBar: HomeCustomAppbar(
              title: userModel!.title,
              firstName: userModel.firstName,
              lastName: userModel.lastName,
              profileImageUrl: userModel.imageUrl,
              onPressed: () {},
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.013),
                const BannerSection(),
                HeadingTitle(
                  mainColor: const Color.fromRGBO(13, 133, 72, 1),
                  title: 'Find Your Doctor',
                  seeAll: () {
                    Navigator.of(context).pushNamed('/doctor-list');
                  },
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: d.length,
                    itemBuilder: (ctx, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              '/doctor-page',
                              arguments: d[index].id,
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: d[index].imgurl != ''
                                    ? SizedBox(
                                        height: 190,
                                        width: double.infinity,
                                        child: CustomCachedNetworkImage(
                                          image: d[index].imgurl,
                                        ),
                                      )
                                    : Image.asset(
                                        'assets/images/doctor.png',
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${d[index].title.toUpperCase()}. ${d[index].name}',
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                d[index].speciality,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
              body: Center(
            child: Text('No data'),
          ));
        }
      },
    );
  }
}
