import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/src/ui/providers/great_places.dart';
import 'package:great_places/src/ui/widgets/image_input.dart';
import 'package:great_places/src/ui/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceForm extends StatefulWidget {
  const PlaceForm({super.key});

  @override
  State<PlaceForm> createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) {
    setState(() => _pickedImage = pickedImage);
  }

  void _selectPosition(LatLng pickedPosition) {
    setState(() => _pickedPosition = pickedPosition);
  }

  bool isValidForm() {
    return (_titleController.text.isNotEmpty &&
        _pickedImage != null &&
        _pickedPosition != null);
  }

  void _submitForm() {
    if (!isValidForm()) return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(
      _titleController.text,
      _pickedImage!,
      _pickedPosition!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Place'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      const SizedBox(height: 10),
                      ImageInput(onSelectImage: _selectImage),
                      const SizedBox(height: 10),
                      LocationInput(onSelectPosition: _selectPosition),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: isValidForm() ? _submitForm : null,
              icon: const Icon(Icons.add),
              label: const Text('Add'),
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.black,
                elevation: 0,
                shape: const LinearBorder(),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
