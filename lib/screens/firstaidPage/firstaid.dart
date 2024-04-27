import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../service/firstaid.dart';

class FirstAidPage extends StatefulWidget {
  const FirstAidPage({super.key});

  @override
  State<FirstAidPage> createState() => _FirstAidPageState();
}

class _FirstAidPageState extends State<FirstAidPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FirstAidProvider>(context, listen: false).loadFirstAid();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> d = Provider.of<FirstAidProvider>(context).searchResult;

    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "First Aid Information",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                onChanged: (value) =>
                    Provider.of<FirstAidProvider>(context, listen: false)
                        .search(value),
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(13, 133, 72, 1),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color.fromRGBO(198, 185, 185, 1),
                    size: 30,
                  ),
                  hintText: "Search for Aid Information",
                  hintStyle: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      color: Color.fromRGBO(198, 185, 185, 1)),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: d.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.only(
                        top: 7,
                      ),
                      color: const Color.fromRGBO(13, 133, 72, 1),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed('/firstaid-detail',
                              arguments: d[index]);
                        },
                        child: ListTile(
                          title: Text(
                            '${d[index].name.toUpperCase()}',
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
