import 'package:academe_x/features/home/domain/entities/create_post/tag.dart';

import '../core.dart';
import '../../features/home/home.dart';

class MockData {
  static final List<PostEntity> posts = [
    PostEntity(
      userId: '1',
      username: 'حسين غباين',
      userAvatar: AppAssets.defaultAvatar,
      timeAgo: 'الان',
      content:
          'مرحبا كيف الحال اليوم جبتلكم ملفات مهمة,مرحبا كيف الحال اليوم جبتلكم ملفات مهمةمرحبا كيف الحال اليوم جبتلكم ملفات مهمةمرحبا كيف الحال اليوم جبتلكم ملفات مهمة',
      type: PostType.textWithFile,
      likesCount: 450,
      fileName: 'Flutter Projects',
      commentsCount: 201,
      sharesCount: 150,
    ),
    PostEntity(
      userId: '1',
      username: 'حسين غباين',
      userAvatar:
          'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
      timeAgo: 'الان',
      content: 'مرحبا كيف الحال اليوم جبتلكم ملفات مهمة',
      images: [
        'https://cdn.pixelbin.io/v2/dummy-cloudname/EEM2O3/original/619340761ca096a589ca891f/66c47e28ee26e35883181545_66c47d762975b12fcc9d8b71_1.webp',
        'https://static.wixstatic.com/media/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png/v1/fill/w_980,h_553,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png',
        'https://static.wixstatic.com/media/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png/v1/fill/w_980,h_553,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png',
        'https://cdn.pixelbin.io/v2/dummy-cloudname/EEM2O3/original/619340761ca096a589ca891f/66c47e28ee26e35883181545_66c47d762975b12fcc9d8b71_1.webp'
      ],
      type: PostType.textWithFile,
      likesCount: 450,
      fileName: 'Flutter Projects',
      commentsCount: 201,
      sharesCount: 150,
    ),
    PostEntity(
        userId: '2',
        username: 'ابراهيم العكلوك',
        userAvatar:
            'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
        timeAgo: 'منذ 4 دقائق',
        content: 'مرحبا كيف الحال',
        images: [
          'https://cdn.pixelbin.io/v2/dummy-cloudname/EEM2O3/original/619340761ca096a589ca891f/66c47e28ee26e35883181545_66c47d762975b12fcc9d8b71_1.webp',
          'https://static.wixstatic.com/media/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png/v1/fill/w_980,h_553,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png',
          'https://static.wixstatic.com/media/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png/v1/fill/w_980,h_553,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png',
          'https://cdn.pixelbin.io/v2/dummy-cloudname/EEM2O3/original/619340761ca096a589ca891f/66c47e28ee26e35883181545_66c47d762975b12fcc9d8b71_1.webp'
        ],
        type: PostType.textOnly,
        likesCount: 13,
        commentsCount: 2,
        sharesCount: 1,
        reactionUsers: [
          ReactionUser(
              userId: '1',
              name: 'حسين غباين',
              avatarUrl:
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
              reactionType: ReactionType.insightful),
          ReactionUser(
              userId: '1',
              name: 'حسين غباين',
              avatarUrl:
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
              reactionType: ReactionType.insightful),
          ReactionUser(
              userId: '2',
              name: 'ابراهيم العكلوك',
              avatarUrl:
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
              reactionType: ReactionType.heart),
        ]),
    PostEntity(
        userId: '3',
        username: 'خالد الخليلي',
        userAvatar:
            'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
        timeAgo: 'منذ 7 دقائق',
        content: 'مرحبا كيف الحال',
        images: [
          'https://cdn.pixelbin.io/v2/dummy-cloudname/EEM2O3/original/619340761ca096a589ca891f/66c47e28ee26e35883181545_66c47d762975b12fcc9d8b71_1.webp',
          'https://static.wixstatic.com/media/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png/v1/fill/w_980,h_553,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png',
          'https://static.wixstatic.com/media/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png/v1/fill/w_980,h_553,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png',
          'https://cdn.pixelbin.io/v2/dummy-cloudname/EEM2O3/original/619340761ca096a589ca891f/66c47e28ee26e35883181545_66c47d762975b12fcc9d8b71_1.webp'
        ],
        type: PostType.textWithImage,
        likesCount: 10,
        commentsCount: 21,
        sharesCount: 0,
        reactionUsers: [
          ReactionUser(
              userId: '1',
              name: 'حسين غباين',
              avatarUrl:
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
              reactionType: ReactionType.heart),
          ReactionUser(
              userId: '2',
              name: 'ابراهيم العكلوك',
              avatarUrl:
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
              reactionType: ReactionType.heart)
        ]),
    PostEntity(
        userId: '4',
        username: 'براء مبارك',
        userAvatar:
            'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
        timeAgo: 'منذ 40 دقائق',
        content: 'اليوم بدي اعمل تصويت لاختيار انسب وقت للامتحان',
        images: [
          'https://cdn.pixelbin.io/v2/dummy-cloudname/EEM2O3/original/619340761ca096a589ca891f/66c47e28ee26e35883181545_66c47d762975b12fcc9d8b71_1.webp',
          'https://static.wixstatic.com/media/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png/v1/fill/w_980,h_553,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png',
          'https://static.wixstatic.com/media/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png/v1/fill/w_980,h_553,al_c,q_90,usm_0.66_1.00_0.01,enc_auto/919b05_e3d12f7b87a245f0a7f80234388ee981~mv2.png',
          'https://cdn.pixelbin.io/v2/dummy-cloudname/EEM2O3/original/619340761ca096a589ca891f/66c47e28ee26e35883181545_66c47d762975b12fcc9d8b71_1.webp'
        ],
        type: PostType.textWithPoll,
        pollOptions: {
          'السبت': 40,
          'الاحد': 0,
          'الاثنين': 50,
        },
        likesCount: 1,
        commentsCount: 0,
        sharesCount: 8,
        reactionUsers: [
          ReactionUser(
              userId: '1',
              name: 'حسين غباين',
              avatarUrl:
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
              reactionType: ReactionType.heart),
          ReactionUser(
              userId: '2',
              name: 'ابراهيم العكلوك',
              avatarUrl:
                  'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?semt=ais_hybrid',
              reactionType: ReactionType.heart)
        ])
    // ... rest of your mock posts
  ];

