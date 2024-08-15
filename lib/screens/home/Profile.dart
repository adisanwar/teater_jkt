import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/contact_controller.dart';
import 'package:teater_jkt/model/contact_model.dart';
import 'package:teater_jkt/model/user_model.dart';
import 'package:teater_jkt/widget/form/PrimaryButton.dart';
import 'package:teater_jkt/widget/form/ScondaryButton.dart';
import '../../controller/user_controlller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final UserController userController = Get.put(UserController());
  final ContactController contactController = Get.put(ContactController());
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    userController.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Obx(() {
        if (userController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        var user = userController.userModel.value;
        var contact = contactController.contact.value;

        // print(contact.phone);

        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildTopSection(user, contact),
              const Divider(thickness: 1),
              _buildPersonalInfoSection(contact),
              const Divider(thickness: 1),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: SecondaryButton(
                        label: isEditing ? 'Save' : 'Edit Profile',
                        onPressed: () {
                          isEditing = !isEditing;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        labelbtn: "Logout",
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Konfirmasi Logout'),
                                content: const Text('Yakin ingin logout?'),
                                actions: <Widget>[
                                  TextButton(
                                    child: const Text('Batal'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Tutup dialog
                                    },
                                  ),
                                  TextButton(
                                    child: const Text('Logout'),
                                    onPressed: () {
                                      Navigator.of(context).pop(); // Tutup dialog
                                      userController
                                          .logout(); // Panggil fungsi logout
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildTopSection(User user, Contact contact) {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            // backgroundImage: NetworkImage(user.photo ?? 'https://via.placeholder.com/150'),
          ),
        ),
        const SizedBox(height: 20),
        Text(
          user.name ?? 'Nama ',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          contact.fullname ?? 'Nama Belakang',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildPersonalInfoSection(Contact contact) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Additional Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildProfileField("Email", contact.email ?? ''),
          const SizedBox(height: 20),
          _buildProfileField("phone", contact.phone ?? ''),
        ],
      ),
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
