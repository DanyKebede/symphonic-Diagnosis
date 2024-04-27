import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/doctor.dart';
import '../../widget/cutom_cachednetworkimage.dart';

class DoctorList extends StatefulWidget {
  static const String routeName = '/doctor-list';

  const DoctorList({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const DoctorList(),
    );
  }

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> d = Provider.of<DoctorProvider>(context).searchResult;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "List of Doctors",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) =>
                  Provider.of<DoctorProvider>(context, listen: false)
                      .search(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(13, 133, 72, 1),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Ex. Yonatan",
                hintStyle: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 15,
                  color: Color.fromRGBO(198, 185, 185, 1),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
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
      ),
    );
  }
}
