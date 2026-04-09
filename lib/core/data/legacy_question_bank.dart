import 'lesson_content_data.dart';

class LegacyQuestionBank {
  const LegacyQuestionBank._();

  static final Map<int, Map<String, List<LessonQuestion>>> _bank = {
    1: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: '“А” үсгээр эхэлдэг үг аль нь вэ?',
          promptEn: 'Which word starts with "A"?',
          choicesMn: const ['алим', 'ном', 'морь'],
          choicesEn: const ['алим', 'ном', 'морь'],
          correctIndex: 0,
          answerMn: 'Зөв: алим',
          answerEn: 'Correct: алим',
        ),
        LessonQuestion.multipleChoice(
          promptMn: '“Б” үсэг аль үгэнд байна вэ?',
          promptEn: 'Which word contains "Б"?',
          choicesMn: const ['нар', 'бөмбөг', 'аав'],
          choicesEn: const ['нар', 'бөмбөг', 'аав'],
          correctIndex: 1,
          answerMn: 'Зөв: бөмбөг',
          answerEn: 'Correct: бөмбөг',
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Эгшиг үсэг аль нь вэ?',
          promptEn: 'Which is a vowel?',
          choicesMn: const ['б', 'а', 'м'],
          choicesEn: const ['б', 'а', 'м'],
          correctIndex: 1,
          answerMn: 'Зөв: а',
          answerEn: 'Correct: а',
        ),
        LessonQuestion.multipleChoice(
          promptMn: '“Би ном уншиж байна.” — юу хийж байна вэ?',
          promptEn: '“Би ном уншиж байна.” — what is being done?',
          choicesMn: const ['уншиж байна', 'гүйж байна', 'унтаж байна'],
          choicesEn: const ['уншиж байна', 'гүйж байна', 'унтаж байна'],
          correctIndex: 0,
          answerMn: 'Зөв: уншиж байна',
          answerEn: 'Correct: уншиж байна',
        ),
        LessonQuestion.shortAnswer(
          promptMn: 'Өгүүлбэр зохио',
          promptEn: 'Write a sentence',
          expectedAnswers: const [' '],
          answerMn: 'Чөлөөт хариу',
          answerEn: 'Open response',
        ),
        LessonQuestion.multipleChoice(
          promptMn: '“а” үсгийг зөв бичсэн нь аль вэ?',
          promptEn: 'Which is the correct form of "а"?',
          choicesMn: const ['а', '@', '9'],
          choicesEn: const ['а', '@', '9'],
          correctIndex: 0,
          answerMn: 'Зөв: а',
          answerEn: 'Correct: а',
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '2 + 3 = ?',
          promptEn: '2 + 3 = ?',
          choicesMn: const ['5', '6', '4'],
          choicesEn: const ['5', '6', '4'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '7 – 2 = ?',
          promptEn: '7 - 2 = ?',
          choicesMn: const ['6', '5', '3'],
          choicesEn: const ['6', '5', '3'],
          correctIndex: 1,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Аль нь зөв дараалал вэ?',
          promptEn: 'Which is the correct sequence?',
          choicesMn: const ['1,2,3,4', '1,3,2,4', '4,3,2,1'],
          choicesEn: const ['1,2,3,4', '1,3,2,4', '4,3,2,1'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Дугуй хэлбэр аль нь вэ?',
          promptEn: 'Which one is circular?',
          choicesMn: const ['⚽', '📦', '📐'],
          choicesEn: const ['⚽', '📦', '📐'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '10-аас их тоо аль вэ?',
          promptEn: 'Which number is greater than 10?',
          choicesMn: const ['8', '12', '5'],
          choicesEn: const ['8', '12', '5'],
          correctIndex: 1,
        ),
        LessonQuestion.shortAnswer(
          promptMn: 'Тоо бич',
          promptEn: 'Write a number',
          expectedAnswers: const [' '],
          answerMn: 'Чөлөөт хариу',
          answerEn: 'Open response',
        ),
      ],
      'Дүрслэх урлаг': [
        LessonQuestion.multipleChoice(
          promptMn: 'Улаан өнгө аль вэ?',
          promptEn: 'Which one is red?',
          choicesMn: const ['🔴', '🔵', '⚫'],
          choicesEn: const ['🔴', '🔵', '⚫'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Шулуун шугам аль вэ?',
          promptEn: 'Which is a straight line?',
          choicesMn: const ['——', '~~~~', '○'],
          choicesEn: const ['——', '~~~~', '○'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Муруй шугам аль вэ?',
          promptEn: 'Which is a curved line?',
          choicesMn: const ['○', '~~~~', '|'],
          choicesEn: const ['○', '~~~~', '|'],
          correctIndex: 1,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Өнгө холиход шар + улаан = ?',
          promptEn: 'Yellow + red = ?',
          choicesMn: const ['ногоон', 'улбар шар', 'хар'],
          choicesEn: const ['ногоон', 'улбар шар', 'хар'],
          correctIndex: 1,
        ),
        LessonQuestion.shortAnswer(
          promptMn: 'Зураг зур',
          promptEn: 'Draw a picture',
          expectedAnswers: const [' '],
          answerMn: 'Чөлөөт хариу',
          answerEn: 'Open response',
        ),
      ],
      'Хөгжим': [
        LessonQuestion.multipleChoice(
          promptMn: 'Хэмнэл гэж юу вэ?',
          promptEn: 'What is rhythm?',
          choicesMn: const ['давтамжтай дуу', 'зураг', 'үсэг'],
          choicesEn: const ['давтамжтай дуу', 'зураг', 'үсэг'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Аль нь дуу вэ?',
          promptEn: 'Which is music?',
          choicesMn: const ['🎵', '📘', '✏️'],
          choicesEn: const ['🎵', '📘', '✏️'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Чанга дуу аль вэ?',
          promptEn: 'Which is loud sound?',
          choicesMn: const ['🔊', '🔈', '🤫'],
          choicesEn: const ['🔊', '🔈', '🤫'],
          correctIndex: 0,
        ),
        LessonQuestion.shortAnswer(
          promptMn: 'Дуу дуул',
          promptEn: 'Sing a song',
          expectedAnswers: const [' '],
          answerMn: 'Чөлөөт хариу',
          answerEn: 'Open response',
        ),
      ],
      'Байгаль': [
        LessonQuestion.multipleChoice(
          promptMn: 'Аль нь амьтан вэ?',
          promptEn: 'Which is an animal?',
          choicesMn: const ['нохой', 'мод', 'чулуу'],
          choicesEn: const ['нохой', 'мод', 'чулуу'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Аль нь ургамал вэ?',
          promptEn: 'Which is a plant?',
          choicesMn: const ['мод', 'муур', 'машин'],
          choicesEn: const ['мод', 'муур', 'машин'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Зун ямар вэ?',
          promptEn: 'What is summer like?',
          choicesMn: const ['халуун', 'хүйтэн', 'цастай'],
          choicesEn: const ['халуун', 'хүйтэн', 'цастай'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Өвөл ямар вэ?',
          promptEn: 'What is winter like?',
          choicesMn: const ['халуун', 'хүйтэн', 'бороотой'],
          choicesEn: const ['халуун', 'хүйтэн', 'бороотой'],
          correctIndex: 1,
        ),
      ],
    },
    2: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Аль нь зөв өгүүлбэр вэ?',
          promptEn: 'Which sentence is correct?',
          choicesMn: const ['Би ном уншина.', 'ном би уншина', 'уншина би ном'],
          choicesEn: const ['Би ном уншина.', 'ном би уншина', 'уншина би ном'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Түргэн унших нь…',
          promptEn: 'Fast reading means...',
          choicesMn: const ['ойлгож унших', 'зүгээр харах', 'алгасах'],
          choicesEn: const ['ойлгож унших', 'зүгээр харах', 'алгасах'],
          correctIndex: 0,
        ),
        LessonQuestion.shortAnswer(
          promptMn: 'Өгүүлбэр бич',
          promptEn: 'Write a sentence',
          expectedAnswers: const [' '],
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '25 + 10 = ?',
          promptEn: '25 + 10 = ?',
          choicesMn: const ['35', '30', '40'],
          choicesEn: const ['35', '30', '40'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '60 – 20 = ?',
          promptEn: '60 - 20 = ?',
          choicesMn: const ['50', '40', '30'],
          choicesEn: const ['50', '40', '30'],
          correctIndex: 1,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Аль нь 2 оронтой вэ?',
          promptEn: 'Which is two-digit?',
          choicesMn: const ['5', '23', '7'],
          choicesEn: const ['5', '23', '7'],
          correctIndex: 1,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: '“Red” юу вэ?',
          promptEn: 'What is "Red"?',
          choicesMn: const ['өнгө', 'амьтан', 'тоо'],
          choicesEn: const ['color', 'animal', 'number'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '“One” гэж?',
          promptEn: '"One" means?',
          choicesMn: const ['1', '2', '3'],
          choicesEn: const ['1', '2', '3'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '“Blue” юу вэ?',
          promptEn: 'What is "Blue"?',
          choicesMn: const ['өнгө', 'хоол', 'тоо'],
          choicesEn: const ['color', 'food', 'number'],
          correctIndex: 0,
        ),
      ],
    },
    3: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Аль өгүүлбэр зөв бүтэцтэй вэ?',
          promptEn: 'Which sentence has correct structure?',
          choicesMn: const ['Би өнөөдөр сургууль явсан.', 'Өнөөдөр би сургууль', 'Явсан сургууль би'],
          choicesEn: const ['Би өнөөдөр сургууль явсан.', 'Өнөөдөр би сургууль', 'Явсан сургууль би'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Аль нь зөв бичсэн үг вэ?',
          promptEn: 'Which word is correctly written?',
          choicesMn: const ['сургууль', 'сургуйл', 'сургуул'],
          choicesEn: const ['сургууль', 'сургуйл', 'сургуул'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '4 × 5 = ?',
          promptEn: '4 × 5 = ?',
          choicesMn: const ['20', '25', '15'],
          choicesEn: const ['20', '25', '15'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '15 ÷ 3 = ?',
          promptEn: '15 ÷ 3 = ?',
          choicesMn: const ['5', '3', '6'],
          choicesEn: const ['5', '3', '6'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Аль өгүүлбэр зөв вэ?',
          promptEn: 'Which sentence is correct?',
          choicesMn: const ['I like apples.', 'Like I apples', 'Apples I like'],
          choicesEn: const ['I like apples.', 'Like I apples', 'Apples I like'],
          correctIndex: 0,
        ),
      ],
    },
    4: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: '“Зохиолын гол санаа” гэж юу вэ?',
          promptEn: 'What is the main idea?',
          choicesMn: const ['Дүрүүд юу хийдэг вэ', 'Өнгөний нэр', 'Тоо'],
          choicesEn: const ['What characters do', 'Color names', 'Numbers'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Дараах үгсийг зөв дараалалд оруул: “ном, би, уншлаа”',
          promptEn: 'Arrange words correctly: "ном, би, уншлаа"',
          choicesMn: const ['Би ном уншлаа', 'Ном уншлаа би', 'Уншлаа би ном'],
          choicesEn: const ['Би ном уншлаа', 'Ном уншлаа би', 'Уншлаа би ном'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '6 × 7 = ?',
          promptEn: '6 × 7 = ?',
          choicesMn: const ['42', '36', '48'],
          choicesEn: const ['42', '36', '48'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '56 ÷ 8 = ?',
          promptEn: '56 ÷ 8 = ?',
          choicesMn: const ['7', '6', '8'],
          choicesEn: const ['7', '6', '8'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: '“This is a pencil.” — зөв үү?',
          promptEn: '"This is a pencil." is correct?',
          choicesMn: const ['Зөв', 'Буруу', 'Мэдэхгүй'],
          choicesEn: const ['Correct', 'Wrong', 'Unknown'],
          correctIndex: 0,
        ),
      ],
    },
    5: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Зохиолын шинж чанарыг тодорхойл',
          promptEn: 'Identify literary features',
          choicesMn: const ['Дүр, үйл явдал', 'Тоо, өнгө', 'Алгебр'],
          choicesEn: const ['Character, plot', 'Numbers, colors', 'Algebra'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '“Би ном уншиж, дэвтэртээ тэмдэглэл хийсэн.” гол санаа?',
          promptEn: 'Main idea of the sentence?',
          choicesMn: const ['Би уншсан', 'Ном уншсангүй', 'Дэвтэрээ мартаж'],
          choicesEn: const ['I read', 'Did not read', 'Forgot notebook'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '3/4 + 1/4 = ?',
          promptEn: '3/4 + 1/4 = ?',
          choicesMn: const ['1', '3/8', '1/2'],
          choicesEn: const ['1', '3/8', '1/2'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '50% нь хэд вэ?',
          promptEn: 'What is 50%?',
          choicesMn: const ['25', '50', '10'],
          choicesEn: const ['25', '50', '10'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Present / Past: “Yesterday I ___ a ball.”',
          promptEn: 'Yesterday I ___ a ball.',
          choicesMn: const ['played', 'play', 'playing'],
          choicesEn: const ['played', 'play', 'playing'],
          correctIndex: 0,
        ),
      ],
      'Түүх / Байгаль': [
        LessonQuestion.multipleChoice(
          promptMn: 'Эртний иргэншлийн жишээ?',
          promptEn: 'Example of ancient civilization?',
          choicesMn: const ['Египет', 'Хар ус', 'Мод'],
          choicesEn: const ['Egypt', 'Black water', 'Tree'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Байгаль орчны өөрчлөлтөд нөлөөлөх хүчин зүйл?',
          promptEn: 'Factor affecting environmental change?',
          choicesMn: const ['Хүн', 'Үсэг', 'Тоо'],
          choicesEn: const ['Human', 'Letter', 'Number'],
          correctIndex: 0,
        ),
      ],
      'Дүрслэх урлаг': [
        LessonQuestion.multipleChoice(
          promptMn: 'Өнгө холих: улаан + шар = ?',
          promptEn: 'Red + yellow = ?',
          choicesMn: const ['улбар шар', 'ногоон', 'цэнхэр'],
          choicesEn: const ['orange', 'green', 'blue'],
          correctIndex: 0,
        ),
      ],
      'Хөгжим': [
        LessonQuestion.multipleChoice(
          promptMn: 'Хэмнэл дагахдаа юу ашиглах вэ?',
          promptEn: 'What do you use to keep rhythm?',
          choicesMn: const ['Алга', 'Үсэг', 'Тоо'],
          choicesEn: const ['Clap', 'Letter', 'Number'],
          correctIndex: 0,
        ),
      ],
    },
    6: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Үг, өгүүлбэрийн бүтэц аль нь зөв вэ?',
          promptEn: 'Which sentence structure is correct?',
          choicesMn: const ['Би ном уншиж байна.', 'Ном би байна уншиж', 'Уншиж байна би ном'],
          choicesEn: const ['Би ном уншиж байна.', 'Ном би байна уншиж', 'Уншиж байна би ном'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Дүрэм: Аль нь зөв үг вэ?',
          promptEn: 'Which word is correct?',
          choicesMn: const ['Сурагч', 'Сургагч', 'Сургууль'],
          choicesEn: const ['Сурагч', 'Сургагч', 'Сургууль'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '20% нь хэд вэ?',
          promptEn: '20% is?',
          choicesMn: const ['4', '10', '5'],
          choicesEn: const ['4', '10', '5'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Харьцаа: 2:5 = ?',
          promptEn: '2:5 equals?',
          choicesMn: const ['2/5', '5/2', '3/5'],
          choicesEn: const ['2/5', '5/2', '3/5'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Tenses: “I ___ to school yesterday.”',
          promptEn: 'I ___ to school yesterday.',
          choicesMn: const ['went', 'go', 'going'],
          choicesEn: const ['went', 'go', 'going'],
          correctIndex: 0,
        ),
      ],
      'Түүх': [
        LessonQuestion.multipleChoice(
          promptMn: 'Монголын түүхийн суурь үе?',
          promptEn: 'Foundational period in Mongolian history?',
          choicesMn: const ['Чингис хаан', 'Наполеон', 'Жорж Вашингтон'],
          choicesEn: const ['Chinggis Khan', 'Napoleon', 'George Washington'],
          correctIndex: 0,
        ),
      ],
      'Газарзүй': [
        LessonQuestion.multipleChoice(
          promptMn: 'Газрын зураг: Монгол хаана байрладаг вэ?',
          promptEn: 'On map, where is Mongolia?',
          choicesMn: const ['Азид', 'Европ', 'Африк'],
          choicesEn: const ['Asia', 'Europe', 'Africa'],
          correctIndex: 0,
        ),
      ],
      'Биологи': [
        LessonQuestion.multipleChoice(
          promptMn: 'Уур амьсгалд нөлөөлдөг хүчин зүйл?',
          promptEn: 'Factor affecting climate?',
          choicesMn: const ['Нар, салхи', 'Тоо', 'Үсэг'],
          choicesEn: const ['Sun, wind', 'Number', 'Letter'],
          correctIndex: 0,
        ),
      ],
      'Дүрслэх урлаг': [
        LessonQuestion.multipleChoice(
          promptMn: 'Өнгө холих: цэнхэр + шар = ?',
          promptEn: 'Blue + yellow = ?',
          choicesMn: const ['ногоон', 'улаан', 'саарал'],
          choicesEn: const ['green', 'red', 'gray'],
          correctIndex: 0,
        ),
      ],
      'Хөгжим': [
        LessonQuestion.multipleChoice(
          promptMn: 'Хөгжмийн тэмдэг сонго',
          promptEn: 'Choose music symbol',
          choicesMn: const ['🎵', '📘', '✏️'],
          choicesEn: const ['🎵', '📘', '✏️'],
          correctIndex: 0,
        ),
      ],
    },
    7: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: '“Ном би уншлаа.” зөв найруулсан нь?',
          promptEn: 'Correctly rewritten:',
          choicesMn: const ['Би ном уншлаа', 'Ном би уншлаа', 'Уншлаа би ном'],
          choicesEn: const ['Би ном уншлаа', 'Ном би уншлаа', 'Уншлаа би ном'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '2x + 5 = 15 → x=?',
          promptEn: '2x + 5 = 15 → x=?',
          choicesMn: const ['5', '10', '15'],
          choicesEn: const ['5', '10', '15'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '3y – 9 = 0 → y=?',
          promptEn: '3y - 9 = 0 → y=?',
          choicesMn: const ['3', '0', '6'],
          choicesEn: const ['3', '0', '6'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '4:8 = x:16 → x=?',
          promptEn: '4:8 = x:16 → x=?',
          choicesMn: const ['8', '4', '16'],
          choicesEn: const ['8', '4', '16'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Grammar: “She ___ to school every day.”',
          promptEn: 'She ___ to school every day.',
          choicesMn: const ['goes', 'go', 'going'],
          choicesEn: const ['goes', 'go', 'going'],
          correctIndex: 0,
        ),
      ],
      'Физик': [
        LessonQuestion.multipleChoice(
          promptMn: 'Хурд = 20 км/цаг, хугацаа=2 цаг. Зам=?',
          promptEn: 'Speed 20 km/h, time 2h. Distance?',
          choicesMn: const ['40 км', '10 км', '30 км'],
          choicesEn: const ['40 km', '10 km', '30 km'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Ажил = хүч × зай. 5N × 2m = ?',
          promptEn: 'Work = force × distance. 5N × 2m = ?',
          choicesMn: const ['10 J', '7 J', '12 J'],
          choicesEn: const ['10 J', '7 J', '12 J'],
          correctIndex: 0,
        ),
      ],
      'Биологи': [
        LessonQuestion.multipleChoice(
          promptMn: 'Ургамал, амьтан (суурь): Аль нь амьтан вэ?',
          promptEn: 'Which is an animal?',
          choicesMn: const ['нохой', 'мод', 'ус'],
          choicesEn: const ['dog', 'tree', 'water'],
          correctIndex: 0,
        ),
      ],
    },
    8: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Найруулга: “Модны навч намар унав.” зөв хэлбэр?',
          promptEn: 'Choose the best rewritten sentence.',
          choicesMn: const ['Намар модны навч унав', 'Модны навч намар унана', 'Намар унана модны навч'],
          choicesEn: const ['Намар модны навч унав', 'Модны навч намар унана', 'Намар унана модны навч'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Эсээ (суурь): “Хүмүүс хичээл зүтгэлээр амжилтанд хүрдэг.” гол санаа?',
          promptEn: 'Choose the main idea.',
          choicesMn: const ['Амжилт хичээл зүтгэлээр ирдэг', 'Амжилт зүгээр л ирдэг', 'Амжилт азаар л ирдэг'],
          choicesEn: const ['Success comes from effort', 'Success just comes', 'Success by luck'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '5x – 7 = 18 → x=?',
          promptEn: '5x - 7 = 18 → x=?',
          choicesMn: const ['5', '4', '6'],
          choicesEn: const ['5', '4', '6'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'y = 3x – 2, x=4 → y=?',
          promptEn: 'y = 3x - 2, x=4 → y=?',
          choicesMn: const ['10', '12', '14'],
          choicesEn: const ['10', '12', '14'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '7 × 8 = ?',
          promptEn: '7 × 8 = ?',
          choicesMn: const ['56', '54', '58'],
          choicesEn: const ['56', '54', '58'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Grammar: “If I ___ rich, I would travel.”',
          promptEn: 'If I ___ rich, I would travel.',
          choicesMn: const ['were', 'am', 'be'],
          choicesEn: const ['were', 'am', 'be'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Correct sentence: “She don’t like apples.”',
          promptEn: 'Choose correct sentence.',
          choicesMn: const ['She doesn’t like apples', 'She do not like apples', 'She not like apples'],
          choicesEn: const ['She doesn’t like apples', 'She do not like apples', 'She not like apples'],
          correctIndex: 0,
        ),
      ],
      'Физик': [
        LessonQuestion.multipleChoice(
          promptMn: 'Хурд = зай/цаг. 50 км/2 цаг = ?',
          promptEn: '50 km / 2h = ?',
          choicesMn: const ['25 км/цаг', '20 км/цаг', '30 км/цаг'],
          choicesEn: const ['25 km/h', '20 km/h', '30 km/h'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Ажил, энерги: 5N × 2м = ?',
          promptEn: 'Work: 5N × 2m = ?',
          choicesMn: const ['10 J', '7 J', '12 J'],
          choicesEn: const ['10 J', '7 J', '12 J'],
          correctIndex: 0,
        ),
      ],
      'Хими': [
        LessonQuestion.multipleChoice(
          promptMn: 'Элемент бич: Аль нь элемент вэ?',
          promptEn: 'Which one is an element?',
          choicesMn: const ['O', 'H2O', 'NaCl'],
          choicesEn: const ['O', 'H2O', 'NaCl'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Ус H2O юу вэ?',
          promptEn: 'H2O is...',
          choicesMn: const ['Бодис', 'Холимог', 'Хий'],
          choicesEn: const ['Substance', 'Mixture', 'Gas'],
          correctIndex: 0,
        ),
      ],
      'Биологи': [
        LessonQuestion.multipleChoice(
          promptMn: 'Амьд бие: Аль нь амьд организм биш вэ?',
          promptEn: 'Which is not a living organism?',
          choicesMn: const ['Тунамал чулуу', 'Мод', 'Муур'],
          choicesEn: const ['Rock sediment', 'Tree', 'Cat'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Экологи: Байгаль хамгаалах арга?',
          promptEn: 'How to protect nature?',
          choicesMn: const ['Хог хаяхгүй', 'Хог хаях', 'Бүхийг шатаах'],
          choicesEn: const ['Do not litter', 'Litter', 'Burn everything'],
          correctIndex: 0,
        ),
      ],
      'Нийгмийн ухаан': [
        LessonQuestion.multipleChoice(
          promptMn: 'Эдийн засаг: Бараа эрэлт их бол үнэ?',
          promptEn: 'If demand is high, price is...',
          choicesMn: const ['Их', 'Бага', 'Үнэгүй'],
          choicesEn: const ['Higher', 'Lower', 'Free'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Хууль: Иргэн юу хийх ёстой вэ?',
          promptEn: 'A citizen should...',
          choicesMn: const ['Дүрэм мөрдөх', 'Дүрэм зөрчих', 'Ямар ч хамаагүй'],
          choicesEn: const ['Follow rules', 'Break rules', 'Anything'],
          correctIndex: 0,
        ),
      ],
      'Дүрслэх урлаг': [
        LessonQuestion.multipleChoice(
          promptMn: 'Өнгө холих: Улаан+Цэнхэр=?',
          promptEn: 'Color mixing: Red + Blue = ?',
          choicesMn: const ['Ягаан', 'Шар', 'Ногоон'],
          choicesEn: const ['Purple', 'Yellow', 'Green'],
          correctIndex: 0,
        ),
      ],
      'Хөгжим': [
        LessonQuestion.multipleChoice(
          promptMn: 'Хөгжмийн тэмдэг сонго',
          promptEn: 'Choose a music symbol',
          choicesMn: const ['🎵', '📘', '✏️'],
          choicesEn: const ['🎵', '📘', '✏️'],
          correctIndex: 0,
        ),
      ],
    },
    9: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Эсээ: “Сургуульд амжилттай сурах нь...” гол санаа?',
          promptEn: 'Main idea question.',
          choicesMn: const ['Амжилт хичээл зүтгэлээс ирдэг', 'Амжилт зүгээр л ирдэг', 'Амжилт азаар ирдэг'],
          choicesEn: const ['Effort leads to success', 'Success just comes', 'Success is only luck'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '2x + 5 = 17 → x=?',
          promptEn: '2x + 5 = 17 → x=?',
          choicesMn: const ['6', '5', '7'],
          choicesEn: const ['6', '5', '7'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '√49 = ?',
          promptEn: '√49 = ?',
          choicesMn: const ['7', '6', '8'],
          choicesEn: const ['7', '6', '8'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'y = 2x, x=3 → y=?',
          promptEn: 'y = 2x, x=3',
          choicesMn: const ['6', '5', '7'],
          choicesEn: const ['6', '5', '7'],
          correctIndex: 0,
        ),
      ],
      'Физик': [
        LessonQuestion.multipleChoice(
          promptMn: '5Ω-т 10V → гүйдэл=?',
          promptEn: '10V across 5Ω, current?',
          choicesMn: const ['2 A', '5 A', '10 A'],
          choicesEn: const ['2 A', '5 A', '10 A'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'V = s/t, s=100m, t=20s → V=?',
          promptEn: 'V = s/t with s=100, t=20',
          choicesMn: const ['5 m/s', '4 m/s', '6 m/s'],
          choicesEn: const ['5 m/s', '4 m/s', '6 m/s'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Grammar: “They ___ to school every day.”',
          promptEn: 'They ___ to school every day.',
          choicesMn: const ['go', 'goes', 'going'],
          choicesEn: const ['go', 'goes', 'going'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Vocabulary: “Delicious” утга?',
          promptEn: 'Meaning of "Delicious"?',
          choicesMn: const ['Амттай', 'Амтгүй', 'Хүйтэн'],
          choicesEn: const ['Tasty', 'Tasteless', 'Cold'],
          correctIndex: 0,
        ),
      ],
      'Хими': [
        LessonQuestion.multipleChoice(
          promptMn: 'NaCl – ямар төрөл?',
          promptEn: 'NaCl is...',
          choicesMn: const ['Нэгдэл', 'Холимог', 'Элемент'],
          choicesEn: const ['Compound', 'Mixture', 'Element'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'HCl – ямар төрөл?',
          promptEn: 'HCl is...',
          choicesMn: const ['Хүчил', 'Давс', 'Ус'],
          choicesEn: const ['Acid', 'Salt', 'Water'],
          correctIndex: 0,
        ),
      ],
      'Биологи': [
        LessonQuestion.multipleChoice(
          promptMn: 'Удамшил: Аль нь генетикийн жишээ?',
          promptEn: 'Which is a genetic trait?',
          choicesMn: const ['Үсний өнгө', 'Хоолны амт', 'Цаг агаар'],
          choicesEn: const ['Hair color', 'Food taste', 'Weather'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Photosynthesis гэж юу вэ?',
          promptEn: 'What is photosynthesis?',
          choicesMn: const ['Нарны энерги → хоол', 'Ус → нүүрс', 'Хүнс идэх'],
          choicesEn: const ['Sunlight to food', 'Water to carbon', 'Eating food'],
          correctIndex: 0,
        ),
      ],
      'Нийгмийн ухаан': [
        LessonQuestion.multipleChoice(
          promptMn: 'Эдийн засаг: Эрэлт их бол үнэ?',
          promptEn: 'If demand increases, price...',
          choicesMn: const ['Их', 'Бага', 'Үнэгүй'],
          choicesEn: const ['Higher', 'Lower', 'Free'],
          correctIndex: 0,
        ),
      ],
    },
    10: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: '“Суралцах процесс нь амжилтын түлхүүр.” гол санаа?',
          promptEn: 'Identify the main idea.',
          choicesMn: const ['Амжилт суралцахаас ирдэг', 'Амжилт зүгээр л ирдэг', 'Амжилт азаар л ирдэг'],
          choicesEn: const ['Learning leads to success', 'Success just comes', 'Success is luck'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '“Нар мандах нь шинэ эхлэл билээ.” утга?',
          promptEn: 'Meaning of the metaphor?',
          choicesMn: const ['Шинэ эхлэл', 'Өдрийн төгсгөл', 'Аз жаргал'],
          choicesEn: const ['New beginning', 'End of day', 'Happiness'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '3x – 7 = 11 → x=?',
          promptEn: '3x - 7 = 11 → x=?',
          choicesMn: const ['6', '5', '7'],
          choicesEn: const ['6', '5', '7'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'y = 2x + 3, x=4 → y=?',
          promptEn: 'y = 2x + 3, x=4 → y=?',
          choicesMn: const ['11', '10', '12'],
          choicesEn: const ['11', '10', '12'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '2x + 5 < 15 → x=?',
          promptEn: 'Solve inequality.',
          choicesMn: const ['x < 5', 'x > 5', 'x = 5'],
          choicesEn: const ['x < 5', 'x > 5', 'x = 5'],
          correctIndex: 0,
        ),
      ],
      'Физик': [
        LessonQuestion.multipleChoice(
          promptMn: '100 N хүч 2 м зайд → ажил=?',
          promptEn: 'Work for 100N over 2m?',
          choicesMn: const ['200 J', '100 J', '50 J'],
          choicesEn: const ['200 J', '100 J', '50 J'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'V=10V, R=5Ω → I=?',
          promptEn: 'Current from Ohm law',
          choicesMn: const ['2 A', '5 A', '10 A'],
          choicesEn: const ['2 A', '5 A', '10 A'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Grammar: “I ___ seen that movie.”',
          promptEn: 'I ___ seen that movie.',
          choicesMn: const ['have', 'has', 'had'],
          choicesEn: const ['have', 'has', 'had'],
          correctIndex: 0,
        ),
      ],
      'Хими': [
        LessonQuestion.multipleChoice(
          promptMn: 'H2SO4 – ямар төрөл вэ?',
          promptEn: 'H2SO4 is...',
          choicesMn: const ['Хүчил', 'Давс', 'Ус'],
          choicesEn: const ['Acid', 'Salt', 'Water'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'H2O моляр масс?',
          promptEn: 'Molar mass H2O?',
          choicesMn: const ['18 g/mol', '16 g/mol', '20 g/mol'],
          choicesEn: const ['18 g/mol', '16 g/mol', '20 g/mol'],
          correctIndex: 0,
        ),
      ],
      'Биологи': [
        LessonQuestion.multipleChoice(
          promptMn: 'Эс: Аль нь эс биш вэ?',
          promptEn: 'Which is not a cell/living unit?',
          choicesMn: const ['Чулуу', 'Мод', 'Муур'],
          choicesEn: const ['Rock', 'Tree', 'Cat'],
          correctIndex: 0,
        ),
      ],
      'Нийгмийн ухаан': [
        LessonQuestion.multipleChoice(
          promptMn: 'Хууль: Иргэн юу хийх ёстой вэ?',
          promptEn: 'What should a citizen do?',
          choicesMn: const ['Дүрэм мөрдөх', 'Дүрэм зөрчих', 'Ямар ч хамаагүй'],
          choicesEn: const ['Follow rules', 'Break rules', 'Anything'],
          correctIndex: 0,
        ),
      ],
    },
    11: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Эх сурвалж: “Цахим боловсрол үр өгөөжтэй.” аль нь зөв эх сурвалж?',
          promptEn: 'Best supporting source?',
          choicesMn: const ['Судалгааны тайлан', 'Шинэ роман', 'Хошин шог'],
          choicesEn: const ['Research report', 'Novel', 'Comedy'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Харьцуулсан задлан: “Хот амьдрал ба хөдөө амьдрал.”',
          promptEn: 'Comparison',
          choicesMn: const ['Хот – хурд, Хөдөө – амар', 'Хөдөө – хурд, Хот – амар', 'Хоёулаа ижил'],
          choicesEn: const ['City fast, countryside calm', 'Countryside fast, city calm', 'Same'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: '2^x = 32 → x=?',
          promptEn: '2^x = 32 → x=?',
          choicesMn: const ['5', '4', '6'],
          choicesEn: const ['5', '4', '6'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'log₂8 = ?',
          promptEn: 'log₂8 = ?',
          choicesMn: const ['3', '2', '4'],
          choicesEn: const ['3', '2', '4'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'sin²θ + cos²θ = ?',
          promptEn: 'Identity value',
          choicesMn: const ['1', '0', 'sinθ'],
          choicesEn: const ['1', '0', 'sinθ'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: '“If I ___ you, I would go.”',
          promptEn: 'If I ___ you, I would go.',
          choicesMn: const ['were', 'was', 'am'],
          choicesEn: const ['were', 'was', 'am'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Vocabulary: “Sustainable” утга?',
          promptEn: 'Meaning of sustainable?',
          choicesMn: const ['Тогтвортой', 'Түр зуурын', 'Хүчирхэг'],
          choicesEn: const ['Sustainable', 'Temporary', 'Strong'],
          correctIndex: 0,
        ),
      ],
      'Физик': [
        LessonQuestion.multipleChoice(
          promptMn: 'sin²θ + cos²θ = ?',
          promptEn: 'sin²θ + cos²θ = ?',
          choicesMn: const ['1', '0', 'sinθ'],
          choicesEn: const ['1', '0', 'sinθ'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'V = V0 + at, V0=0, a=2, t=5 → V=?',
          promptEn: 'Velocity formula',
          choicesMn: const ['10 m/s', '5 m/s', '12 m/s'],
          choicesEn: const ['10 m/s', '5 m/s', '12 m/s'],
          correctIndex: 0,
        ),
      ],
      'Хими': [
        LessonQuestion.multipleChoice(
          promptMn: '18 г H2O → хэдэн моль?',
          promptEn: '18 g H2O equals how many moles?',
          choicesMn: const ['1 mol', '0.5 mol', '2 mol'],
          choicesEn: const ['1 mol', '0.5 mol', '2 mol'],
          correctIndex: 0,
        ),
      ],
      'Биологи': [
        LessonQuestion.multipleChoice(
          promptMn: 'Mendel: Aa x Aa үр дүн?',
          promptEn: 'Aa x Aa gives?',
          choicesMn: const ['AA, Aa, aa', 'AA, AA, Aa', 'Aa, aa, Aa'],
          choicesEn: const ['AA, Aa, aa', 'AA, AA, Aa', 'Aa, aa, Aa'],
          correctIndex: 0,
        ),
      ],
      'Нийгмийн ухаан': [
        LessonQuestion.multipleChoice(
          promptMn: 'Инфляци гэдэг нь?',
          promptEn: 'Inflation means...',
          choicesMn: const ['Бараа үнэ өсөх', 'Бараа үнэ буурах', 'Өөрчлөгдөхгүй'],
          choicesEn: const ['Price increase', 'Price decrease', 'No change'],
          correctIndex: 0,
        ),
      ],
    },
    12: {
      'Монгол хэл': [
        LessonQuestion.multipleChoice(
          promptMn: 'Уран зохиолын бэлгэдэл юу илэрхийлдэг вэ?',
          promptEn: 'Literary symbols express...',
          choicesMn: const ['Сэтгэл хөдлөл, үнэт зүйл', 'Амралт', 'Боловсрол'],
          choicesEn: const ['Emotion and values', 'Rest', 'Education'],
          correctIndex: 0,
        ),
      ],
      'Математик': [
        LessonQuestion.multipleChoice(
          promptMn: 'y = sin(x) → dy/dx=?',
          promptEn: 'Derivative of sin(x)?',
          choicesMn: const ['cos(x)', 'sin(x)', '-cos(x)'],
          choicesEn: const ['cos(x)', 'sin(x)', '-cos(x)'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '∫(2x dx) = ?',
          promptEn: '∫(2x dx) = ?',
          choicesMn: const ['x² + C', '2x² + C', 'x + C'],
          choicesEn: const ['x² + C', '2x² + C', 'x + C'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'A(0,0), B(4,4), x тэнхлэгтэй өнцөг=?',
          promptEn: 'Angle with x-axis for A(0,0) to B(4,4)?',
          choicesMn: const ['45°', '30°', '60°'],
          choicesEn: const ['45°', '30°', '60°'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'cos²θ – sin²θ = ?',
          promptEn: 'cos²θ - sin²θ = ?',
          choicesMn: const ['cos(2θ)', 'sin(2θ)', 'tan²θ'],
          choicesEn: const ['cos(2θ)', 'sin(2θ)', 'tan²θ'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: '2x + y = 7, x – y = 1 → ?',
          promptEn: 'Solve the system.',
          choicesMn: const ['x=2, y=3', 'x=3, y=4', 'x=1, y=2'],
          choicesEn: const ['x=2, y=3', 'x=3, y=4', 'x=1, y=2'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Тэгш өнцөгт гурвалжинд нэг өнцөг 35°. Нөгөө өнцөг?',
          promptEn: 'Right triangle one acute angle is 35°.',
          choicesMn: const ['55°', '35°', '45°'],
          choicesEn: const ['55°', '35°', '45°'],
          correctIndex: 0,
        ),
      ],
      'Физик': [
        LessonQuestion.multipleChoice(
          promptMn: 'V=20V, R=4Ω → I=?',
          promptEn: 'V=20V, R=4Ω, I=?',
          choicesMn: const ['5 A', '4 A', '6 A'],
          choicesEn: const ['5 A', '4 A', '6 A'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'λ=2m, f=50Hz → v=?',
          promptEn: 'Wave speed',
          choicesMn: const ['100 m/s', '50 m/s', '25 m/s'],
          choicesEn: const ['100 m/s', '50 m/s', '25 m/s'],
          correctIndex: 0,
        ),
      ],
      'Хими': [
        LessonQuestion.multipleChoice(
          promptMn: 'H2SO4 моляр масс?',
          promptEn: 'Molar mass of H2SO4?',
          choicesMn: const ['98 g/mol', '96 g/mol', '100 g/mol'],
          choicesEn: const ['98 g/mol', '96 g/mol', '100 g/mol'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'C3H8O ямар төрлийн бодис вэ?',
          promptEn: 'C3H8O is what type?',
          choicesMn: const ['Спирт', 'Давс', 'Уусмал'],
          choicesEn: const ['Alcohol', 'Salt', 'Solution'],
          correctIndex: 0,
        ),
      ],
      'Биологи': [
        LessonQuestion.multipleChoice(
          promptMn: 'ABO цусны бүлэг аль нь зөв?',
          promptEn: 'Correct ABO blood groups?',
          choicesMn: const ['A, B, AB, O', 'A, B, O, C', 'X, Y'],
          choicesEn: const ['A, B, AB, O', 'A, B, O, C', 'X, Y'],
          correctIndex: 0,
        ),
      ],
      'Англи хэл': [
        LessonQuestion.multipleChoice(
          promptMn: '“Had I known, I ___ done it.”',
          promptEn: 'Had I known, I ___ done it.',
          choicesMn: const ['would have', 'will', 'did'],
          choicesEn: const ['would have', 'will', 'did'],
          correctIndex: 0,
        ),
        LessonQuestion.multipleChoice(
          promptMn: 'Vocabulary: “Mitigate” утга?',
          promptEn: 'Meaning of mitigate?',
          choicesMn: const ['Бууруулах', 'Нэмэх', 'Алдах'],
          choicesEn: const ['Reduce', 'Increase', 'Lose'],
          correctIndex: 0,
        ),
      ],
      'Нийгмийн ухаан': [
        LessonQuestion.multipleChoice(
          promptMn: 'Инфляци хэрхэн үүсдэг вэ?',
          promptEn: 'Inflation is when...',
          choicesMn: const ['Бараа, үйлчилгээний үнэ өсөх', 'Үнэ буурах', 'Үнэгүй'],
          choicesEn: const ['Prices rise', 'Prices fall', 'Free'],
          correctIndex: 0,
        ),
      ],
    },
  };

  static final Map<int, List<LessonQuestion>> _gradeFallback = {
    1: [
      LessonQuestion.multipleChoice(
        promptMn: '“а” үсгийг зөв бичсэн нь аль вэ?',
        promptEn: 'Which is the correct "a"?',
        choicesMn: const ['а', '@', '9'],
        choicesEn: const ['а', '@', '9'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Аль нь хөгжмийн үйлдэл вэ?',
        promptEn: 'Which is a music activity?',
        choicesMn: const ['алга таших', 'бичих', 'унших'],
        choicesEn: const ['clapping', 'writing', 'reading'],
        correctIndex: 0,
      ),
    ],
    2: [
      LessonQuestion.multipleChoice(
        promptMn: 'Аль нь их вэ?',
        promptEn: 'Which is greater?',
        choicesMn: const ['45', '67', '12'],
        choicesEn: const ['45', '67', '12'],
        correctIndex: 1,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '“This is a cat.” — зөв үү?',
        promptEn: '"This is a cat." is correct?',
        choicesMn: const ['тийм', 'үгүй', 'мэдэхгүй'],
        choicesEn: const ['yes', 'no', 'not sure'],
        correctIndex: 0,
      ),
    ],
    3: [
      LessonQuestion.multipleChoice(
        promptMn: '20-аас 7-г хасвал?',
        promptEn: '20 - 7 = ?',
        choicesMn: const ['13', '14', '12'],
        choicesEn: const ['13', '14', '12'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Аль нь үндсэн өнгө вэ?',
        promptEn: 'Which is a primary color?',
        choicesMn: const ['улаан', 'ягаан', 'саарал'],
        choicesEn: const ['red', 'pink', 'gray'],
        correctIndex: 0,
      ),
    ],
    4: [
      LessonQuestion.multipleChoice(
        promptMn: 'Периметр = 2(a+b), a=5, b=3 → ?',
        promptEn: 'Perimeter 2(a+b), a=5, b=3?',
        choicesMn: const ['16', '15', '18'],
        choicesEn: const ['16', '15', '18'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Монгол нутаг хаана байрладаг вэ?',
        promptEn: 'Where is Mongolia located?',
        choicesMn: const ['Төв Азид', 'Африк', 'Европ'],
        choicesEn: const ['Central Asia', 'Africa', 'Europe'],
        correctIndex: 0,
      ),
    ],
    5: [
      LessonQuestion.multipleChoice(
        promptMn: 'Периметр = 2(a+b), a=6, b=3 → ?',
        promptEn: 'Perimeter 2(a+b), a=6, b=3?',
        choicesMn: const ['18', '15', '12'],
        choicesEn: const ['18', '15', '12'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Эртний иргэншлийн жишээ?',
        promptEn: 'Example of ancient civilization?',
        choicesMn: const ['Египет', 'Хар ус', 'Мод'],
        choicesEn: const ['Egypt', 'Black water', 'Tree'],
        correctIndex: 0,
      ),
    ],
    6: [
      LessonQuestion.multipleChoice(
        promptMn: '3/5 нь 15-ийн хэд вэ?',
        promptEn: '3/5 of 15 is?',
        choicesMn: const ['9', '10', '8'],
        choicesEn: const ['9', '10', '8'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Монгол хаана байрладаг вэ?',
        promptEn: 'Where is Mongolia located?',
        choicesMn: const ['Азид', 'Европ', 'Африк'],
        choicesEn: const ['Asia', 'Europe', 'Africa'],
        correctIndex: 0,
      ),
    ],
    7: [
      LessonQuestion.multipleChoice(
        promptMn: '3y – 9 = 0 → y=?',
        promptEn: '3y - 9 = 0 → y=?',
        choicesMn: const ['3', '0', '6'],
        choicesEn: const ['3', '0', '6'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Aжил = хүч × зай. 5N × 2m = ?',
        promptEn: 'Work = force × distance. 5N × 2m = ?',
        choicesMn: const ['10 J', '7 J', '12 J'],
        choicesEn: const ['10 J', '7 J', '12 J'],
        correctIndex: 0,
      ),
    ],
    8: [
      LessonQuestion.multipleChoice(
        promptMn: '36 ÷ 6 = ?',
        promptEn: '36 ÷ 6 = ?',
        choicesMn: const ['6', '5', '7'],
        choicesEn: const ['6', '5', '7'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '5x – 7 = 18 → x=?',
        promptEn: '5x - 7 = 18 → x=?',
        choicesMn: const ['5', '4', '6'],
        choicesEn: const ['5', '4', '6'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Grammar: “If I ___ rich, I would travel.”',
        promptEn: 'If I ___ rich, I would travel.',
        choicesMn: const ['were', 'am', 'be'],
        choicesEn: const ['were', 'am', 'be'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Хурд = зай/цаг. 50 км/2 цаг = ?',
        promptEn: '50 km / 2 hours = ?',
        choicesMn: const ['25 км/цаг', '20 км/цаг', '30 км/цаг'],
        choicesEn: const ['25 km/h', '20 km/h', '30 km/h'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'C2H5OH ямар төрлийн бодис вэ?',
        promptEn: 'C2H5OH is what type?',
        choicesMn: const ['спирт', 'хүчил', 'давс'],
        choicesEn: const ['alcohol', 'acid', 'salt'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Эдийн засаг: Бараа эрэлт их бол үнэ?',
        promptEn: 'If demand increases, price...',
        choicesMn: const ['Их', 'Бага', 'Үнэгүй'],
        choicesEn: const ['Higher', 'Lower', 'Free'],
        correctIndex: 0,
      ),
    ],
    9: [
      LessonQuestion.multipleChoice(
        promptMn: 'y = 2x, x=3 → y=?',
        promptEn: 'y = 2x, x=3 → y=?',
        choicesMn: const ['6', '5', '7'],
        choicesEn: const ['6', '5', '7'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '2x + 5 = 17 → x=?',
        promptEn: '2x + 5 = 17 → x=?',
        choicesMn: const ['6', '5', '7'],
        choicesEn: const ['6', '5', '7'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '√49 = ?',
        promptEn: '√49 = ?',
        choicesMn: const ['7', '6', '8'],
        choicesEn: const ['7', '6', '8'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'V = s/t, s=100m, t=20s → V=?',
        promptEn: 'V=s/t, s=100m, t=20s → V=?',
        choicesMn: const ['5 m/s', '4 m/s', '6 m/s'],
        choicesEn: const ['5 m/s', '4 m/s', '6 m/s'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '5Ω-т 10V → гүйдэл=?',
        promptEn: '10V across 5Ω, current?',
        choicesMn: const ['2 A', '5 A', '10 A'],
        choicesEn: const ['2 A', '5 A', '10 A'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Vocabulary: “Delicious” утга?',
        promptEn: 'Meaning of "Delicious"?',
        choicesMn: const ['Амттай', 'Амтгүй', 'Хүйтэн'],
        choicesEn: const ['Tasty', 'Tasteless', 'Cold'],
        correctIndex: 0,
      ),
    ],
    10: [
      LessonQuestion.multipleChoice(
        promptMn: '2x + 5 < 15 → ?',
        promptEn: '2x + 5 < 15 → ?',
        choicesMn: const ['x < 5', 'x > 5', 'x = 5'],
        choicesEn: const ['x < 5', 'x > 5', 'x = 5'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '3x – 7 = 11 → x=?',
        promptEn: '3x - 7 = 11 → x=?',
        choicesMn: const ['6', '5', '7'],
        choicesEn: const ['6', '5', '7'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'y = 2x + 3, x=4 → y=?',
        promptEn: 'y = 2x + 3, x=4 → y=?',
        choicesMn: const ['11', '10', '12'],
        choicesEn: const ['11', '10', '12'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'H2O-ийн моляр масс?',
        promptEn: 'Molar mass of H2O?',
        choicesMn: const ['18 g/mol', '16 g/mol', '20 g/mol'],
        choicesEn: const ['18 g/mol', '16 g/mol', '20 g/mol'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '100 N хүч 2 м зайд → ажил=?',
        promptEn: 'Work for 100N over 2m?',
        choicesMn: const ['200 J', '100 J', '50 J'],
        choicesEn: const ['200 J', '100 J', '50 J'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Grammar: “I ___ seen that movie.”',
        promptEn: 'I ___ seen that movie.',
        choicesMn: const ['have', 'has', 'had'],
        choicesEn: const ['have', 'has', 'had'],
        correctIndex: 0,
      ),
    ],
    11: [
      LessonQuestion.multipleChoice(
        promptMn: 'sin²θ + cos²θ = ?',
        promptEn: 'sin²θ + cos²θ = ?',
        choicesMn: const ['1', '0', 'sinθ'],
        choicesEn: const ['1', '0', 'sinθ'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '2^x = 32 → x=?',
        promptEn: '2^x = 32 → x=?',
        choicesMn: const ['5', '4', '6'],
        choicesEn: const ['5', '4', '6'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'log₂8 = ?',
        promptEn: 'log₂8 = ?',
        choicesMn: const ['3', '2', '4'],
        choicesEn: const ['3', '2', '4'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '5 хүнээс 2-г сонгох арга?',
        promptEn: 'Ways to choose 2 from 5?',
        choicesMn: const ['10', '20', '15'],
        choicesEn: const ['10', '20', '15'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Vocabulary: “Sustainable” утга?',
        promptEn: 'Meaning of sustainable?',
        choicesMn: const ['Тогтвортой', 'Түр зуурын', 'Хүчирхэг'],
        choicesEn: const ['Sustainable', 'Temporary', 'Strong'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Mendel: Aa x Aa үр дүн?',
        promptEn: 'Aa x Aa gives?',
        choicesMn: const ['AA, Aa, aa', 'AA, AA, Aa', 'Aa, aa, Aa'],
        choicesEn: const ['AA, Aa, aa', 'AA, AA, Aa', 'Aa, aa, Aa'],
        correctIndex: 0,
      ),
    ],
    12: [
      LessonQuestion.multipleChoice(
        promptMn: 'cos²θ – sin²θ = ?',
        promptEn: 'cos²θ - sin²θ = ?',
        choicesMn: const ['cos(2θ)', 'sin(2θ)', 'tan²θ'],
        choicesEn: const ['cos(2θ)', 'sin(2θ)', 'tan²θ'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '2x + y = 7, x – y = 1 → ?',
        promptEn: '2x + y = 7, x - y = 1 → ?',
        choicesMn: const ['x=2, y=3', 'x=3, y=4', 'x=1, y=2'],
        choicesEn: const ['x=2, y=3', 'x=3, y=4', 'x=1, y=2'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'y = sin(x) → dy/dx=?',
        promptEn: 'Derivative of sin(x)?',
        choicesMn: const ['cos(x)', 'sin(x)', '-cos(x)'],
        choicesEn: const ['cos(x)', 'sin(x)', '-cos(x)'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: '∫(2x dx) = ?',
        promptEn: '∫(2x dx) = ?',
        choicesMn: const ['x² + C', '2x² + C', 'x + C'],
        choicesEn: const ['x² + C', '2x² + C', 'x + C'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'V=20V, R=4Ω → I=?',
        promptEn: 'V=20V, R=4Ω, I=?',
        choicesMn: const ['5 A', '4 A', '6 A'],
        choicesEn: const ['5 A', '4 A', '6 A'],
        correctIndex: 0,
      ),
      LessonQuestion.multipleChoice(
        promptMn: 'Vocabulary: “Mitigate” утга?',
        promptEn: 'Meaning of mitigate?',
        choicesMn: const ['Бууруулах', 'Нэмэх', 'Алдах'],
        choicesEn: const ['Reduce', 'Increase', 'Lose'],
        correctIndex: 0,
      ),
    ],
  };

  static List<LessonQuestion> questionsFor({
    required int grade,
    required String subject,
  }) {
    final byGrade = _bank[grade];
    if (byGrade == null) return const [];

    if (byGrade.containsKey(subject)) {
      return _mergeWithGradeFallback(grade, byGrade[subject]!);
    }

    final normalized = subject.toLowerCase().trim();
    final aliases = _subjectAliases(normalized);
    for (final alias in aliases) {
      for (final e in byGrade.entries) {
        final key = e.key.toLowerCase();
        if (alias == key || alias.contains(key) || key.contains(alias)) {
          return _mergeWithGradeFallback(grade, e.value);
        }
      }
    }

    for (final e in byGrade.entries) {
      if (normalized.contains(e.key.toLowerCase()) || e.key.toLowerCase().contains(normalized)) {
        return _mergeWithGradeFallback(grade, e.value);
      }
    }
    return _gradeFallback[grade] ?? const [];
  }

  static List<LessonQuestion> _mergeWithGradeFallback(int grade, List<LessonQuestion> primary) {
    final fallback = _gradeFallback[grade] ?? const <LessonQuestion>[];
    if (fallback.isEmpty) return primary;
    final merged = <LessonQuestion>[...primary];
    for (final q in fallback) {
      final exists = merged.any((m) => m.promptMn == q.promptMn && m.type == q.type);
      if (!exists) merged.add(q);
    }
    return merged;
  }

  static List<String> _subjectAliases(String subject) {
    final out = <String>{subject};
    if (subject.contains('монгол')) out.add('монгол хэл');
    if (subject.contains('мат')) out.add('математик');
    if (subject.contains('англи') || subject.contains('english')) out.add('англи хэл');
    if (subject.contains('дүрслэх') || subject.contains('art')) out.add('дүрслэх урлаг');
    if (subject.contains('хөгжим') || subject.contains('music')) out.add('хөгжим');
    if (subject.contains('байгаль') || subject.contains('nature')) out.add('байгаль');
    if (subject.contains('физик') || subject.contains('physics')) out.add('физик');
    if (subject.contains('хими') || subject.contains('chem')) out.add('хими');
    if (subject.contains('биологи') || subject.contains('bio')) out.add('биологи');
    if (subject.contains('нийгэм') || subject.contains('social')) out.add('нийгмийн ухаан');
    if (subject.contains('түүх') || subject.contains('history')) out.add('түүх');

    // Mixed curriculum labels in grade data.
    if (subject.contains('түүх / байгаль') || subject.contains('байгаль / түүх')) {
      out.addAll(['түүх', 'байгаль', 'нийгмийн ухаан']);
    }
    if (subject.contains('байгаль / нийгэм') || subject.contains('нийгэм / байгаль')) {
      out.addAll(['байгаль', 'нийгмийн ухаан']);
    }
    if (subject.contains('түүх / нийгэм') || subject.contains('нийгэм / түүх')) {
      out.addAll(['түүх', 'нийгмийн ухаан']);
    }
    return out.toList();
  }
}

