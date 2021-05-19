import 'package:meta/meta.dart';

enum MessageType {
  text,
  image,
  listOfImages,
  sticker,
}

class Message {
  final String idFrom;
  final String idTo;
  final String content;
  final MessageType type;
  final bool isRead;
  final String timestamp;

  Message({
    @required this.idFrom,
    @required this.idTo,
    @required this.content,
    @required this.type,
    @required this.isRead,
    @required this.timestamp,
  });

  Message.fromMap(Map<String, dynamic> parsedJson)
      : idFrom = parsedJson[idFromField] as String,
        idTo = parsedJson[idToField] as String,
        content = parsedJson[contentField] as String,
        type = MessageType.values[parsedJson[typeField] as int],
        isRead = parsedJson[isReadField] ?? true,
        timestamp = parsedJson[timestampField] as String;

  Map<String, dynamic> toMap() {
    return {
      idFromField: idFrom,
      idToField: idTo,
      contentField: content,
      typeField: type.index,
      isReadField: isRead,
      timestampField: timestamp,
    };
  }

  //DB table and field names, queries
  static final String tableName = 'message';
  static final String idFromField = 'idFrom';
  static final String idToField = 'idTo';
  static final String contentField = 'content';
  static final String typeField = 'type';
  static final String isReadField = 'isRead';
  static final String timestampField = 'timestamp';

  static final List<String> values = [idFromField, idToField, contentField, typeField, isReadField, timestampField];

  static final String createQuery = '''
    CREATE TABLE $tableName (
    $idFromField TEXT NOT NULL,
    $idToField TEXT NOT NULL,
    $contentField TEXT NOT NULL,
    $typeField INTEGER NOT NULL,
    $isReadField BOOLEAN NOT NULL,
    $timestampField TEXT NOT NULL
    )''';
}
