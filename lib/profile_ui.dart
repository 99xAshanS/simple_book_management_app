// profile_ui.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  final List<TextEditingController> skillControllers = [];
  final List<TextEditingController> experienceTitleControllers = [];
  final List<TextEditingController> experienceCompanyControllers = [];
  final List<TextEditingController> experienceDurationControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professional Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _showImagePickerOptions,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : AssetImage('assets/profile_picture.png')
                            as ImageProvider,
                    child: _profileImage == null
                        ? Icon(Icons.camera_alt, size: 30, color: const Color.fromARGB(255, 21, 80, 243))
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 16),
              _buildProfileSection('Personal Information', [
                _buildTextField('Name', nameController),
                _buildTextField('Email', emailController),
                _buildTextField('Phone', phoneController),
                _buildTextField('Website', websiteController),
              ]),
              SizedBox(height: 24),
              _buildProfileSectionWithEdit(
                  'Skills (Edit)', _buildEditableSkills(), _addSkill),
              SizedBox(height: 24),
              _buildProfileSectionWithEdit(
                  'Experience (Edit)', _buildEditableExperience(), _addExperience),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _saveProfile,
                  icon: Icon(Icons.save),
                  label: Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSectionWithEdit(
      String title, List<Widget> children, VoidCallback onEditPressed) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: onEditPressed,
                  icon: Icon(Icons.add, size: 20, color: Colors.indigo),
                ),
              ],
            ),
            SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  List<Widget> _buildEditableSkills() {
    List<Widget> skillFields = [];
    for (int i = 0; i < skillControllers.length; i++) {
      skillFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: skillControllers[i],
                  decoration: InputDecoration(
                    labelText: 'Skill ${i + 1}',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeSkill(i),
              )
            ],
          ),
        ),
      );
    }
    return skillFields;
  }

  List<Widget> _buildEditableExperience() {
    List<Widget> experienceFields = [];
    for (int i = 0; i < experienceTitleControllers.length; i++) {
      experienceFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            children: [
              _buildTextField('Title', experienceTitleControllers[i]),
              _buildTextField('Company', experienceCompanyControllers[i]),
              _buildTextField('Duration', experienceDurationControllers[i]),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeExperience(i),
              )
            ],
          ),
        ),
      );
    }
    return experienceFields;
  }

  void _saveProfile() {
    setState(() {
      // Save profile details from user input
      String name = nameController.text;
      String email = emailController.text;
      String phone = phoneController.text;
      String website = websiteController.text;
      // Save other details such as skills and experience
    });
  }

  void _addSkill() {
    setState(() {
      skillControllers.add(TextEditingController());
    });
  }

  void _removeSkill(int index) {
    setState(() {
      skillControllers.removeAt(index);
    });
  }

  void _editSkills() {
    setState(() {
      _addSkill(); // Trigger adding a new skill field
    });
  }

  void _addExperience() {
    setState(() {
      experienceTitleControllers.add(TextEditingController());
      experienceCompanyControllers.add(TextEditingController());
      experienceDurationControllers.add(TextEditingController());
    });
  }

  void _removeExperience(int index) {
    setState(() {
      experienceTitleControllers.removeAt(index);
      experienceCompanyControllers.removeAt(index);
      experienceDurationControllers.removeAt(index);
    });
  }

  void _editExperience() {
    setState(() {
      _addExperience(); // Trigger adding a new experience field
    });
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Picture'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    websiteController.dispose();
    skillControllers.forEach((controller) => controller.dispose());
    experienceTitleControllers.forEach((controller) => controller.dispose());
    experienceCompanyControllers.forEach((controller) => controller.dispose());
    experienceDurationControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
