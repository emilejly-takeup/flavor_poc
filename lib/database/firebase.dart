import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_poc/counter_model.dart';
import 'package:flavor_poc/custom_error.dart';

class CounterRepository {
  final refCounter = FirebaseFirestore.instance.collection("counter");

  Future<Counter> fetchCounter() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await refCounter.doc("9lnDvDFyYhPXoCTTI2xE").get();
      return Counter.fromFirestore(doc);
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }

  Future<void> updateCounter(Counter counter) async {
    try {
      await refCounter.doc(counter.id).update(counter.toMap());
    } on FirebaseException catch (e) {
      throw CustomError(code: e.code, message: e.message!, plugin: e.plugin);
    } catch (e) {
      throw CustomError(
          code: 'Exception',
          message: e.toString(),
          plugin: 'flutter_error/server_error');
    }
  }
}
