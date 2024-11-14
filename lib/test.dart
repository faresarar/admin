import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: ContactUs(
          logo: const AssetImage('images/crop.jpg'),
          instagram:  '_abhishek_doshi',
          email: 'adoshi26.ad@gmail.com',
          companyName: 'Abhishek Doshi',
          phoneNumber: '+91123456789',
          dividerThickness: 2,
          website: 'https://abhishekdoshi.godaddysites.com',
          githubUserName: 'AbhishekDoshi26',
          linkedinURL: 'https://www.linkedin.com/in/abhishek-doshi-520983199/',
          tagLine: 'Flutter Developer',
          twitterHandle: 'AbhishekDoshi26',
           textColor: Colors.deepOrange, cardColor: Colors.grey, companyColor: Colors.green, taglineColor: Colors.purple,
        ),
      ),
    );
  }
}