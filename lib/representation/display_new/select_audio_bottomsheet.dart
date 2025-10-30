import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../data/model/pattern_model.dart';
import '../../global/colors.dart';
import '../../resources/resources.dart';
import '../../widgets/app_icon_button.dart';
import '../resource_bloc.dart';

class SelectAudioBottomsheet extends StatefulWidget {
  const SelectAudioBottomsheet({super.key, this.selectedId, required this.onChanged});

  final int? selectedId;
  final Function(int id) onChanged;

  @override
  State<SelectAudioBottomsheet> createState() => _SelectAudioBottomsheetState();
}

class _SelectAudioBottomsheetState extends State<SelectAudioBottomsheet> {
  late List<MusicsModel> musics;
  late int selectedId;
  int? listeningId;

  final playerLocal = AudioPlayer();
  late double volume;

  @override
  void initState() {
    super.initState();
    musics = context.read<ResourceBloc>().state.musics.values.toList();
    selectedId = widget.selectedId ?? musics.first.id;

    volume = GetIt.I.get<AudioPlayer>().volume;
  }

  @override
  void dispose() {
    playerLocal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        border: Border.all(color: colorPrimary),
        color: colorWhite,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Volume", style: Theme.of(context).textTheme.titleMedium),
              Expanded(
                child: Slider(
                  activeColor: colorSecondary,
                  value: volume,
                  onChanged: (value) {
                    setState(() {
                      volume = value;
                    });
                    GetIt.I.get<AudioPlayer>().setVolume(value);
                    playerLocal.setVolume(value);
                  },
                ),
              ),
            ],
          ),
          Divider(height: 0),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              itemBuilder: (context, index) {
                final music = musics[index];
                final isSelected = selectedId == music.id;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  spacing: 16,
                  children: [
                    AppIconButton(
                      icon: ImageIcon(
                        AssetImage(listeningId == music.id ? ImageIcons.music : ImageIcons.play),
                      ),
                      onPressed: () async {
                        setState(() {
                          listeningId = music.id;
                        });

                        final player = GetIt.I.get<AudioPlayer>();
                        await player.pause();

                        await playerLocal.play(AssetSource('musics/${music.audioUrl}'));
                      },
                    ),
                    Expanded(
                      child: Text(
                        music.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: OutlinedButton(
                        onPressed: isSelected
                            ? null
                            : () async {
                                playerLocal.stop();
                                setState(() {
                                  listeningId = null;
                                  selectedId = music.id;
                                });

                                widget.onChanged(music.id);
                              },
                        child: Text(isSelected ? 'Selected' : 'Select'),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: musics.length,
            ),
          ),
        ],
      ),
    );
  }
}
