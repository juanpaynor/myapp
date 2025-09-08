
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PersonalityTestPage extends StatefulWidget {
  final String? fullName;
  final String? age;

  const PersonalityTestPage({super.key, this.fullName, this.age});

  @override
  State<PersonalityTestPage> createState() => _PersonalityTestPageState();
}

class _PersonalityTestPageState extends State<PersonalityTestPage> {
  final PageController _pageController = PageController();
  final Map<int, int> _answers = {};

  // A more fun and food-themed question set
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'A new restaurant opens up. You are...',
      'options': [
        {'text': 'First in line, gotta try it now!', 'icon': Icons.restaurant_menu},
        {'text': 'Waiting for the reviews to roll in.', 'icon': Icons.rate_review},
        {'text': 'Going with a big group of friends.', 'icon': Icons.people},
        {'text': 'Checking if they have my favorite comfort food.', 'icon': Icons.favorite},
      ],
    },
    {
      'question': 'Your ideal Friday night involves...',
      'options': [
        {'text': 'A quiet, gourmet meal at home.', 'icon': Icons.home},
        {'text': 'A bustling food market adventure.', 'icon': Icons.storefront},
        {'text': 'A potluck dinner with loved ones.', 'icon': Icons.food_bank},
        {'text': 'Trying the spiciest dish I can find.', 'icon': Icons.whatshot},
      ],
    },
    {
      'question': 'When it comes to sharing food, you...',
      'options': [
        {'text': 'Believe sharing is caring, have a bite!', 'icon': Icons.plus_one},
        {'text': 'Order extra just for sharing.', 'icon': Icons.card_giftcard},
        {'text': 'Have a strict "no-sharing" policy.', 'icon': Icons.block},
        {'text': 'Swap a bite of mine for a bite of yours.', 'icon': Icons.swap_horiz},
      ],
    },
  ];

  void _nextPage(int questionIndex, int optionIndex) {
    setState(() {
      _answers[questionIndex] = optionIndex;
    });
    if (questionIndex < _questions.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // All questions answered, navigate to summary
      _showSummary();
    }
  }

  void _showSummary() {
    // In a real app, a more sophisticated algorithm would be used.
    int personalityScore = _answers.values.fold(0, (sum, item) => sum + item);
    String personalityType = "The Social Savorer"; // Default
    if (personalityScore <= 2) {
      personalityType = "The Flavor Explorer";
    } else if (personalityScore <= 4) {
      personalityType = "The Comfort Connoisseur";
    } else {
      personalityType = "The Adventurous Appetizer";
    }

    context.go('/summary?personality=$personalityType');
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              child: Text(
                'Tell Us a Bit About Your Tastes!',
                style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swiping
                itemCount: _questions.length,
                itemBuilder: (context, index) {
                  return _buildQuestionCard(_questions[index], index);
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(Map<String, dynamic> questionData, int questionIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            questionData['question'],
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(height: 1.4),
          ),
          const SizedBox(height: 40),
          ...List.generate(questionData['options'].length, (optionIndex) {
            final option = questionData['options'][optionIndex];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: ListTile(
                leading: Icon(option['icon'], size: 28),
                title: Text(option['text']),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                onTap: () => _nextPage(questionIndex, optionIndex),
              ),
            );
          }),
        ],
      ),
    );
  }
}
