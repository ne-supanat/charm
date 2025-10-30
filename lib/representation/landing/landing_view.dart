import 'package:audioplayers/audioplayers.dart';
import 'package:charm/global/colors.dart';
import 'package:charm/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../global/sharedpref.dart';
import '../../widgets/app_icon_button.dart';
import '../display_new/display_new_view.dart';
import '../resource_bloc.dart';
import '../util.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  late double volume;

  @override
  void initState() {
    super.initState();
    context.read<ResourceBloc>().loadData();

    print(GetIt.I<Sharedpref>().getAuthToken());

    volume = GetIt.I<AudioPlayer>().volume;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResourceBloc, ResourceState>(
      listener: (context, state) {
        if (state.loaded) {
          replaceView(context, DisplayNewView());
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text('Loading Resources')],
            ),
          ),
        );
      },
    );
  }
}
