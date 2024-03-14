import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomExpensionPanelList extends StatefulWidget {
  final String description;

  const CustomExpensionPanelList({super.key, required this.description});

  @override
  State<CustomExpensionPanelList> createState() =>
      _CustomExpensionPanalListState();
}

class _CustomExpensionPanalListState extends State<CustomExpensionPanelList> {
  bool Expanded = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ExpansionPanelList(
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            Expanded = isExpanded;
            print(isExpanded);
          });
        },
        children: [
          ExpansionPanel(
            isExpanded: Expanded,
            backgroundColor: Colors.teal,
            headerBuilder: (context, isExpanded) => ListTile(
              title: Text(
                'Description',
                style: GoogleFonts.cairo()
                    .copyWith(fontSize: 18, color: Colors.white),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                widget.description,
                style: GoogleFonts.cairo()
                    .copyWith(color: Colors.white, fontSize: 18),
              ),
            ),
          )
        ],
      ),
    );
  }
}
