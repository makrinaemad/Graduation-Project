import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../constants.dart';
import '../cubit/forecast cubit/forecast_cubit.dart';
import '../cubit/forecast cubit/forecast_state.dart';

class ShowForecastingResultScreen extends StatelessWidget {
  ShowForecastingResultScreen({super.key});

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
          margin: const EdgeInsets.all(8), // Adjust margin as needed
          width: 32, // Set the desired width
          height: 32,
          child: const Image(image: AssetImage("assets/images/profile.png")),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<ForecastCubit, ForecastState>(
          builder: (context, state) {
            if (state is ForecastLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ForecastSuccess) {// Assuming you pass the data with the state
              return ListView(
                children: [
                  SingleChildScrollView(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Accuracy: ${state.forecastModel.accuracy}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Color(0xff3FBEDA),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Classification: ${state.forecastModel.classificationOfTrafficSituationOnSpecificDate}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          'Previous days:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.forecastModel.summary.length,
                          itemBuilder: (context, index) {
                            final summary = state.forecastModel.summary[index];
                            return Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(
                                  'Date: ${summary.date}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  'Vehicles: ${summary.vehicles}',
                                  style: TextStyle(color: Colors.white),
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
            } else if (state is ForecastFailure) {
              return Center(child: Text('Failed to fetch forecast data: ${state.errMessage}'));
            } else {
              return Center(child: Text('Please initiate a forecast request.'));
            }
          },
        ),
      ),
    );
  }
}
