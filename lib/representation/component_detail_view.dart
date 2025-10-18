import 'package:flutter/material.dart';

import '../data/model/item_model.dart';
import '../widgets/base_scaffold.dart';

class ComponentDetailView extends StatelessWidget {
  const ComponentDetailView({super.key, required this.itemModel});

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: itemModel.name,
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
                border: Border.all(color: Color(0xFF98978F)),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Image.asset(
                itemModel.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/dark_noise.jpg", fit: BoxFit.contain),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF98978F)),
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Name:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(itemModel.name, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Text('Description:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(itemModel.description, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 16),
                  Text('Tag', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(itemModel.tags.join(" • "), style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
