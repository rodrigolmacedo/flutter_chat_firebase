import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) onImagePick;

  const UserImagePicker({Key key, this.onImagePick}) : super(key: key);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final pickImage = await picker.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 150);

    setState(() {
      _pickedImageFile = File(pickImage.path);
    });

    widget.onImagePick(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile) : null,
        ),
        TextButton.icon(
            onPressed: _pickImage,
            icon: Icon(Icons.image),
            label: Text('Adicionar Imagem'))
      ],
    );
  }
}
