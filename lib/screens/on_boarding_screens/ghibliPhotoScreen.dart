import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../models/profile_singlaton.dart';
import 'selectPromptScreen.dart';

void main() {
  runApp(MaterialApp(home: GhibliPhotoScreen()));
}

class GhibliPhotoScreen extends StatefulWidget {
  @override
  _GhibliPhotoScreenState createState() => _GhibliPhotoScreenState();
}

class _GhibliPhotoScreenState extends State<GhibliPhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Upload photos'),
              onTap: () => _getImage(ImageSource.gallery),
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take photo'),
              onTap: () => _getImage(ImageSource.camera),
            ),
            ListTile(
              title: Center(child: Text('Cancel')),
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    Navigator.pop(context);

    final status = source == ImageSource.camera
        ? await Permission.camera.request()
        : await Permission.photos.request();

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Permission denied')),
      );
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
        ProfileSingleton.instance.profileImages.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
      ProfileSingleton.instance.profileImages.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final canContinue = _selectedImages.length >= 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Share your Ghibli-style photo'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: 0.3,
              backgroundColor: Colors.grey[200],
              color: Colors.purple,
            ),
            SizedBox(height: 20),
            Text(
              'Share your Ghibli-style photo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "Looks fade, personality stays. That’s why we match by story, not surface. Upload your Ghibli self to spark something real.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  if (index < _selectedImages.length) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _selectedImages[index],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.black54,
                              child: Icon(Icons.close, color: Colors.white, size: 14),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      onTap: _pickImage,
                      child: DottedBorderBox(),
                    );
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Feel first blur"),
                Spacer(),
                Switch(value: true, onChanged: (_) {}),
              ],
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: canContinue
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SelectPromptScreen()),
                );
              }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: canContinue ? Colors.purple : Colors.grey[300],
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 48),
              ),
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedBorderBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Icon(Icons.add, color: Colors.purple),
      ),
    );
  }
}
