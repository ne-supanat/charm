import 'package:charm/data/model/omamori_model.dart';
import 'package:charm/representation/customisation_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/client.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/preset_repository.dart';
import 'data/repository/resource_repository.dart';
import 'global/sharedpref.dart';
import 'global/theme.dart';
import 'representation/catalog_bloc.dart';
import 'representation/landing_view.dart';
import 'representation/resource_bloc.dart';

void main() async {
  await setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ResourceBloc>(create: (BuildContext context) => ResourceBloc()),
        BlocProvider<CatalogBloc>(create: (BuildContext context) => CatalogBloc()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> setup() async {
  final sharepref = Sharedpref();
  await sharepref.setup();
  GetIt.I.registerSingleton<Sharedpref>(sharepref);
  GetIt.I.registerSingleton<Client>(Client(dio: Dio())..configureDio());

  GetIt.I.registerSingleton<AuthRepository>(AuthRepository());
  GetIt.I.registerSingleton<ResourceRepository>(ResourceRepository());
  GetIt.I.registerSingleton<PresetRepository>(PresetRepository());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: LandingView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
