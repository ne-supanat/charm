import 'catalog_view.dart';
import 'resource_bloc.dart';
import 'util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResourceBloc, ResourceState>(
      listener: (context, state) {
        if (state.loaded) {
          replaceView(context, CatalogView());
        }
      },
      builder: (context, state) {
        return Scaffold(body: Center(child: Text('Loading Resources')));
      },
    );
  }
}
