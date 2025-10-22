import 'package:charm/global/colors.dart';
import 'package:charm/global/sharedpref.dart';
import 'package:charm/representation/catalog_view.dart';
import 'package:charm/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'resource_bloc.dart';
import 'signin_view.dart';
import 'util.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  void initState() {
    super.initState();
    context.read<ResourceBloc>().loadData();

    print(GetIt.I<Sharedpref>().getAuthToken());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResourceBloc, ResourceState>(
      listener: (context, state) {
        if (state.loaded) {
          if (GetIt.I<Sharedpref>().getAuthToken() != null) {
            replaceView(context, CatalogView());
          } else {
            replaceView(context, SigninView());
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Column(
              children: [
                Text('Loading Resources'),
                AppTextButton(onPressed: () async {}, text: "Add"),
                OutlinedButton(onPressed: null, child: Text("Delete")),
                FilledButton(onPressed: null, child: Text("Confirm")),
                OutlinedButton(onPressed: () {}, child: Text("Delete")),
                FilledButton(onPressed: () {}, child: Text("Confirm")),
                Container(width: 100, height: 20, color: colorPrimary),
                RotatedBox(
                  quarterTurns: 0, // Rotates 90 degrees clockwise
                  child: const Text(
                    'Rotated Text',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RotatedBox(
                      quarterTurns: 3, // Rotates 90 degrees clockwise
                      child: const Text(
                        'Rotated Text',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(child: Image.network("https://picsum.photos/200/300")),
                    RotatedBox(
                      quarterTurns: 1, // Rotates 90 degrees clockwise
                      child: const Text(
                        'Rotated Text',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                RotatedBox(
                  quarterTurns: 2, // Rotates 90 degrees clockwise
                  child: const Text(
                    'Rotated Text',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
