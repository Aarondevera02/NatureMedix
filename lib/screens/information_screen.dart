import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  final String title;
  final String description;
  final String imageUrl;

  const InformationScreen({
    required this.title,
    required this.description,
    required this.imageUrl,
    super.key,
  });

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(widget.imageUrl),
            const SizedBox(height: 16.0),
            Text(widget.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            Text(widget.description),
          ],
        ),
      ),
    );
  }
}
