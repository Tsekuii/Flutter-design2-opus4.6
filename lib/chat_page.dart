import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class MyChatBot extends StatelessWidget {
  const MyChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    const apiKey = String.fromEnvironment('GEMINI_API_KEY');

    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      systemInstruction: Content.system(
        '''Чи Монгол сурагчдад зориулсан AI сурах туслагч юм.
        
Чиний үүрэг:
- Математик, Физик, Монгол хэл, Англи хэл, Түүх, Мэдээлэл зүй хичээлүүдийг тайлбарлах
- Асуултад тодорхой, ойлгомжтой хариулт өгөх
- Жишээ бодлого шийдэж үзүүлэх
- Монгол болон Англи хэлээр харилцах
- Хичээлийн агуулгаас гадна хариулт өгөхгүй байх

Хариулах хэлбэр:
- Богино, тодорхой байх
- Шаардлагатай бол алхам алхмаар тайлбарлах
- Дүгнэлт хийхдээ "Тиймээс..." гэж эхлэх''',
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('AI Туслагч')),
      body: LlmChatView(
        provider: GeminiProvider(model: model),
        onErrorCallback: (context, error) {
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              content: Text(
                apiKey.isEmpty
                    ? 'GEMINI_API_KEY тохируулаагүй байна. --dart-define=GEMINI_API_KEY=... гэж ажиллуулна уу'
                    : 'Алдаа: $error',
              ),
            ),
          );
        },
      ),
    );
  }
}