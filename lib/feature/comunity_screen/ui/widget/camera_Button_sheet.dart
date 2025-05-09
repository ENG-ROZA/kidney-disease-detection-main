import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraModelBottonSheet extends StatefulWidget {
  const CameraModelBottonSheet({
    super.key,
    required this.onImagePicked,
  });
  final Function(File) onImagePicked;

  @override
  State<CameraModelBottonSheet> createState() => _CameraModelBottonSheetState();
}

class _CameraModelBottonSheetState extends State<CameraModelBottonSheet> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFromCamera() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      widget.onImagePicked(File(pickedImage.path));
      Navigator.pop(context);
    }
  }

  Future<void> _pickFromGallery() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      widget.onImagePicked(File(pickedImage.path));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(20),
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose..',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Take a photo'),
                    onTap: _pickFromCamera,
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_library, color: Colors.grey),
                    title: Text('Add from gallery'),
                    onTap: _pickFromGallery,
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Icon(Icons.camera_alt_outlined),
    );
  }
}
