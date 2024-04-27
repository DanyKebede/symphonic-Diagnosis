import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/disease.dart';
import '../../service/symptom.dart';

class ResultPage extends StatelessWidget {
  static const String routeName = '/result';

  const ResultPage({super.key});
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const ResultPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final predicted = Provider.of<SymptomProvider>(
      context,
    ).predictedDisease;
    return Scaffold(
      backgroundColor: Colors.grey[80],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Result Screen",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            padding:
                const EdgeInsets.only(right: 11, left: 11, top: 10, bottom: 30),
            width: size.width,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(13, 133, 72, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.warning_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      status[0].title,
                      style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  status[0].description,
                  style: const TextStyle(
                      fontFamily: 'Inter', fontSize: 15, color: Colors.white),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
            padding: const EdgeInsets.only(top: 10, bottom: 30),
            width: size.width,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(13, 133, 72, 1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 11),
                    child: Text(
                      'Possible condition',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  Card(
                    margin: const EdgeInsets.only(top: 7, left: 2, right: 2),
                    color: const Color.fromRGBO(13, 133, 72, 1),
                    child: ListTile(
                      title: Text(
                        predicted.predictedDisease,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/showdetail',
                                  arguments: predicted);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                              color: Color.fromARGB(255, 148, 145, 145),
                            ),
                            label: const Text(
                              'Show details',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 11, top: 10),
                    child: Text(
                      'Confidence Score',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  Card(
                    margin: const EdgeInsets.only(top: 7, left: 2, right: 2),
                    color: const Color.fromRGBO(13, 133, 72, 1),
                    child: ListTile(
                      title: Text(
                        '${predicted.confidenceScore} %',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 11, top: 10),
                    child: Text(
                      'Speciality Required',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  Card(
                    margin: const EdgeInsets.only(top: 7, left: 2, right: 2),
                    color: const Color.fromRGBO(13, 133, 72, 1),
                    child: ListTile(
                      title: Text(
                        predicted.speciality,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20),
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
                    Navigator.of(context).pushNamed("/navigation");
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SfPro',
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
