import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../cache/cache_helper.dart';
import '../core/api/api_consumer.dart';
import '../core/api/end_ponits.dart';
import '../core/errors/exceptions.dart';
import '../models/forcasting_model.dart';
import '../models/login_model.dart';

class ForecastRepository{
  final ApiConsumer api;

  ForecastRepository({required this.api});

  Future<Either<String, ForecastModel>> forecast({
    required DateTime? time,
    required DateTime? date,
    required int roadId,
  }) async {
    try {
      final path = 'http://127.0.0.1:5000/predict/$date/$time';
      final response = await api.post(path);
      // final response = await api.post(
      //   EndPoint.forecast,
      //   data: {
      //     ApiKey.roadId: roadId,
      //     ApiKey.date: date,
      //     ApiKey.time:time,
      //   },
      // );
      final forecast = ForecastModel.fromJson(response);
      // final decodedToken = JwtDecoder.decode(forecast.token);
      // CacheHelper().saveData(key: ApiKey.token, value: user.token);
      // CacheHelper().saveData(key: ApiKey.id, value: decodedToken[ApiKey.id]);
      return Right(forecast);
    } on ServerException catch (e) {
      return Left(e.errModel.message);
    }
  }
}