import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/forecast_repository.dart';
import 'forecast_state.dart';
import 'package:flutter/material.dart';
class ForecastCubit extends Cubit<ForecastState> {
  final ForecastRepository forecastRepository;
  int roadId = 0;
  DateTime? date ;
  DateTime? time ;

  ForecastCubit(this.forecastRepository) : super(ForecastInitial());

  forecast() async {
    emit(ForecastLoading());
    final response = await forecastRepository.forecast(
      roadId: roadId,
      time: time,
      date: date,
    );
    response.fold(
          (errMessage) => emit(ForecastFailure(errMessage: errMessage)),
          (forecastModel) => emit(ForecastSuccess(forecastModel)),
    );
  }
}
