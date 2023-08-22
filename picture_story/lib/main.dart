import 'package:flutter/material.dart';
import 'package:picture_story/text_to_speech.dart';

void main() {
  runApp(PictureStoryApp());
}

class PictureStoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture Story Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StoryLibraryScreen(),
    );
  }
}

class StoryLibraryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Library'),
      ),
      body: ListView.builder(
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the story viewer screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StoryViewerScreen(story: storyList[index]),
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    storyList[index].coverImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 16.0),
                  Text(
                    storyList[index].title,
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class StoryViewerScreen extends StatelessWidget {

  TextToSpeech textToSpeech = TextToSpeech();
  final Story story;

  StoryViewerScreen({required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(story.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              story.coverImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                story.content,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                 textToSpeech.speak(story.content);
              },
              child: Text('Read Aloud'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () => textToSpeech.stopSpeak(),
             child: Text("Stop")
             )
          ],
        ),
      ),
    );
  }
}

class Story {
  final String title;
  final String coverImage;
  final String content;

  Story({required this.title, required this.coverImage, required this.content});
}

// Dummy data
List<Story> storyList = [
  Story(
    title: 'The Adventure of Alex',
    coverImage: 'assets/alex.png',
    content:
        'Once upon a time, in a small village nestled between towering mountains and lush forests, lived a curious and adventurous boy named Alex. He had always dreamt of embarking on incredible journeys and uncovering hidden treasures. One bright morning, as the sun painted the sky with shades of gold, Alex decided that today was the day he would begin his grand adventure.'
        'Equipped with a backpack filled with snacks, a map, and a heart full of courage, Alex set out on his journey. His path led him through dense woods and over babbling brooks. Along the way, he encountered talking animals who offered advice and kind words. A wise old owl shared stories of ancient legends and whispered about a hidden realm known as the Enchanted Forest.'
        'With newfound excitement, Alex followed the owls guidance and soon found himself standing before a shimmering veil of mist. As he stepped through, the world transformed around him. Trees glowed with soft light, flowers danced to a gentle melody, and the air hummed with magic. This was the Enchanted Forest.',
  ),
  Story(
      title: "A thirsty Corw",
      coverImage: 'assets/thirsty crow.png',
      content:
          ' It was summer. A crow was very thirsty. He flew here and there in search of water. Suddenly he saw a pitcher. There was a little water at the bottom of the pitcher. The crow tried to drink the water but could not drink it. He then tried to overturn the pitcher but failed again. He saw some pebbles nearby. At last the crow hit upon a plan. He picked them up and dropped one by one into the pitcher.The water soon rose up to the brim. The crow drank water to its heart’s content. In this way he quenched his thirst and flew away happily.'),
  Story(
      title: "Monkey and Cap Seller",
      coverImage: "assets/CAP SELLER.png",
      content:
          'Monkey and the Cap Seller’ is based on a folktale that follows the story of a cap-selling street vendor and a troupe of monkeys. The original version of this children’s picture book was called ‘Caps for Sale: A Tale of a Peddler, Some Monkeys, and Their Monkey Business.’ It was written and illustrated by Esphyr Slobodkina and published by W R Scott in 1940. This story has many adaptations, and even sequels have been made on it. This popular read-aloud book is one of the best-known works of Siobodkina as it contains repetitive texts that encourage kids to join in the reading experience. It includes easy words so kids can understand and learn the story quickly.')
  // Add more stories here
];
