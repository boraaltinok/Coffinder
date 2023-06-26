import 'package:uuid/uuid.dart';

class RandomIdGenerator {

  static String generateUniqueId(){
    return const Uuid().v4();

  }
}