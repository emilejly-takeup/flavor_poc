import 'package:cloud_firestore/cloud_firestore.dart';

class Counter {
  final String id;
  final int value;

  Counter({required this.id, required this.value});

  factory Counter.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return Counter(
      id: doc.id,
      value: doc.get("value"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "value": value,
    };
  }
}
