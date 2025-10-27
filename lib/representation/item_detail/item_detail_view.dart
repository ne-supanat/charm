import 'package:charm/global/colors.dart';
import 'package:flutter/material.dart';

import '../../data/model/item_model.dart';
import '../../widgets/base_scaffold.dart';

class ItemDetailView extends StatelessWidget {
  const ItemDetailView({super.key, required this.itemModel});

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: colorSecondary),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                itemModel.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image_outlined, color: colorPrimary),
                    Text(
                      'Image Not Found',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colorPrimary),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: colorSecondary),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Name:', style: Theme.of(context).textTheme.titleMedium),
                  Text(itemModel.name, style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 16),
                  Text('Description:', style: Theme.of(context).textTheme.titleMedium),
                  Text(itemModel.description, style: Theme.of(context).textTheme.bodyMedium),
                  SizedBox(height: 16),
                  Text('Tag', style: Theme.of(context).textTheme.titleMedium),
                  Text(itemModel.tags.join(" • "), style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
