import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/colors.dart';
import 'detail_bar.dart';

class AddShopScreen extends StatefulWidget {
  @override
  _AddShopScreenState createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _latitude = TextEditingController();
  final _longitude = TextEditingController();
  final _description = TextEditingController();
  File? imageFile;
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  final _picker = ImagePicker(); // ImagePicker instance to use the camera
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  DetailBar(
        title: 'Add shop',
        icon: const FaIcon(Icons.arrow_back),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _name,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextFormField(
                controller: _phone,
                decoration: InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                controller: _address,
                decoration: InputDecoration(labelText: "Address"),
              ),
              TextFormField(
                controller: _longitude,
                decoration: InputDecoration(labelText: "Longitude"),
              ),
              TextFormField(
                controller: _latitude,
                decoration: InputDecoration(labelText: "Latitude"),
              ),
              TextFormField(
                controller: _description,
                decoration: InputDecoration(labelText: "description"),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Logo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (imageFile != null)
                    Image.file(
                      File(imageFile!.path!),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UtilColors.pColor,
                        foregroundColor: UtilColors.tColor,
                      ),
                      icon: Icon(
                        Icons.photo_library,
                        color: UtilColors.tColor,
                      ),
                      label: Text("Gallery"),
                      onPressed: () {
                        select();
                      }),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UtilColors.pColor,
                        foregroundColor: UtilColors.tColor,
                      ),
                      icon: Icon(
                        Icons.camera_alt,
                        color: UtilColors.tColor,
                      ),
                      label: Text("Camera"),
                      onPressed: () {
                        takePhoto();
                      }),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: UtilColors.pColor,
                  foregroundColor: UtilColors.tColor,
                ),
                onPressed: () {
                  upload();
                },
                child: Text("Add Shop"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future select() async {
    final image = await FilePicker.platform.pickFiles();

    setState(() {
      pickedFile = image?.files.first;
    });
  }

  Future takePhoto() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path); // Store the captured image
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Picture cancelled")),
      );
    }
  }

  void upload() async {
    if (pickedFile == null && imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select or take a photo first")),
      );
      return;
    }
    File? file;
    String? fileName;
    if (imageFile != null) {
      file = imageFile;
      fileName = 'camera_${DateTime.now().millisecondsSinceEpoch}.jpg';
    } else {
      file = File(pickedFile!.path!);
      fileName = pickedFile!.name;
    }

    final path = 'files/$fileName';
    //final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file!);
    final snapshot = await uploadTask!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('shops').doc();
    String shopId = docRef.id;
    FirebaseFirestore.instance.collection('shops').doc(shopId).set({
      'name': _name.text,
      'phone': int.tryParse(_phone.text),
      'address': _address.text,
      'imageUrl': downloadUrl,
      'latitude': int.tryParse(_latitude.text),
      'longitude': int.tryParse(_longitude.text),
      'description': _description.text,
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Shop Added Successfully!")),
    );
  }
}
