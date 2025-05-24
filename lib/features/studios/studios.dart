import 'package:flutter/material.dart';
import 'package:tugtugan/commons/widgets/text/expandable_text.dart';

class Studio extends StatelessWidget {
  const Studio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('InsertName'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Tristan Studios",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 25,
          ),
          ExpandableText(
            text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna alLorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua... Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...iqua...',
          ),
        ]),
      ),
    );
  }
}
