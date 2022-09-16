import 'package:flutter/material.dart';
import 'package:leauges/controller/buildbody.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Image.asset(
                  'assets/images/music.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Text('Music Album'),
            ],
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: const BuildBody(),
    );
  }
}
