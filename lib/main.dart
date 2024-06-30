import 'package:arrange_gp/cache/cache_helper.dart';
import 'package:arrange_gp/core/api/dio_consumer.dart';
import 'package:arrange_gp/repositories/user_repository.dart';
import 'package:arrange_gp/screens/forget%20_password_screen.dart';
import 'package:arrange_gp/screens/login_screen.dart';
import 'package:arrange_gp/screens/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/user_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(
    BlocProvider(
      create: (context) =>
          UserCubit(UserRepository(api: DioConsumer(dio: Dio()))),
      child: const TrafficDetectorApp(),
    ),
  );
}

class TrafficDetectorApp extends StatelessWidget {
  const TrafficDetectorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}