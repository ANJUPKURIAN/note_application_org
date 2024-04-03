import 'package:flutter/material.dart';
import 'package:note_application_org/controller/notes_screen_controller.dart';
//import 'package:note_application_org/core/constant/color_constant.dart';
import 'package:share_plus/share_plus.dart';

class NotesCard extends StatelessWidget {
     const NotesCard(
      {
        super.key,
       required this.title,
       required this.description,
       required this.date,
       required this.colorIndex,
       this.onDeletepressed,
       this.onEditPressed,
       });

  final String title;
  final String description;
  final String date;
  final int colorIndex;
  final void Function()? onDeletepressed;
  final void Function()? onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          color: NotesScreenController.colorList[colorIndex],
          borderRadius: BorderRadius.circular(13)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Row(
                children: [
                  InkWell(onTap: onEditPressed, child: Icon(Icons.edit)),
                  SizedBox(width: 15),
                  InkWell(onTap: onDeletepressed, child: Icon(Icons.delete))
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(description),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(date),
              SizedBox(width: 20),
              InkWell(
                  onTap: () {
                    Share.share("$title\n$description");
                  },
                  child: Icon(Icons.share))
            ],
          )
        ],
      ),
    );
  }
}