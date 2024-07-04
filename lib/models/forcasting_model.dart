import '../core/api/end_ponits.dart';

class ForecastModel {
  final double accuracy;
  final List<List<double>> carCountUnscaled;
  final String classificationOfTrafficSituationOnSpecificDate;
  final List<TrafficSummary> summary;

  ForecastModel({
    required this.accuracy,
    required this.carCountUnscaled,
    required this.classificationOfTrafficSituationOnSpecificDate,
    required this.summary,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> jsonData) {
    return ForecastModel(
      accuracy: jsonData[ApiKey.accuracy],
      carCountUnscaled: List<List<double>>.from(jsonData[ApiKey.carCountUnscaled].map((x) => List<double>.from(x.map((y) => y.toDouble())))),
      classificationOfTrafficSituationOnSpecificDate: jsonData[ApiKey.classificationOfTrafficSituationOnSpecificDate],
      summary: List<TrafficSummary>.from(jsonData[ApiKey.summary].map((x) => TrafficSummary.fromJson(x))),
    );
  }
}

class TrafficSummary {
  final String date;
  final double vehicles;

  TrafficSummary({
    required this.date,
    required this.vehicles,
  });

  factory TrafficSummary.fromJson(Map<String, dynamic> jsonData) {
    return TrafficSummary(
      date: jsonData[ApiKey.date],
      vehicles: jsonData[ApiKey.vehicles].toDouble(),
    );
  }
}
