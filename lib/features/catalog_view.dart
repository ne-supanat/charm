import 'package:charm/widgets/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/omamori_model.dart';
import '../widgets/base_scaffold.dart';
import 'catalog_bloc.dart';
import 'customisation_view.dart';
import 'inspect_view.dart';
import 'resource_bloc.dart';
import 'util.dart';

class CatalogView extends StatelessWidget {
  const CatalogView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatalogBloc(CatalogState())..loadCatalog(),
      child: Builder(
        builder: (context) {
          return buildContent(context);
        },
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    return BaseScaffold(
      title: 'Catalog',
      actions: [
        AppTextButton(
          onPressed: () {
            context.read<CatalogBloc>().addNewOmamori();
          },
          text: "Add",
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CatalogBloc, CatalogState>(
              buildWhen: (previous, current) => previous.catalog.length != current.catalog.length,
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
              if (state.selectedPreset.isNotEmpty) {
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
                            CustomisationView(omamoriModel: state.catalog[state.selectedPreset]),
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

    final itemPrimary = bloc.getItemById(omamori.itemPrimaryId);
    final itemSecondary1 = bloc.getItemById(omamori.itemSecondaryId1);
    final itemSecondary2 = bloc.getItemById(omamori.itemSecondaryId2);

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
          subtitle: Text(
            [itemPrimary?.name, itemSecondary1?.name, itemSecondary2?.name].join(" • "),
          ),
        );
      },
    );
  }
}
