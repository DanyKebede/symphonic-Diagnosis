import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../service/symptom.dart';

class SearchSymptoms extends StatefulWidget {
  static const String routeName = '/searchsymptom';

  const SearchSymptoms({super.key});

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const SearchSymptoms(),
    );
  }

  @override
  State<SearchSymptoms> createState() => _SearchSymptomsState();
}

class _SearchSymptomsState extends State<SearchSymptoms> {
  List sym = [];

  search(val, context) {
    setState(() {
      if (val == '') {
        sym.clear();
      } else {
        List sympdata =
            Provider.of<SymptomProvider>(context, listen: false).sympdata;
        sym = sympdata
            .where(
                (element) => element.toLowerCase().contains(val.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Search",
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
              onChanged: (value) => search(value, context),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(13, 133, 72, 1),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Ex. Headache",
                hintStyle: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 15,
                    color: Color.fromRGBO(201, 198, 198, 1)),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sym.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Provider.of<SymptomProvider>(context, listen: false)
                          .addtoSelected(sym[index]);
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(13, 133, 72, 1),
                          )),
                      child: Text(
                        sym[index],
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
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
    );
  }
}
