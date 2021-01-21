import 'dart:io';
import 'package:image_picker/image_picker.dart';

Future<File> pickImage(bool isCamera)async{
  ImagePicker _picker = ImagePicker();
  ImageSource _source = isCamera?ImageSource.camera:ImageSource.gallery;
  PickedFile res = await _picker.getImage(source: _source);
  return File(res.path);
}