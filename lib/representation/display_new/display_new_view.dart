import 'package:audioplayers/audioplayers.dart';

import 'select_audio_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/model/background_model.dart';
import '../../data/model/tags_constant.dart';
import '../../global/colors.dart';
import '../../resources/resources.dart';
import '../../widgets/app_icon_button.dart';
import '../../widgets/charm.dart';
import '../../widgets/orbiting_widget.dart';
import '../resource_bloc.dart';
import '../util.dart';
import 'display_new_bloc.dart';
import 'select_background_bottomsheet.dart';
import 'select_item_bottomsheet.dart';

class DisplayNewView extends StatelessWidget {
  const DisplayNewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DisplayNewBloc(DisplayNewState.init(context)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: colorBlack,
            body: BlocBuilder<DisplayNewBloc, DisplayNewState>(
              builder: (context, state) {
                BackgroundModel background = context.read<ResourceBloc>().getBackgroundById(
                  state.selectedBackgroundId,
                )!;
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (!state.displayedUI) {
                      context.read<DisplayNewBloc>().updateDisplayUI(true);
                    }
                  },
                  child: Stack(
                    alignment: AlignmentGeometry.center,
                    children: [
                      SizedBox(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: Image.asset(
                          "images/${useWebLayout(context) ? background.imageUrlWeb : background.imageUrlMobile}",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => SizedBox(),
                          color: colorBlack.withAlpha((255 * 0.1).toInt()),
                          colorBlendMode: BlendMode.overlay,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(48.0),
                        child: BlocBuilder<DisplayNewBloc, DisplayNewState>(
                          buildWhen: (previous, current) =>
                              previous.selectedItemId != current.selectedItemId,
                          builder: (context, state) {
                            return Charm(
                              item: context.read<ResourceBloc>().getItemById(state.selectedItemId)!,
                            );
                          },
                        ),
                      ),
                      Padding(padding: const EdgeInsets.all(16.0), child: OrbitingWidget()),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: BlocBuilder<DisplayNewBloc, DisplayNewState>(
                          buildWhen: (previous, current) =>
                              previous.displayedUI != current.displayedUI,
                          builder: (context, state) {
                            return Visibility(
                              visible: state.displayedUI,
                              child: AppIconButton(
                                onPressed: () {
                                  context.read<DisplayNewBloc>().updateDisplayUI(false);
                                },
                                icon: ImageIcon(AssetImage(ImageIcons.hidden)),
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: BlocBuilder<DisplayNewBloc, DisplayNewState>(
                          buildWhen: (previous, current) =>
                              previous.displayedUI != current.displayedUI,
                          builder: (context, state) {
                            return Visibility(
                              visible: state.displayedUI,
                              child: Row(
                                spacing: 8,
                                children: [
                                  AppIconButton(
                                    onPressed: () async {
                                      final player = GetIt.I.get<AudioPlayer>();

                                      await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: false,
                                        builder: (btContext) {
                                          return SelectAudioBottomsheet(
                                            selectedId: context
                                                .read<DisplayNewBloc>()
                                                .state
                                                .selectedMusicId,
                                            onChanged: (id) async {
                                              context.read<DisplayNewBloc>().updateSelectedMusic(
                                                id,
                                              );

                                              // Play new Music
                                              await player.stop();
                                              await player.play(
                                                AssetSource(
                                                  'musics/${context.read<ResourceBloc>().state.musics[id]!.audioUrl}',
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );

                                      if (player.state == PlayerState.paused) {
                                        // Resume Music
                                        await player.resume();
                                      }
                                    },
                                    icon: ImageIcon(AssetImage(ImageIcons.music)),
                                  ),
                                  AppIconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: false,
                                        builder: (btContext) {
                                          return SelectBackgroundBottomsheet(
                                            selectedId: context
                                                .read<DisplayNewBloc>()
                                                .state
                                                .selectedBackgroundId,
                                            onChanged: (id) {
                                              context
                                                  .read<DisplayNewBloc>()
                                                  .updateSelectedBackground(id);
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: ImageIcon(AssetImage(ImageIcons.image)),
                                  ),
                                  AppIconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (btContext) {
                                          final state = context.read<DisplayNewBloc>().state;
                                          return SelectItemBottomsheet(
                                            selectedId: state.selectedItemId,
                                            onChanged: (id) {
                                              context.read<DisplayNewBloc>().updateSelectedItem(id);
                                            },
                                            onUpdateFilterCategory: (TagCategory value) {
                                              context
                                                  .read<DisplayNewBloc>()
                                                  .updateSelectedTagCategory(value);
                                            },
                                            onUpdateFilterPower: (TagPower value) {
                                              context.read<DisplayNewBloc>().updateSelectedTagPower(
                                                value,
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: ImageIcon(AssetImage(ImageIcons.star)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
