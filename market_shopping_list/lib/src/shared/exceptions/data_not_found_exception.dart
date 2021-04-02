class DataNotFoundException implements Exception {
  String dataName;
  DataNotFoundException({required this.dataName});
}
