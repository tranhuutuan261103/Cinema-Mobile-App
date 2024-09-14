import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../constants/colors.dart';
import '../../../../models/comment.dart';
import '../../../../models/movie.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../services/comment_service.dart';
import '../../../../utils/datetime_helper.dart';
import '../../../../widgets/comment_container.dart';

class CommentDetailScreen extends StatefulWidget {
  final Comment comment;
  final Movie movie;

  const CommentDetailScreen(
      {super.key, required this.comment, required this.movie});

  @override
  State<CommentDetailScreen> createState() => _CommentDetailScreenState();
}

class _CommentDetailScreenState extends State<CommentDetailScreen> {
  void handleLikeComment(int commentId) {
    // find the comment with the given id
    final c =
        widget.comment.replies.firstWhere((element) => element.id == commentId);

    // update the likes of the comment
    if (Provider.of<AuthProvider>(context, listen: false).isAuthenticated) {
      final token = Provider.of<AuthProvider>(context, listen: false).getToken;
      CommentService().likeComment(token, c.id);
      if (c.isLiked) {
        setState(() {
          c.likes--;
          c.isLiked = false;
        });
      } else {
        setState(() {
          c.likes++;
          c.isLiked = true;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Bạn cần đăng nhập'),
            content: const Text('Để thích bình luận, vui lòng đăng nhập'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đóng'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed('/login');
                },
                child: const Text('Đăng nhập'),
              ),
            ],
          );
        },
      );
    }
  }

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
                        widget.comment.content,
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
                    onTap: () {
                      if (Provider.of<AuthProvider>(context, listen: false)
                          .isAuthenticated) {
                        final token =
                            Provider.of<AuthProvider>(context, listen: false)
                                .getToken;
                        CommentService().likeComment(token, widget.comment.id);
                        if (widget.comment.isLiked) {
                          setState(() {
                            widget.comment.likes--;
                            widget.comment.isLiked = false;
                          });
                        } else {
                          setState(() {
                            widget.comment.likes++;
                            widget.comment.isLiked = true;
                          });
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Bạn cần đăng nhập'),
                              content: const Text(
                                  'Để thích bình luận, vui lòng đăng nhập'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Đóng'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamed('/login');
                                  },
                                  child: const Text('Đăng nhập'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
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
                          Icon(
                            widget.comment.isLiked
                                ? Icons.thumb_up
                                : Icons.thumb_up_alt_outlined,
                            color: colorPrimary,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.comment.likes.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.comment.isLiked
                                  ? colorPrimary
                                  : Colors.grey,
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
                            widget.comment.replies.length.toString(),
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
              children: widget.comment.replies
                  .map((comment) => CommentContainer(
                      comment: comment,
                      onLike: (commentId) {
                        handleLikeComment(commentId);
                      },
                      onReply: () {}))
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
                      image: NetworkImage(widget
                          .movie.imageUrl), // Loads the image from the network
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
                      backgroundImage: widget.comment.author.avatarUrl != null
                          ? NetworkImage(widget.comment.author.avatarUrl!)
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
                    'Đánh giá ${widget.movie.title}',
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
                        '${widget.comment.author.firstName} ${widget.comment.author.lastName}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DatetimeHelper.getFormattedDate(
                            widget.comment.createdAt),
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
