import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../global/colors.dart';
import '../../resources/resources.dart';
import '../../widgets/floating_widget.dart';
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
    volume = GetIt.I<AudioPlayer>().volume;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceBloc, ResourceState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: colorBlack,
          body: Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Image.asset(
                  useWebLayout(context) ? Images.bgNightWeb : Images.bgNightMobile,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => SizedBox(),
                  color: colorBlack.withAlpha((255 * 0.1).toInt()),
                  colorBlendMode: BlendMode.overlay,
                ),
              ),
              Visibility(
                visible: state.loaded,
                child: GestureDetector(
                  onTap: () {
                    if (state.loaded) {
                      GetIt.I<AudioPlayer>().play(
                        AssetSource('musics/${state.musics.values.first.audioUrl}'),
                      );
                      replaceView(context, DisplayNewView());
                    }
                  },
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingWidget(
                          child: Text(
                            '- ENTER -',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(color: colorWhite),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
