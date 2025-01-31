import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Shop")),
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
                  if (pickedFile != null)
                    Image.file(
                      File(pickedFile!.path!),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),

                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UtilColors.pColor,
                      foregroundColor: UtilColors.tColor,
                    ),
                    icon: Icon(Icons.photo_library,
                      color: UtilColors.tColor,),
                    label: Text("Gallery"),
                    onPressed: () {
                      select();
                    }
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: UtilColors.pColor,
                        foregroundColor: UtilColors.tColor,
                      ),
                      icon: Icon(Icons.download,
                        color: UtilColors.tColor,),
                      label: Text("Upload"),
                      onPressed: () {

                      }
                  ),
                ],
              ),

              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: UtilColors.pColor,
                  foregroundColor: UtilColors.tColor,
                ),
                onPressed: (){
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

  void upload()async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('shops').doc();
    String shopId = docRef.id;
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete((){

    });
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    FirebaseFirestore.instance.collection('shops').doc(shopId).set({
      'name': _name.text,
      'phone': int.tryParse(_phone.text),
      'address': _address.text,
      'imageUrl': downloadUrl,
      'latitude': int.tryParse(_latitude.text),
      'longitude': int.tryParse(_longitude.text),
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Shop Added Successfully!")),
    );
  }
}
