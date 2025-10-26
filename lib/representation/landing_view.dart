import 'package:charm/global/colors.dart';
import 'package:charm/global/sharedpref.dart';
import 'package:charm/representation/catalog_view.dart';
import 'package:charm/representation/new_main_view.dart';
import 'package:charm/widgets/app_text_button.dart';
import 'package:charm/widgets/charm.dart';
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
          replaceView(context, NewMainView());
          // if (GetIt.I<Sharedpref>().getAuthToken() != null) {
          //   replaceView(context, CatalogView());
          // } else {
          //   replaceView(context, SigninView());
          // }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(child: Column(children: [Text('Loading Resources'), Charm()])),
        );
      },
    );
  }
}
