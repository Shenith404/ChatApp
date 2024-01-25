import 'package:chatapp/Component/colors.dart';
import 'package:chatapp/Pages/chatPage.dart';
import 'package:chatapp/Pages/loading.dart';
import 'package:chatapp/Services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // authe instance
    Future<void> SignOut() async {
      final authservice = Provider.of<AuthService>(context, listen: false);
      await authservice.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: MyColors.defaultColor3,
        actions: [
          IconButton(
            onPressed: SignOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: buildUerList(),
    );
  }

//build a user list except the current user
  Widget buildUerList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading();
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _builUserListItem(doc))
                .toList(),
          );
        });
  }

  // build individual list item
  Widget _builUserListItem(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data =
        documentSnapshot.data()! as Map<String, dynamic>;

    // display alluser except current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyColors.defaultColor3,
          ),
          child: Text(
            data['email'],
            style: const TextStyle(color: Colors.white),
          ),
        ),
        onTap: () {
          // pass the clicked user id for page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receverUserEmail: data['email'],
                receverUserId: data['id'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
