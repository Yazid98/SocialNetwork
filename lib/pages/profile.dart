import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_projet_master1/chat/Chat_settings.dart';
import 'package:insta_projet_master1/chat/const.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? controllerNickname;
  TextEditingController? controllerAboutMe;

  SharedPreferences? prefs;

  String id = '';
  String nickname = '';
  String aboutMe = '';
  String photoUrl = '';

  bool isLoading = false;
  File? avatarImageFile;

  final FocusNode focusNodeNickname = FocusNode();
  final FocusNode focusNodeAboutMe = FocusNode();

  void readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs?.getString('id') ?? '';
    nickname = prefs?.getString('nickname') ?? '';
    aboutMe = prefs?.getString('aboutMe') ?? '';
    photoUrl = prefs?.getString('photoUrl') ?? '';

    controllerNickname = TextEditingController(text: nickname);
    controllerAboutMe = TextEditingController(text: aboutMe);

    // Force refresh input
    setState(() {});
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? pickedFile = await imagePicker.getImage(source: ImageSource.gallery).catchError((err) {
      Fluttertoast.showToast(msg: err.toString());
    });
    File? image;
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    if (image != null) {
      setState(() {
        avatarImageFile = image;
        isLoading = true;
      });
      uploadFile();
    }
  }

  Future uploadFile() async {
    String fileName = id;
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(avatarImageFile!);
    try {
      TaskSnapshot snapshot = await uploadTask;
      photoUrl = await snapshot.ref.getDownloadURL();
      FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'nickname': nickname, 'aboutMe': aboutMe, 'photoUrl': photoUrl}).then((data) async {
        await prefs?.setString('photoUrl', photoUrl);
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "Upload success");
      }).catchError((err) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: err.toString());
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  void handleUpdateData() {
    focusNodeNickname.unfocus();
    focusNodeAboutMe.unfocus();

    setState(() {
      isLoading = true;
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'nickname': nickname, 'aboutMe': aboutMe, 'photoUrl': photoUrl}).then((data) async {
      await prefs?.setString('nickname', nickname);
      await prefs?.setString('aboutMe', aboutMe);
      await prefs?.setString('photoUrl', photoUrl);

      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: "Update success");
    }).catchError((err) {
      setState(() {
        isLoading = false;
      });

      Fluttertoast.showToast(msg: err.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SettingsScreen(),
    );
  }
}