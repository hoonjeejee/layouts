import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget datePickerTextField(BuildContext context,
    TextEditingController controller, String label, Function fn) {
  return Container(
    padding: const EdgeInsets.all(15),
    width: 160,
    child: TextField(
      controller: controller, //editing controller of this TextField
      decoration: InputDecoration(
        icon: const Icon(Icons.calendar_today), //icon of text field
        labelText: label, //label text of field
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          fn(formattedDate);
        } else {
          print("Date is not selected");
        }
      },
    ),
  );
}
