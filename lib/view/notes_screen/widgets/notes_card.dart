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
       required this.selectedColorIndex,
       this.onDeletepressed,
       this.onEditPressed,
       });

  final String title;
  final String description;
  final String date;
  final int selectedColorIndex;
  final void Function()? onDeletepressed;
  final void Function()? onEditPressed;

   @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 15, left: 15, right: 20),
      decoration: BoxDecoration(
          color: NotesScreenController.colorList[selectedColorIndex],
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title),
              Spacer(),
              InkWell(onTap: onEditPressed, child: Icon(Icons.edit)),
              SizedBox(width: 10),
              InkWell(onTap: onDeletepressed, child: Icon(Icons.delete))
            ],
          ),
          SizedBox(height: 10),
          Text(description),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(date),
                SizedBox(width: 15),
                InkWell(
                    onTap: () {
                      Share.share('$title\n$description');
                    },
                    child: Icon(Icons.share))
              ],
            ),
          )
        ],
      ),
    );
  }
}