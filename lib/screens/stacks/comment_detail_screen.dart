import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../models/comment.dart';
import '../../models/movie.dart';
import '../../utils/datetime_helper.dart';
import '../../widgets/comment_container.dart';

class CommentDetailScreen extends StatelessWidget {
  final Comment comment;
  final Movie movie;

  const CommentDetailScreen(
      {super.key, required this.comment, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bài viết chi tiết'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 0,
                  bottom: 16,
                ),
                child: Column(
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        comment.content,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ],
                )),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 100,
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.thumb_up,
                            color: colorPrimary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            comment.likes.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: colorPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 100,
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.comment,
                            color: colorPrimary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            comment.replies.length.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: colorPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: comment.replies
                  .map((comment) => CommentContainer(
                      comment: comment,
                      onReply: () {

                      }))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                          movie.imageUrl), // Loads the image from the network
                      fit: BoxFit
                          .cover, // Ensures the image covers the container
                    ),
                  ),
                ),
                Positioned(
                  bottom: -10,
                  right: -10,
                  width: 25,
                  height: 25,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundImage: comment.author.avatarUrl != null
                          ? NetworkImage(comment.author.avatarUrl!)
                          : const NetworkImage(
                              'https://via.placeholder.com/150'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Đánh giá ${movie.title}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        '${comment.author.firstName} ${comment.author.lastName}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DatetimeHelper.getFormattedDate(comment.createdAt),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
