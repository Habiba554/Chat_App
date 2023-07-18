import '../constants.dart';

class Messages
{
  final String messages;
  final String id;
  Messages(this.messages, this.id);

  factory Messages.fromJson(jsonData)
  {
    return Messages(jsonData[kMessages],jsonData['id'],);
  }
}