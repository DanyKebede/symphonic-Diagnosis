import 'package:flutter/material.dart';

import 'listItems.dart';

class FistAidDetailPage extends StatelessWidget {
  static const String routeName = '/firstaid-detail';
  final dynamic d;

  const FistAidDetailPage({super.key, required this.d});

  static Route route(dynamic firstaid) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => FistAidDetailPage(
        d: firstaid,
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
        length: 2,
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
                      'Points to Consider',
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
                      'Action To Take',
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
                  ListItems(d: d.overview),
                  // Diagnosis tab content
                  ListItems(d: d.actions),
                  // Causes tab content
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
