import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:law_bot/auth/auth.dart';
import 'package:law_bot/theme/theme.dart';
import 'package:law_bot/utils/listener_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoadingPPicture = false;

  Future<void> _openFileUploadProfilePicture() async {
    setState(() {
      isLoadingPPicture = true;
    });
    PlatformFile? pickedFile;
    UploadTask uploadTask;
    FirebaseAuth auth = FirebaseAuth.instance;
    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpeg', 'png', 'jpg']);
    if (result == null) return;
    pickedFile = result.files.first;

    if (pickedFile.path != null) {
      final path =
          "images/${auth.currentUser!.uid}/${auth.currentUser!.uid + pickedFile.name}";
      final file = File(pickedFile.path!);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      final snapshot = await uploadTask.whenComplete(() {});

      final urlDownload = await snapshot.ref.getDownloadURL();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.teal,
          content: Text("Profile Picture uploaded successfully"),
        ),
      );
      BotAuth.instance.user.updatePhotoURL(urlDownload);
      BotAuth.instance.notifyListeners();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("You Didn't Choose a File"),
        ),
      );
    }
    setState(() {
      isLoadingPPicture = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListenerWidget(
      notifier: BotAuth.instance,
      builder: (context, _) {
        return Scaffold(
          backgroundColor:
              ThemeManagement.instance.currentTheme.scaffoldBackgroundColor,
          body: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 260,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: size.width,
                        height: 120,
                        decoration: BoxDecoration(
                            color: ThemeManagement
                                .instance.currentTheme.primaryColorLight,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            )),
                      ),
                    ),
                    Positioned(
                        top: 55,
                        right: 175,
                        child: Text(
                          "Profile",
                          style: TextStyle(
                              color: ThemeManagement
                                  .instance.currentTheme.primaryColor,
                              fontSize: 20),
                        )),
                    Positioned(
                        top: 90,
                        left: 135,
                        child: GestureDetector(
                          onTap: () {
                            _openFileUploadProfilePicture();
                          },
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60),
                                  bottomLeft: Radius.circular(60)),
                              child: FadeInImage(
                                fit: BoxFit.fill,
                                placeholder:
                                    const AssetImage('assets/loading.gif'),
                                image: NetworkImage(BotAuth
                                        .instance.user.photoURL ??
                                    "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg?20200913095930"),
                              ),
                            ),
                          ),
                        )),
                    Positioned(
                        top: 185,
                        right: 125,
                        child: Stack(children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                  color: ThemeManagement
                                      .instance.currentTheme.primaryColorLight,
                                  shape: BoxShape.circle),
                              child: const Center(
                                child: Icon(Icons.check, color: Colors.white),
                              ),
                            ),
                          ),
                        ])),
                    Positioned(
                      top: 230,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "${BotAuth.instance.user.email}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ThemeManagement
                                  .instance.currentTheme.primaryColor,
                              fontSize: 23),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await BotAuth.instance.logOut();
                          // ignore: use_build_context_synchronously
                          Navigator.popAndPushNamed(context, "/");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.exit_to_app_outlined,
                                          color: Colors.red,
                                        ),
                                        SizedBox(width: 15),
                                        Text(
                                          "Log Out",
                                          style: TextStyle(
                                              color: Colors.red, fontSize: 23),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
