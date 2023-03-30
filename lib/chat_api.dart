// api/chat_api.dart
import 'package:dart_openai/openai.dart';
import 'chat_message.dart';
import 'secrets.dart';

class ChatApi {
  static const _model = 'gpt-3.5-turbo-0301'; //'gpt-3.5-turbo';

  ChatApi() {
    OpenAI.apiKey = openAiApiKey;
    OpenAI.organization = openAiOrg;
  }

  Future<String> completeChat(List<ChatMessage> messages) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: _model,
      messages: messages
          .map((e) => OpenAIChatCompletionChoiceMessageModel(
                //role: e.isUserMessage ? 'user' : 'assistant',
                role: e.isUserMessage
                    ? OpenAIChatMessageRole.user
                    : OpenAIChatMessageRole.assistant,
                content: e.content,
              ))
          .toList(),
    );
    return chatCompletion.choices.first.message.content;
  }
}
