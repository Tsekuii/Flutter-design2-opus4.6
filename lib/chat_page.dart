import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MyChatBot extends StatelessWidget {
  const MyChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    // Load this at runtime so you don't check secrets into git.
    //
    // Run:
    // flutter run --dart-define=GEMINI_API_KEY=YOUR_KEY
    const apiKey = String.fromEnvironment('GEMINI_API_KEY');

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(
        'You are a helpful travel assistant for Flutter developers.',
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('AI Assistant')),
      body: LlmChatView(
        // Streaming is supported by the toolkit and will show tokens as generated.
        provider: GeminiProvider(model: model),
        onErrorCallback: (context, error) {
          final messenger = ScaffoldMessenger.maybeOf(context);
          messenger?.showSnackBar(
            SnackBar(
              content: Text(
                apiKey.isEmpty
                    ? 'Missing API key. Run with --dart-define=GEMINI_API_KEY=...'
                    : 'Chat error: $error',
              ),
            ),
          );
        },
      ),
    );
  }
}

