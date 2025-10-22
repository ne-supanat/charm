import 'package:charm/global/colors.dart';
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
          text: "New",
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
                return ListView.separated(
                  itemCount: state.catalog.length,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) =>
                      buildItemTile(context, state.catalog.values.toList()[index]),
                  separatorBuilder: (context, index) => SizedBox(height: 8),
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
                        child: Text("Customisation"),
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
    if (omamori.item1Id != null && bloc.getItemById(omamori.item1Id!) != null) {
      items.add(bloc.getItemById(omamori.item1Id!)!.name);
    }
    if (omamori.item2Id != null && bloc.getItemById(omamori.item2Id!) != null) {
      items.add(bloc.getItemById(omamori.item2Id!)?.name);
    }
    if (omamori.item3Id != null && bloc.getItemById(omamori.item3Id!) != null) {
      items.add(bloc.getItemById(omamori.item3Id!)?.name);
    }

    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        final isSelected = state.selectedPreset == omamori.id;

        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            context.read<CatalogBloc>().select(omamori.id);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isSelected ? colorPrimary : Colors.transparent, width: 2),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorPrimary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        omamori.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      Text(items.join(" • "), style: Theme.of(context).textTheme.bodyMedium),
                    ],
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
