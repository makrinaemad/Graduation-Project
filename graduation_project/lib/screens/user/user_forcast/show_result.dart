import 'package:flutter/material.dart';
import 'package:graduation_project/shared/remote/api_manager.dart';
import '../../../models/ForcastingDataModel.dart';
import '../../../models/ForcastingModel.dart';
import '../../../shared/constant/constants.dart';


class ShowForecastingResultScreen extends StatelessWidget {

  //final ApiService apiService = ApiService(baseUrl: 'example.com');
  final RoadData roadData;
  // = RoadData(
  //   roadId: 'R123',
  //   date: '2024-07-06',
  //   time: '08:00',
  // );
  final String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Im1haG1vdWQuc2FhZDM4OTVAZ21haWwuY29tIiwiaWQiOjY1MzkwOCwiYWRtaW4iOnRydWUsImlhdCI6MTcxNzg0ODIxOCwiZXhwIjoxNzIwNDQwMjE4fQ.U2Z1Bs6ekvr1pWBnBB8CrUki_vJQDrLq8ftgQ8UHTzA';

   ShowForecastingResultScreen({super.key, required this.roadData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Traffic Detector', style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        backgroundColor: Constants.primaryColor,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: const Icon(Icons.menu),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ),
        ],
        leading: Container(
          margin: const EdgeInsets.all(8),
          width: 32,
          height: 32,
          child: const Image(image: AssetImage("assets/images/profile.png")),
        ),
      ),
      body: FutureBuilder<VehicleForecast>(
        future: ApiManager().sendForecastingData(roadData),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to fetch forecast data: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final forecastModel = snapshot.data!;
            return ListView(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Accuracy: ${forecastModel.accuracy}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xff3FBEDA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Classification: ${forecastModel.classificationOfTraffic}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Text(
                        'Previous days:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: forecastModel.summary.length,
                        itemBuilder: (context, index) {
                          final summary = forecastModel.summary[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                'Date: ${summary.date}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                'Vehicles: ${summary.vehicles}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Please initiate a forecast request.'));
          }
        },
      ),
    );
  }
}
