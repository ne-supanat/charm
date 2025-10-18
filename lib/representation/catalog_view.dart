import 'package:charm/representation/signin_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/model/omamori_model.dart';
import '../widgets/app_text_button.dart';
import '../widgets/base_scaffold.dart';
import 'catalog_bloc.dart';
import 'customisation_view.dart';
import 'inspect_view.dart';
import 'resource_bloc.dart';
import 'util.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<CatalogBloc>().loadCatalog();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Catalog',
      actions: [
        AppTextButton(
          onPressed: () async {
            await context.read<CatalogBloc>().addNewOmamori();
          },
          text: "Add",
        ),
        SizedBox(width: 8),
        AppTextButton(
          onPressed: () async {
            context.read<CatalogBloc>().logout();
            replaceView(context, SigninView());
          },
          text: "Log Out",
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CatalogBloc, CatalogState>(
              buildWhen: (previous, current) => previous.catalog != current.catalog,
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.catalog.length,
                  itemBuilder: (context, index) =>
                      buildItemTile(context, state.catalog.values.toList()[index]),
                );
              },
            ),
          ),

          BlocBuilder<CatalogBloc, CatalogState>(
            buildWhen: (previous, current) => previous.selectedPreset != current.selectedPreset,
            builder: (context, state) {
              if (state.selectedPreset != -1) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Color(0xFFD9D9D9))),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          context.read<CatalogBloc>().deleteSelectedOmamori();
                        },
                        child: Text("Delete"),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          final state = context.read<CatalogBloc>().state;
                          pushView(
                            context,
                            CustomisationView(omamoriModel: state.catalog[state.selectedPreset]!),
                          );
                        },
                        child: Text("Edit"),
                      ),
                      FilledButton(
                        onPressed: () {
                          pushView(
                            context,
                            InspectView(omamoriModel: state.catalog[state.selectedPreset]!),
                          );
                        },
                        child: Text("View"),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget buildItemTile(BuildContext context, OmamoriModel omamori) {
    final bloc = context.read<ResourceBloc>();

    final items = [];
    if (omamori.itemPrimaryId != null && bloc.getItemById(omamori.itemPrimaryId!) != null) {
      items.add(bloc.getItemById(omamori.itemPrimaryId!)!.name);
    }
    if (omamori.itemSecondaryId1 != null && bloc.getItemById(omamori.itemSecondaryId1!) != null) {
      items.add(bloc.getItemById(omamori.itemSecondaryId1!)?.name);
    }
    if (omamori.itemSecondaryId2 != null && bloc.getItemById(omamori.itemSecondaryId2!) != null) {
      items.add(bloc.getItemById(omamori.itemSecondaryId2!)?.name);
    }

    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        final isSelected = state.selectedPreset == omamori.id;

        return ListTile(
          onTap: () {
            context.read<CatalogBloc>().select(omamori.id);
          },
          leading: AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                border: isSelected
                    ? Border.all(color: Colors.blueGrey.shade900, width: 2)
                    : Border.all(color: Colors.blueGrey, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          title: Text(
            omamori.title,
            style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
          ),
          subtitle: Text(items.join(" • ")),
        );
      },
    );
  }
}
