import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teater_jkt/controller/address_controller.dart';
import 'package:teater_jkt/controller/contact_controller.dart';
import 'package:teater_jkt/model/address_model.dart';
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
  final AddressController addressController = Get.put(AddressController());
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    userController.getCurrentUser();
    contactController.getContact();
    // Fetch the address list for a specific contact (example: contact with ID 1)
    addressController.getAddressList(contactController.contact.value.id ?? 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120.0), // Provide space for the fixed buttons
            child: Column(
              children: [
                const SizedBox(height: 20),
                _buildTopSection(userController.userModel.value, contactController.contact.value),
                const Divider(thickness: 1),
                _buildPersonalInfoSection(contactController.contact.value, addressController.address.value),
                const Divider(thickness: 1),
                const SizedBox(height: 20),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.white, // Background color to ensure visibility
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: SecondaryButton(
                      label: isEditing ? 'Save' : 'Edit Profile',
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
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
                                    userController.logout(); // Panggil fungsi logout
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk menampilkan dialog pilihan saat foto profil diklik
  void _showPhotoOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Foto Profil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo),
                title: Text('Lihat Foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showFullPhoto(); // Memanggil fungsi untuk menampilkan foto ukuran penuh
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit Foto'),
                onTap: () {
                  Navigator.of(context).pop();
                  // Tambahkan logika untuk mengedit foto (misalnya pilih foto dari galeri)
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Fungsi untuk menampilkan foto profil dalam ukuran penuh
  void _showFullPhoto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, // Menghilangkan latar belakang dialog
          insetPadding: EdgeInsets.all(10), // Mengatur padding agar foto lebih besar
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      contactController.contact.value.photo ?? 'https://via.placeholder.com/150',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Tutup'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopSection(User user, Contact contact) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: _showPhotoOptions, // Memanggil _showPhotoOptions saat foto diklik
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(contact.photo ?? 'https://via.placeholder.com/150'),
            ),
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

  Widget _buildPersonalInfoSection(Contact contact, Address address) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildProfileField("Email", contact.email ?? ''),
          const SizedBox(height: 20),
          _buildProfileField("Phone", contact.phone ?? ''),
          const SizedBox(height: 20),
          const Divider(thickness: 1),
          const SizedBox(height: 20),
          const Text(
            'Additional Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildProfileField("Street", address.street ?? 'Alamat belum diisi'),
          _buildProfileField("City", address.city ?? 'Kota belum diisi'),
          // _buildProfileField("Province", address.province ?? 'Provinsi belum diisi'),
          // _buildProfileField("Country", address.country ?? 'Negara belum diisi'),
          // _buildProfileField("Postal Code", address.postalCode ?? 'Kode Pos belum diisi'),
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
