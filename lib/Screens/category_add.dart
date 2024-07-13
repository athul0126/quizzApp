import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quizapp/Constants/sized_boxes.dart';

class CategoryAddScreen extends StatelessWidget {
  CategoryAddScreen({super.key});
  final TextEditingController categoryName = TextEditingController();
  final ValueNotifier<bool> imageNotifier = ValueNotifier(false);
  final ValueNotifier<bool> uploading = ValueNotifier(false);
  File imageSelected = File('');
  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            h10,
            const Text(
              "Category Details",
              style: TextStyle(fontSize: 20),
            ),
            h10,
            TextFormField(
              controller: categoryName,
              decoration: const InputDecoration(
                  hintText: "Category Name", border: OutlineInputBorder()),
            ),
            h10,
            ElevatedButton.icon(
                onPressed: () async {
                  try {
                    final imagePicked = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (imagePicked != null) {
                      print("Path ${imageSelected.path}");
                      imageSelected = File(imagePicked.path);
                      imageNotifier.value = true;
                      uploading.value = true;
                      try {
                        Reference storageReference = FirebaseStorage.instance
                            .ref()
                            .child('images/${DateTime.now().toString()}');
                        UploadTask uploadTask =
                            storageReference.putFile(imageSelected);
                        await uploadTask.whenComplete(() {
                          uploading.value = false;
                          print("uploaded");
                        });

                        // Get download URL
                        String downloadURL =
                            await storageReference.getDownloadURL();

                        imageUrl = downloadURL;

                        print('Download URL: $downloadURL');
                      } catch (e) {
                        print("firebase upload Exception:${e}");
                      }
                    }
                  } catch (e) {
                    print("image pick Exception:${e}");
                  }
                },
                icon: const Icon(Icons.image),
                label: const Text("Select Image")),
            h10,
            ValueListenableBuilder(
              valueListenable: imageNotifier,
              builder: (BuildContext context, value, Widget? child) {
                return imageNotifier.value
                    ? Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(File(imageSelected!.path)),
                                fit: BoxFit.contain)),
                      )
                    : const Text("image not selected");
              },
            ),
            h10,
            ValueListenableBuilder(
              valueListenable: uploading,
              builder: (BuildContext context, value, Widget? child) {
                return uploading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          FirebaseFirestore.instance
                              .collection("categories")
                              .add({
                            'category': categoryName.text,
                            'category_image': imageUrl,
                          });
                          categoryName.clear();
                          imageNotifier.value = false;
                        },
                        child: const Text("Submit"));
              },
            )
          ],
        ),
      )),
    );
  }
}
