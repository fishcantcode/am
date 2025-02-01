import 'package:google_mlkit_smart_reply/google_mlkit_smart_reply.dart';

class ChatService {
  final SmartReply smartReply = SmartReply();

  Future<String> getBotResponse(String userMessage) async {
    smartReply.addMessageToConversationFromLocalUser(userMessage, DateTime.now().millisecondsSinceEpoch);
    final response = await smartReply.suggestReplies();

    for (final suggestion in response.suggestions) {
      return suggestion;
    }

    return 'Sorry, I do not understand';
  }

  void dispose() {
    smartReply.close();
  }
}