import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/diseasedescriptionmodel.dart';
import '../../models/predictedmodel.dart';
import '../../service/diseasedescription.dart';
import '../../service/doctor.dart';

class ShowDetailPage extends StatefulWidget {
  static const String routeName = '/showdetail';
  final PredictedModel predicted;
  const ShowDetailPage({super.key, required this.predicted});

  static Route route(PredictedModel p) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => ShowDetailPage(
        predicted: p,
      ),
    );
  }

  @override
  State<ShowDetailPage> createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoctorProvider>(context, listen: false).loadDoctors();
    Provider.of<DiseaseDescriptionProvider>(context, listen: false)
        .loadDiseaseDescription();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<dynamic> disease = [];
    // Filter Do
    List<dynamic> data = Provider.of<DoctorProvider>(context).doctorData;

    List<dynamic> d = data
        .where(
          (e) => e.speciality.toLowerCase().contains(
                widget.predicted.speciality.toLowerCase(),
              ),
        )
        .toList();
    // Filter Description
    List<dynamic> diseasedescription =
        Provider.of<DiseaseDescriptionProvider>(context).diseaseDescription;
    if (widget.predicted.confidenceScore != 0) {
      disease = diseasedescription
          .where((e) => e.name
              .toLowerCase()
              .contains(widget.predicted.predictedDisease.toLowerCase()))
          .toList();
    } else {
      disease = const [DiseaseDescriptionModel(name: 'none', description: '')];
    }

    return Scaffold(
      backgroundColor: Colors.grey[80],
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Detail Page",
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 14, right: 14, top: 15),
              padding: const EdgeInsets.only(
                  right: 11, left: 11, top: 10, bottom: 30),
              width: size.width,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(13, 133, 72, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    disease[0].name,
                    style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    disease[0].description,
                    style: const TextStyle(
                        fontFamily: 'Inter', fontSize: 15, color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
              padding: const EdgeInsets.only(top: 10),
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
                      'Recommended Doctors',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const Divider(
                    height: 4,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: size.height * 0.35,
                    child: ListView.builder(
                      itemCount: d.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.only(
                            top: 7,
                            left: 2,
                            right: 2,
                          ),
                          color: const Color.fromRGBO(13, 133, 72, 1),
                          child: ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2,
                                    color: const Color.fromARGB(
                                        255, 65, 214, 140)),
                                shape: BoxShape.circle,
                              ),
                              width: 50,
                              height: 50,
                              child: CircleAvatar(
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ClipOval(
                                    child: d[index].imgurl != ''
                                        ? Image.network(
                                            d[index].imgurl,
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
                            title: Text(
                              '${d[index].title.toUpperCase()}. ${d[index].name}',
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              d[index].speciality,
                              style: const TextStyle(
                                color: Color.fromRGBO(201, 197, 197, 1),
                                fontSize: 12,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                  '/doctor-page',
                                  arguments: d[index].id,
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 15),
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
