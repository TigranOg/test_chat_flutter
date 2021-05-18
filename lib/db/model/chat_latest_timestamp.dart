class ChatLatestTimestamp {
  String chatGroupId;
  int timestamp;

  int get getTimestamp => timestamp;

  ChatLatestTimestamp(this.chatGroupId, this.timestamp);

  Map<String, dynamic> toMap() => {
    chatGroupIdField: chatGroupId,
    timestampField: timestamp,
  };

  static ChatLatestTimestamp fromMap(Map<String, dynamic> map) => ChatLatestTimestamp(
    map[chatGroupIdField] as String,
    map[timestampField] as int,
  );

  //DB table and field names, queries
  static final String tableName = 'chatLatestTimestamp';
  static final String chatGroupIdField = 'chatGroupId';
  static final String timestampField = 'timestamp';

  static final List<String> values = [chatGroupIdField, timestampField];

  static final String createQuery = '''
    CREATE TABLE $tableName (
    $chatGroupIdField TEXT NOT NULL,
    $timestampField INTEGER NOT NULL
    )''';
}
