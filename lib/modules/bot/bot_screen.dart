import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:graduation_project/shared/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  bool _isLoading = false;

  static const apiKey = "AIzaSyDINKZrASjQn-8_WuCUSNXPbcmuFImiqJY";

  final model =
      GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);

  List<types.Message> _messages = [];
  final _user = const types.User(id: 'user', firstName: 'User');
  final _bot = const types.User(
    id: 'bot',
    firstName: 'Renalyze AI Assistant',
    imageUrl:
        'https://ui-avatars.com/api/?background=2CAED8&color=fff&name=R&bold=true&font-size=0.5&length=0.5',
  );

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      var localPath = message.uri;

      if (message.uri.startsWith('http')) {
        final client = http.Client();
        final request = await client.get(Uri.parse(message.uri));
        final bytes = request.bodyBytes;
        final documentsDir = (await getApplicationDocumentsDirectory()).path;
        localPath = '$documentsDir/${message.name}';

        if (!File(localPath).existsSync()) {
          final file = File(localPath);
          await file.writeAsBytes(bytes);
        }
      }

     // await OpenFilex.open(localPath);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    setState(() {
      _messages[index] = updatedMessage;
    });
  }

  Future<void> _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    setState(() {
      _isLoading = true;
    });

    try {
      final content = [Content.text(message.text)];
      final response = await model.generateContent(content);

      final botMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: response.text ?? "I'm sorry, I couldn't generate a response.",
      );

      _addMessage(botMessage);
    } catch (e) {
      final errorMessage = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "Sorry, there was an error processing your request.",
      );

      _addMessage(errorMessage);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loadMessages() async {
    try {
      final response = await rootBundle.loadString('assets/messages.json');
      final messages = (jsonDecode(response) as List)
          .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
          .toList();

      setState(() {
        _messages = messages;
      });
    } catch (e) {
      final message = types.TextMessage(
        author: _bot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: "Hello! I'm your AI assistant. How can I help you today?",
      );

      setState(() {
        _messages = [message];
      });
    }
  }

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/Animation - 1746014508010.json',
            fit: BoxFit.fill,
            height: 200,
            width: 200,
            repeat: true,
            animate: true,
          ),
          const Text(
            "Renalyze AI Assistant",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Chat(
              messages: _messages,
              onMessageTap: _handleMessageTap,
              onPreviewDataFetched: _handlePreviewDataFetched,
              onSendPressed: _handleSendPressed,
              showUserAvatars: true,
              showUserNames: true,
              user: _user,
              theme: const DefaultChatTheme(
                backgroundColor: Colors.white,
                primaryColor: primaryColor,
                secondaryColor: Color(0xFFF5F5F5),
                userAvatarNameColors: [
                  primaryColor,
                  primaryColor,
                  primaryColor,
                  primaryColor,
                ],
                messageBorderRadius: 20,
              ),
              customBottomWidget: Container(),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -1),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                        hintText: 'Ask for anything...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF5F5F5),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      onSubmitted: (text) {
                        if (text.trim().isNotEmpty) {
                          _handleCustomSend(text);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      //? Send button
                      Material(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: _isLoading
                              ? null
                              : () {
                                  if (_textController.text.trim().isNotEmpty) {
                                    _handleCustomSend(_textController.text);
                                  }
                                },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),

                      if (_isLoading)
                        const SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 5,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCustomSend(String text) {
    //! Clear the text field
    _textController.clear();

    //! Create a partial text message to use with the existing handler
    final partialText = types.PartialText(text: text);

    //! Use the existing handler
    _handleSendPressed(partialText);
  }
}
