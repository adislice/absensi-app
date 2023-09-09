import 'package:flutter/material.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  List<Quote> quotes = [
    Quote(
        text: "Be yourself; everyone else is already taken",
        author: "Oscar Wilde"),
    Quote(
        text: "I have nothing to declare except my genius",
        author: "Oscar Wilde"),
    Quote(text: "So many books, so little time", author: "Frank Zappa"),
    Quote(
        text: "Be who you are and say what you feel",
        author: "William W. Purkey"),
    Quote(
        text: "A room without books is like a body without a soul",
        author: "Marcus Tullius Cicero"),
    Quote(
        text: "Be yourself; everyone else is already taken",
        author: "Oscar Wilde"),
    Quote(
        text: "I have nothing to declare except my genius",
        author: "Oscar Wilde"),
    Quote(text: "So many books, so little time", author: "Frank Zappa"),
    Quote(
        text: "Be who you are and say what you feel",
        author: "William W. Purkey"),
    Quote(
        text: "A room without books is like a body without a soul",
        author: "Marcus Tullius Cicero"),
    Quote(
        text: "Be yourself; everyone else is already taken",
        author: "Oscar Wilde"),
    Quote(
        text: "I have nothing to declare except my genius",
        author: "Oscar Wilde"),
    Quote(text: "So many books, so little time", author: "Frank Zappa"),
    Quote(
        text: "Be who you are and say what you feel",
        author: "William W. Purkey"),
    Quote(
        text: "A room without books is like a body without a soul",
        author: "Marcus Tullius Cicero"),
    Quote(
        text: "Be yourself; everyone else is already taken",
        author: "Oscar Wilde"),
    Quote(
        text: "I have nothing to declare except my genius",
        author: "Oscar Wilde"),
    Quote(text: "So many books, so little time", author: "Frank Zappa"),
    Quote(
        text: "Be who you are and say what you feel",
        author: "William W. Purkey"),
    Quote(
        text: "A room without books is like a body without a soul",
        author: "Marcus Tullius Cicero"),
  ];

  Widget cardTemplate(Quote quote) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              quote.text,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "- ${quote.author}",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withAlpha(180),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: Text("Quotes"),
            centerTitle: true,
          ),
          SliverList.list(children: quotes.map((quote) => cardTemplate(quote)).toList()),
        ],
      ),
    );
  }
}

class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});
}
