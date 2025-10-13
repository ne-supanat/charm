import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/landing_view.dart';
import 'features/resource_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider<ResourceBloc>(create: (BuildContext context) => ResourceBloc())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // TODO: theme
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF6A6A6A)),
      ),
      home: LandingView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
