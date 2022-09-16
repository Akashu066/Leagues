import 'package:flutter/material.dart';
import 'package:leauges/controller/musicdetailbody.dart';

class Musicdetailspage extends StatefulWidget {
  const Musicdetailspage(
      {Key? key, required this.albumid, required this.albumname})
      : super(key: key);

  final int albumid;
  final String albumname;

  @override
  State<Musicdetailspage> createState() => _Musicdetailspage();
}

class _Musicdetailspage extends State<Musicdetailspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.albumname),
        backgroundColor: Colors.blueGrey,
      ),
      body: BuildmusicBody(id: widget.albumid),
    );
  }
}
