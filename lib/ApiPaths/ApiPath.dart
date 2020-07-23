import 'package:com_snaps/Chats/Chat.dart';

class ApiPath {
  static String chatsPath(String mutualId) {
    return '/ChatRoom/$mutualId/chats/aaa${DateTime.now().millisecondsSinceEpoch}';
  }

  static String chatsPathRead(String mutualId) {
    return '/ChatRoom/$mutualId/chats';

    // static String chatsPath(String mutualId) {
    //   return '/check/$mutualId/insiddeCheck/abc1';
    // }

    // static String chatsPathRead(String mutualId) {
    //   return '/check/$mutualId/insiddeCheck';
  }

  static String recentUsersPathRead() {
    return '/ChatRoom';
  }

  static String identityPathSet() {
    return '/ChatRoom/${Chat.mutualId}';
  }
}
