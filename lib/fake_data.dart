import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffinder/Models/chat.dart';
import 'package:coffinder/Models/location.dart';
import 'package:coffinder/Models/match.dart';
import 'package:coffinder/Models/message.dart';
import 'package:coffinder/Models/user.dart';
import 'package:coffinder/Models/user_images.dart';

class FakeData {
  String fakeCurrentUserUID = '1';

  List<String> images = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Outdoors-man-portrait_%28cropped%29.jpg/1200px-Outdoors-man-portrait_%28cropped%29.jpg',
    'https://ultraluksyasam.com/wp-content/uploads/2023/02/Cagatay-Ulusoy-2.jpg',
    'https://hips.hearstapps.com/hmg-prod/images/Emma-Watson_GettyImages-619546914.jpg',
    'https://i.pinimg.com/originals/66/d2/6f/66d26f8d83fe74bed6972025b4c5b29d.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Jeremy_Meeks_Mug_Shot.jpg/640px-Jeremy_Meeks_Mug_Shot.jpg',
    'https://youthscape.ams3.cdn.digitaloceanspaces.com/images/16723620780107.remini-enhanced.jpg',
    'https://i.hbrcdn.com/haber/2022/11/22/hadise-instagram-paylasimi-nedir-hadise-ne-dedi-15446459_9567_amp.jpg',
    'https://i.pinimg.com/originals/0b/4b/33/0b4b337a5ade62a298df91c267d6ee3e.jpg',
    'https://previews.123rf.com/images/mehmetcan/mehmetcan1711/mehmetcan171101048/89506569-beautiful-girl-drinking-coffee-at-the-coffee-shop.jpg',
    'https://cdn2.stylecraze.com/wp-content/uploads/2021/11/Benefits-Of-Drinking-Coffee.jpg',
    'https://ichef.bbci.co.uk/news/976/cpsprodpb/7BA4/production/_100825613_gettyimages-496948478-1.jpg',
    'https://e0.365dm.com/22/10/1600x900/skysports-jake-paul-hasim-rahman-jr_5949975.jpg?20221031140146'
  ];

  List<Match> fakeMatches = [
    Match(matchId: '1', user1Id: '1', user2Id: '2', locationId: '1'),
    Match(matchId: '2', user1Id: '1', user2Id: '3', locationId: '1'),
    Match(matchId: '3', user1Id: '1', user2Id: '4', locationId: '1'),
    Match(matchId: '4', user1Id: '1', user2Id: '5', locationId: '1'),
    Match(matchId: '5', user1Id: '1', user2Id: '6', locationId: '1'),
    Match(matchId: '6', user1Id: '1', user2Id: '7', locationId: '1'),
    Match(matchId: '7', user1Id: '1', user2Id: '8', locationId: '1'),
  ];

  List<User> users = [
    User(
        name: 'Bora',
        uid: '1',
        email: 'b@g.com',
        gender: 'Erkek',
        age: 18,
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp())
        ])),
    User(
        name: 'Ceyda',
        uid: '2',
        email: 'c@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Kadın',
        age: 18),
    User(
        name: 'Ali',
        uid: '3',
        email: 'a@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Erkek',
        age: 18),
    User(
        name: 'Berke',
        uid: '4',
        email: 'be@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Erkek',
        age: 18),
    User(
        name: 'Sena',
        uid: '5',
        email: 'sen@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Kadın',
        age: 18),
    User(
        name: 'Bobo',
        uid: '6',
        email: 'bob@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Erkek',
        age: 18),
    User(
        name: 'Ceydog',
        uid: '7',
        email: 'cey@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Kadın',
        age: 18),
    User(
        name: 'Kalman',
        uid: '8',
        email: 'kal@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Erkek',
        age: 18),
    User(
        name: 'Shervin',
        uid: '9',
        email: 'she@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Erkek',
        age: 18),
    User(
        name: 'Hamdi',
        uid: '10',
        email: 'h@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Erkek',
        age: 18),
    User(
        name: 'Ceydawg',
        uid: '11',
        email: 'dawg@g.com',
        userImages: UserImages(images: [
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=9',
              timestamp: DateTime.timestamp()),
          UserImage(
              imageId: '1',
              imageUrl: 'https://picsum.photos/250?image=10',
              timestamp: DateTime.timestamp())
        ]),
        gender: 'Kadın',
        age: 18),
  ];

  User? getUser({required String userId}) {
    User? retrievedUser;
    for (var user in users) {
      if (user.uid == userId) {
        retrievedUser = user;
      }
    }
    return retrievedUser;
  }

  List<Message> messages = [
    Message(
        senderId: '1',
        messageText: 'Hello!',
        timestamp: Timestamp.now(),
        messageId: '1',
        receiverId: '2'),
    Message(
        senderId: '2',
        messageText: 'Hi there!',
        timestamp: Timestamp.now(),
        messageId: '2',
        receiverId: '1'),
    Message(
        senderId: '1',
        messageText: 'How are you?',
        timestamp: Timestamp.now(),
        messageId: '3',
        receiverId: '2'),
    Message(
        senderId: '3',
        messageText: 'Boraaa napoıyon!',
        timestamp: Timestamp.now(),
        messageId: '4',
        receiverId: '1'),
    Message(
        senderId: '1',
        messageText: 'Thats great!',
        timestamp: Timestamp.now(),
        messageId: '5',
        receiverId: ''),
    Message(
        senderId: '4',
        messageText: 'Hey! Choom!',
        timestamp: Timestamp.now(),
        messageId: '6',
        receiverId: '1'),
    Message(
        senderId: '1',
        messageText: 'Prove me you are not a fake bitch AHSHHASH!',
        timestamp: Timestamp.now(),
        messageId: '7',
        receiverId: '2'),
    Message(
        senderId: '2',
        messageText: 'The fuck are you talking about?!',
        timestamp: Timestamp.now(),
        messageId: '8',
        receiverId: '1'),
    Message(
        senderId: '1',
        messageText: 'Sorry that was my pick up Line',
        timestamp: Timestamp.now(),
        messageId: '9',
        receiverId: '2'),
    Message(
        senderId: '1',
        messageText: 'I can buy you a coffee as an aplogoy',
        timestamp: Timestamp.now(),
        messageId: '10',
        receiverId: '2'),
    Message(
        senderId: '2',
        messageText: 'Get lost retard',
        timestamp: Timestamp.now(),
        messageId: '11',
        receiverId: '1'),
    Message(
        senderId: '1',
        messageText: 'They rotting my brain oh. ',
        timestamp: Timestamp.now(),
        messageId: '12',
        receiverId: '2'),
    Message(
        senderId: '1',
        messageText: 'Ne bakıon amcık!',
        timestamp: Timestamp.now(),
        messageId: '13',
        receiverId: '4'),
    Message(
        senderId: '2',
        messageText: 'Türk müsün?',
        timestamp: Timestamp.now(),
        messageId: '14',
        receiverId: '1'),
    Message(
        senderId: '2',
        messageText: 'Napiyim?',
        timestamp: Timestamp.now(),
        messageId: '15',
        receiverId: '1'),
    Message(
        senderId: '1',
        messageText: 'XDDDDDD?',
        timestamp: Timestamp.now(),
        messageId: '16',
        receiverId: '2'),
    Message(
        senderId: '1',
        messageText:
            'Sen hep böyle yap zalimin kalbini koparırcasına yol benim ruhumu. Kedilere et verir gibi zargana ol. bisepslerini sikem sokam am koyam ',
        timestamp: Timestamp.now(),
        messageId: '17',
        receiverId: '2'),
    Message(
        senderId: '2',
        messageText: 'Tövbe töve',
        timestamp: Timestamp.now(),
        messageId: '18',
        receiverId: '1'),
    Message(
        senderId: '1',
        messageText: 'Mübarek kokulu musun? severim de',
        timestamp: Timestamp.now(),
        messageId: '19',
        receiverId: '2'),
    Message(
        senderId: '2',
        messageText: 'no',
        timestamp: Timestamp.now(),
        messageId: '20',
        receiverId: '1'),
    Message(
        senderId: '1',
        messageText:
            'Mübarek koky yoksa ben yokum. Hadi ben kaçtım AKJSLDNAJOKLDNAJLDNAŞJLDNALJ',
        timestamp: Timestamp.now(),
        messageId: '21',
        receiverId: '2'),
    Message(
        senderId: '2',
        messageText: 'Komik mi lan!',
        timestamp: Timestamp.now(),
        messageId: '22',
        receiverId: '1'),
  ];

  List<Location> locations = [
    Location(
        locationId: '1', name: 'Starbucks', latitude: 10.0, longitude: 10.0),
    Location(locationId: '2', name: 'Federal', latitude: 10.0, longitude: 10.0),
    Location(locationId: '3', name: 'Bluejay', latitude: 10.0, longitude: 10.0),
    Location(
        locationId: '4', name: 'Coffee Break', latitude: 10.0, longitude: 10.0),
    Location(
        locationId: '5',
        name: 'Kahve Dünyası',
        latitude: 10.0,
        longitude: 10.0),
  ];

  returnFakeChatModels() {
    List<Chat> chatList = [
      Chat(
          chatId: '1',
          participants: ['1', '2'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: 'hi',
              timestamp: Timestamp.now(),
              receiverId: '1')),
      Chat(
          chatId: '2',
          participants: ['1', '3'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: 'wassup',
              timestamp: Timestamp.now(),
              receiverId: '1')),
      Chat(
          chatId: '3',
          participants: ['1', '4'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: 'Nice ass!',
              timestamp: Timestamp.now(),
              receiverId: '')),
      Chat(
          chatId: '4',
          participants: ['1', '5'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: 'I want to buy you a coffee',
              timestamp: Timestamp.now(),
              receiverId: '1')),
      Chat(
          chatId: '5',
          participants: ['1', '6'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: 'I want to buy you a coffee',
              timestamp: Timestamp.now(),
              receiverId: '1')),
      Chat(
          chatId: '6',
          participants: ['1', '7'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: 'I want to buy you a coffee',
              timestamp: Timestamp.now(),
              receiverId: '1')),
      Chat(
          chatId: '7',
          participants: ['1', '8'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: '',
              timestamp: Timestamp.now(),
              receiverId: '1')),
      Chat(
          chatId: '8',
          participants: ['1', '9'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: '',
              timestamp: Timestamp.now(),
              receiverId: '1')),
      Chat(
          chatId: '9',
          participants: ['1', '10'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText: '',
              timestamp: Timestamp.now(),
              receiverId: '1')),
      Chat(
          chatId: '10',
          participants: ['1', '11'],
          locationId: '1',
          locationName: 'Starbucks',
          lastMessage: Message(
              messageId: '1',
              senderId: '1',
              messageText:
                  'asasdas dasd as das das dasdassada asdsad asd asd asd ',
              timestamp: Timestamp.now(),
              receiverId: '1')),
    ];
    return chatList;
  }
}
