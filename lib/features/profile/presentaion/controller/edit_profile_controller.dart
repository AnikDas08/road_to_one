import 'dart:io';

import 'package:flutter/material.dart';

class EditProfileController {
  // Profile data
  String profileImageUrl = "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop";
  String aboutMe = "Scelerisque Phasellus Donec amet, eget ipsum, consectetur id varius at, nec nec odor ipsum amet, iincidunt quis vitae";
  String userName = "New Jack";
  String email = "Gabriel01@gmail.com";
  String contactNo = "+8801050000000";
  String location = "Dhaka, Bangladesh";
  String occupation = "Business";
  String dreamJob = "Pilot";
  String education = "Graduated";
  String interestedIn = "Socializing, Adventure, Travelling";

  // Text editing controllers
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController dreamJobController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController interestedInController = TextEditingController();

  File? selectedProfileImage;      // Selected local image

  void updateProfileImage(File image) {
    selectedProfileImage = image;
  }

  void removeProfileImage() {
    selectedProfileImage = null;
  }

  EditProfileController() {
    // Initialize controllers with current values
    aboutMeController.text = aboutMe;
    userNameController.text = userName;
    emailController.text = email;
    contactNoController.text = contactNo;
    locationController.text = location;
    occupationController.text = occupation;
    dreamJobController.text = dreamJob;
    educationController.text = education;
    interestedInController.text = interestedIn;
  }

  void saveProfile() {
    // Update values from controllers
    aboutMe = aboutMeController.text;
    userName = userNameController.text;
    email = emailController.text;
    contactNo = contactNoController.text;
    location = locationController.text;
    occupation = occupationController.text;
    dreamJob = dreamJobController.text;
    education = educationController.text;
    interestedIn = interestedInController.text;

    print("Profile saved successfully!");
  }

  void dispose() {
    aboutMeController.dispose();
    userNameController.dispose();
    emailController.dispose();
    contactNoController.dispose();
    locationController.dispose();
    occupationController.dispose();
    dreamJobController.dispose();
    educationController.dispose();
    interestedInController.dispose();
  }
}