  static final List<Map<String, String>> categories = [
    {'عام': 'assets/images/image_test1.png'},
    {'تطوير برمجيات': 'assets/images/image_test1.png'},
    {'علم حاسوب': 'assets/images/image_test1.png'},
    {'حوسبة متنقلة': 'assets/images/image_test1.png'},
    {'وسائط متعددة': 'assets/images/image_test1.png'},
  ];
  static final List<Tag> tags = [
    Tag(id: 1, tagName: "#تطوير برمجيات"),
  ];
  static final List<Comment> comments = [
    Comment(
      commenter: 'Baraa',
      commentText:
          ' حتوى رائع استمر يا عبقري العباقر محتوى رائع استمر يا عبقري العباقرة',
      likes: 70,
      createdAt: DateTime.now(),
      replies: [
        Comment(
            commenter: 'Ahmed 8 Dadar',
            commentText:
                ' حتوى رائع استمر يا عبقري العباقر حتوى رائع استمر يا عبقري العباقر محتوى رائع استمر يا عبقري العباقرة',
            likes: 70,
            createdAt: DateTime.now()),
        Comment(
            commenter: 'Hussen 8 GHabayen',
            commentText: 'محتوى رائع استمر يا عبقري العباقرة',
            likes: 70,
            createdAt: DateTime.now()),
        Comment(
            commenter: 'Alaa 8 Mubarak',
            commentText: 'محتوى رائع استمر يا عبقري العباقرة',
            likes: 70,
            createdAt: DateTime.now()),
      ],
    ),
    Comment(
        commenter: 'Ahmed Dadar',
        commentText:
            ' حتوى رائع استمر يا عبقري العباقر حتوى رائع استمر يا عبقري العباقر محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Hussen GHabayen',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
      commenter: 'Alaa M Mubarak',
      commentText: 'محتوى رائع استمر يا عبقري العباقرة',
      likes: 70,
      createdAt: DateTime.now(),
      replies: [
        Comment(
            commenter: 'Ahmed 8 Dadar',
            commentText:
                ' حتوى رائع استمر يا عبقري العباقر حتوى رائع استمر يا عبقري العباقر محتوى رائع استمر يا عبقري العباقرة',
            likes: 70,
            createdAt: DateTime.now()),
        Comment(
            commenter: 'Hussen 8 GHabayen',
            commentText: 'محتوى رائع استمر يا عبقري العباقرة',
            likes: 70,
            createdAt: DateTime.now()),
        Comment(
            commenter: 'Alaa 8 Mubarak',
            commentText: 'محتوى رائع استمر يا عبقري العباقرة',
            likes: 70,
            createdAt: DateTime.now()),
      ],
    ),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'Alaa M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
    Comment(
        commenter: 'End M Mubarak',
        commentText: 'محتوى رائع استمر يا عبقري العباقرة',
        likes: 70,
        createdAt: DateTime.now()),
  ];
}
