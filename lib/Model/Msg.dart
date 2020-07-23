class Msg {
  final msg;
  final name;
  final time;
  Msg({
    this.msg,
    this.name,
    this.time,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'msg': msg,
      'time': time,
    };
  }
}
