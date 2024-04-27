import 'package:flutter/material.dart';

class DiseaseDetailPage extends StatelessWidget {
  final dynamic d;

  static const String routeName = '/disease-detail';

  const DiseaseDetailPage({super.key, required this.d});
  static Route route(dynamic disease) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => DiseaseDetailPage(
        d: disease,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          d.name,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const TabBar(
              labelColor: Color.fromARGB(255, 0, 0, 0),
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 4,
                    color: Color.fromRGBO(13, 133, 72, 1),
                  ),
                ),
              ),
              tabs: [
                Tab(
                  child: FittedBox(
                    child: Text(
                      'Overview',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                Tab(
                  child: FittedBox(
                    child: Text(
                      'Symptoms',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                Tab(
                  child: FittedBox(
                    child: Text(
                      'Causes',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
                Tab(
                  child: FittedBox(
                    child: Text(
                      'Diagnosis',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Overview tab content
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          d.overview[0],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'OpenSans',
                            // adjust this value as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Diagnosis tab content
                  ListItems(d: d.symptoms),
                  // Causes tab content
                  ListItems(d: d.causes),
                  // Symptoms tab content
                  ListItems(d: d.diagnosis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({
    super.key,
    required this.d,
  });

  final List d;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: d
              .map((e) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: const Icon(
                            Icons.forward,
                            color: Color.fromARGB(255, 0, 0, 0),
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            e,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'OpenSans'),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
