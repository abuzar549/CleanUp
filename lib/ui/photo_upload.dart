import 'package:cleanup/utils/toast.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PhotoUploadScreen extends StatefulWidget {
  const PhotoUploadScreen({super.key});

  @override
  State<PhotoUploadScreen> createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  bool showSpinner = false;
  bool status = false;
  File? image;
  final imagepicker = ImagePicker();

  Future getimage() async {
    final pickedfile = await imagepicker.pickImage(source: ImageSource.camera);

    if (pickedfile != null) {
      image = File(pickedfile.path);
      setState(() {});
    } else {
      Utils().toastMessage('No Image Picked');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');

    var req = new http.MultipartRequest('POST', uri);
    req.fields['title'] = "New title";

    var multiport = new http.MultipartFile('image', stream, length);

    req.files.add(multiport);

    var response = await req.send();

    if (response.statusCode == 200) {
      Utils().toastMessage('Image Uploaded');

      setState(() {
        showSpinner = false;
        status = true;
      });
    } else {
      Utils().toastMessage('Error');
      setState(() {
        showSpinner = false;
        status = false;
      });
    }
  }

  bool statusreturn() {
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
          child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.all(25),
                child: image == null
                    ? InkWell(
                        onTap: () {
                          getimage();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              'Click here to capture image',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        child: Image.file(
                          File(image!.path).absolute,
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
                      )),
            InkWell(
              onTap: () {
                uploadImage();
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Expanded(
                  child: Container(
                    child: Center(
                      child: Text(
                        'Upload',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
