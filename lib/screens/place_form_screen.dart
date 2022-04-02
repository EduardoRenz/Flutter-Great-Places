import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({Key? key}) : super(key: key);

  @override
  State<PlaceFormScreen> createState() => _PlaceFormSCreenState();
}

class _PlaceFormSCreenState extends State<PlaceFormScreen> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File selectedImage) {
    setState(() {
      _pickedImage = selectedImage;
    });
  }

  void _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  bool _isValidForm() {
    return _titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if (!_isValidForm()) {
      return;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titleController.text, _pickedImage!, _pickedPosition!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new place'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (value) {
                          setState(() {});
                        },
                        controller: _titleController,
                        decoration: const InputDecoration(labelText: 'Title'),
                      ),
                      const SizedBox(height: 10),
                      ImageInput(_selectImage),
                      const SizedBox(height: 10),
                      LocationInput(_selectPosition)
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: _isValidForm() ? _submitForm : null,
              icon: const Icon(Icons.add),
              label: const Text('Add place'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                elevation: 0,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            )
          ],
        ));
  }
}
