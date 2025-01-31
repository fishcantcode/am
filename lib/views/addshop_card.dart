import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../utils/colors.dart';

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

  final ImagePicker _picker = ImagePicker();

  Future<String> uploadImage(String path, XFile image) async {
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } catch (e){
      throw 'something went wrong';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Shop")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
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

              SizedBox(height: 20),

              // Image Picker
              _imageFile == null
                  ? Text("No image selected")
                  : Image.file(_imageFile!, height: 100, width: 100, fit: BoxFit.cover),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UtilColors.pColor,
                      foregroundColor: UtilColors.tColor,
                    ),
                    icon: Icon(Icons.camera_alt,
                    color: UtilColors.tColor,),
                    label: Text("Camera"),
                    onPressed: () => picker(ImageSource.camera),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UtilColors.pColor,
                      foregroundColor: UtilColors.tColor,
                    ),
                    icon: Icon(Icons.photo_library,
                      color: UtilColors.tColor,),
                    label: Text("Gallery"),
                    onPressed: () => picker(ImageSource.gallery),
                  ),
                ],
              ),

              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: UtilColors.pColor,
                  foregroundColor: UtilColors.tColor,
                ),
                onPressed: addShop,
                child: Text("Add Shop"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
