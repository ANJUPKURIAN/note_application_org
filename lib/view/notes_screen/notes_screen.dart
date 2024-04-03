import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for date format
import 'package:note_application_org/controller/notes_screen_controller.dart';
import 'package:note_application_org/view/notes_screen/widgets/notes_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  
  @override
  void initState() {
    NotesScreenController.getInitKeys();
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int selectedColorIndex = 0;
  // ignore: unused_field
  static var myBox = Hive.box("noteBox");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
     body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        itemBuilder: (context, index) {
          final currentKey = NotesScreenController.notesListKeys[index];
          final currentElement = NotesScreenController.myBox.get(currentKey);
          return NotesCard(
            title: currentElement["title"],
            date: currentElement["date"],
            description: currentElement["des"],
            colorIndex: currentElement["colorIndex"],
            onDeletepressed: () async {
              await NotesScreenController.deleteNote(currentKey);
              setState(() {});
            },
            onEditPressed: () {
              titleController.text = currentElement["title"];
              descriptionController.text = currentElement["des"];

              dateController.text = currentElement["date"];

              selectedColorIndex = currentElement["colorIndex"];

              customBottomSheet(
                  context: context, isEdit: true, currentKey: currentKey);
            },
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: NotesScreenController.notesListKeys.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleController.clear();
          descriptionController.clear();

          dateController.clear();

          selectedColorIndex = 0;

          customBottomSheet(context: context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // to build bottom sheet
  Future<dynamic> customBottomSheet(
      {required BuildContext context, bool isEdit = false, var currentKey}) {
    return showModalBottomSheet(
      backgroundColor: Colors.grey.shade800,
      isScrollControlled: true,
      context: context,
      builder: (context) => StatefulBuilder(builder: (context, bottomSetState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isEdit ? "Update Note" : "Add Note",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: "Title",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                      hintText: "Description",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  readOnly: true,
                  controller: dateController,
                  decoration: InputDecoration(
                      hintText: "Date",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      suffixIcon: InkWell(
                          onTap: () async {
                            final selectedDateTime = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030));
                            if (selectedDateTime != null) {
                              String formatedDate =
                                  DateFormat("yMMMMd").format(selectedDateTime);
                              dateController.text = formatedDate.toString();
                            }

                            bottomSetState(() {});
                          },
                          child: Icon(
                            Icons.date_range_rounded,
                            color: Colors.black,
                            size: 25,
                          ))),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                      4,
                      (index) => InkWell(
                            onTap: () {
                              selectedColorIndex = index;
                              print(selectedColorIndex);
                              bottomSetState(() {});
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: selectedColorIndex == index ? 5 : 0),
                                  borderRadius: BorderRadius.circular(10),
                                  color: NotesScreenController.colorList[index]),
                            ),
                          )),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        if (isEdit == true) {
                          await NotesScreenController.editNote(
                              key: currentKey,
                              title: titleController.text,
                              description: descriptionController.text,
                              date: dateController.text,
                              colorIndex: selectedColorIndex);
                        } else {
                          await NotesScreenController.addNote(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: dateController.text,
                              colorIndex: selectedColorIndex);
                        }

                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Container(
                        width: 100,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            isEdit == true ? "Edit" : "Add",
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100,
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}