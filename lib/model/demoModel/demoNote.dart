// To parse this JSON data, do
//
//     final demoNote = demoNoteFromJson(jsonString);

import 'dart:convert';

DemoNote demoNoteFromJson(String str) => DemoNote.fromJson(json.decode(str));

String demoNoteToJson(DemoNote data) => json.encode(data.toJson());

class DemoNote {
  int? demoId;
  String? demoNote;

  DemoNote({
    this.demoId,
    this.demoNote,
  });

  factory DemoNote.fromJson(Map<String, dynamic> json) => DemoNote(
    demoId: json["demo_id"],
    demoNote: json["demo_note"],
  );

  Map<String, dynamic> toJson() => {
    "demo_id": demoId,
    "demo_note": demoNote,
  };
}
