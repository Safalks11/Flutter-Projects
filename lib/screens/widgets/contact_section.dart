import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../constants/colors.dart';

class ContactSection extends StatefulWidget {
  final Size size;
  const ContactSection({super.key, required this.size});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref().child('post');

  Future<void> _submitForm() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _subjectController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are required!')),
      );
      return;
    }

    try {
      await _dbRef.push().set({
        'name': _nameController.text,
        'email': _emailController.text,
        'subject': _subjectController.text,
        'message': _messageController.text,
        'timestamp': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully!')),
      );

      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return Container(
      padding: EdgeInsets.only(
          bottom: size.width * 0.06,
          top: size.width * 0.04,
          left: size.width * 0.06,
          right: size.width * 0.06),
      color: AppColors.ebony,
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          GradientText(
            'Contact Me',
            colors: const [
              AppColors.studio,
              AppColors.paleSlate,
            ],
            style: TextStyle(
              fontSize: size.width > 900
                  ? size.width * 0.022
                  : size.width > 600
                      ? size.width * 0.035
                      : size.width * 0.040,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          SizedBox(
            width: size.width * 0.9,
            child: const Divider(
              color: AppColors.paleSlate,
            ),
          ),
          Spacer(),
          SizedBox(
            width: size.width > 900 ? size.width * 0.50 : size.width,
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.studioLight, width: 2),
                ),
                filled: true,
                fillColor: Colors.white60,
                hintText: 'Name',
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: size.width > 900 ? size.width * 0.50 : size.width,
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.studioLight, width: 2),
                ),
                filled: true,
                fillColor: Colors.white60,
                hintText: 'Email',
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: size.width > 900 ? size.width * 0.50 : size.width,
            child: TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.studioLight, width: 2),
                ),
                filled: true,
                fillColor: Colors.white60,
                hintText: 'Subject',
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          SizedBox(
            width: size.width > 900 ? size.width * 0.50 : size.width,
            child: TextFormField(
              controller: _messageController,
              maxLines: 10,
              maxLength: 540,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.studioLight, width: 2),
                ),
                filled: true,
                fillColor: Colors.white60,
                hintText: 'Message',
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          MaterialButton(
            onPressed: _submitForm,
            color: AppColors.studio,
            splashColor: AppColors.studioLight,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
