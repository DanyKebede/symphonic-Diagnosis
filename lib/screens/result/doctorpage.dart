import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/doctormodel.dart';
import '../../service/doctor.dart';

class DoctorPage extends StatelessWidget {
  static const routeName = '/doctor-page';
  const DoctorPage({super.key, required this.index});

  final String index;

  static Route route(String p) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => DoctorPage(
        index: p,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Filter Do
    List<dynamic> data =
        Provider.of<DoctorProvider>(context, listen: false).doctorData;
    List<dynamic> d = data.where((element) {
      return element.id == index;
    }).toList();
    DoctorModel doctorDetail = d[0];

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Doctor Information",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                      color: const Color.fromRGBO(13, 133, 72, 1),
                    ),
                    shape: BoxShape.circle,
                  ),
                  width: 150,
                  height: size.height * 0.2,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ClipOval(
                        child: doctorDetail.imgurl != ''
                            ? Image.network(
                                doctorDetail.imgurl,
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              )
                            : Image.asset(
                                'assets/images/doctor.png',
                                fit: BoxFit.cover,
                                width: 140,
                                height: 140,
                              ),
                      ),
                    ),
                  ),
                ),
                Text(
                  '${doctorDetail.title.toUpperCase()}. ${doctorDetail.name}',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  doctorDetail.email,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  doctorDetail.speciality,
                  style: const TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 13,
                      fontFamily: 'Inter'),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: size.height * 0.065,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              children: [
                                TextSpan(
                                    text: '${doctorDetail.hours}',
                                    style: const TextStyle(fontSize: 16)),
                                const TextSpan(
                                    text: 'hr/day',
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                          const Text(
                            'Available',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              children: [
                                TextSpan(
                                    text: '${doctorDetail.experiance}',
                                    style: const TextStyle(fontSize: 16)),
                                const TextSpan(
                                    text: ' years',
                                    style: TextStyle(
                                      fontSize: 12,
                                    )),
                              ],
                            ),
                          ),
                          const Text(
                            'Experiance',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 13,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  color: Color.fromARGB(255, 0, 0, 0)),
                              children: [
                                TextSpan(
                                    text: '${doctorDetail.rating}',
                                    style: const TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          const Text(
                            'Rating',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 13,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            width: size.width,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(13, 133, 72, 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 11),
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Divider(
                  height: 3,
                  color: Colors.black,
                ),
                personalInformation(
                    'assets/images/email.png', doctorDetail.email),
                personalInformation(
                    'assets/images/telephone.png', doctorDetail.phone),
                personalInformation('assets/images/time.png',
                    'Available ${doctorDetail.hours}hr/day'),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(13, 133, 72, 1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      minimumSize:
                          Size(MediaQuery.of(context).size.width * 0.7, 56),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed('/navigation');
                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SfPro',
                      ),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget personalInformation(String img, String s) {
  return ListTile(
    leading: Image.asset(
      img,
      width: 35,
      height: 35,
      color: Colors.white,
    ),
    title: Text(
      s,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}
