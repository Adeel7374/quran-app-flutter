import 'package:al_quran/consts/Colors.dart';
import 'package:al_quran/models/qari.dart';
import 'package:flutter/material.dart';

class QariCustomTile extends StatefulWidget {
  final Qari qari;
  final VoidCallback ontap;
  const QariCustomTile({super.key, required this.ontap, required this.qari});

  @override
  State<QariCustomTile> createState() => _QariCustomTileState();
}

class _QariCustomTileState extends State<QariCustomTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 0,
                    color: Colors.black12,
                    offset: Offset(0, 1))
              ]),
          child: Column(
            children: [
              Text(
                widget.qari.name!,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
