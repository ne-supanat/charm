import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/client.dart';
import 'data/repository/resource_repository.dart';
import 'global/sharedpref.dart';
import 'global/theme.dart';
import 'representation/landing/landing_view.dart';
import 'representation/resource_bloc.dart';

void main() async {
  await setup();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider<ResourceBloc>(create: (BuildContext context) => ResourceBloc())],
      child: const MyApp(),
    ),
  );
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharepref = Sharedpref();
  await sharepref.setup();
  GetIt.I.registerSingleton<Sharedpref>(sharepref);
  GetIt.I.registerSingleton<Client>(Client(dio: Dio())..configureDio());

  final player = AudioPlayer();
  player.setVolume(0.5);
  await player.setReleaseMode(ReleaseMode.loop);
  GetIt.I.registerSingleton<AudioPlayer>(player);

  GetIt.I.registerSingleton<ResourceRepository>(ResourceRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charm',
      theme: theme,
      home: LandingView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
