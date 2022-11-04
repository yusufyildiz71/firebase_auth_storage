import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_freelance/view/allUsers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameController = TextEditingController();
  final surnamenameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF00897B),
          child: Icon(Icons.logout),
          onPressed: (() {
            FirebaseAuth.instance.signOut();
          })),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Center(
                child: Text(
              "HELLO  " + user.email!,
              style: TextStyle(color: Color(0xFF00897B), fontSize: 16),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "ADD USER",
              style: TextStyle(color: Color(0xFF00897B), fontSize: 22),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white.withOpacity(0.6),
                ),
                child: TextFormField(
                  cursorColor: Color(0xFF00897B),
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      print('name boş olamaz.');
                      return 'name boş olamaz.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Name",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  color: Colors.white.withOpacity(0.6),
                ),
                child: TextFormField(
                  cursorColor: Color(0xFF00897B),
                  controller: surnamenameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      print('surname boş olamaz.');
                      return 'surname boş olamaz.';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: "Surname",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: Color(0xFF00897B),
                primary: Color(0xFF00897B),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                minimumSize: const Size(200, 50)),
            onPressed: () async {
              addUser(nameController.text.trim(),
                  surnamenameController.text.trim());
              var snackBar = SnackBar(
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.transparent,
                content: AwesomeSnackbarContent(
                  title: 'Success!',
                  message: 'User Created!',
                  contentType: ContentType.success,
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: Text("Add User",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                )),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                onPrimary: Color(0xFF00897B),
                primary: Colors.blue,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                minimumSize: const Size(200, 50)),
            onPressed: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AllUsers()));
            },
            child: Text("All Users",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                )),
          ),
        ],
      ),
    );
  }

  Future<void> addUser(String name, String surname) async {
    await FirebaseFirestore.instance.collection("users").add({
      'name': name,
      'surname': surname,
    });
  }
}
