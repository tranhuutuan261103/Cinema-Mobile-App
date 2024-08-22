import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';

import '../constants/colors.dart';
import '../utils/datetime_helper.dart';
import '../models/comment.dart';

class CommentContainer extends StatelessWidget {
  final Comment comment;
  final bool hasSeparator;
  final Function(int) onLike;
  final Function onReply;

  const CommentContainer(
      {super.key, required this.comment, this.hasSeparator = false, required this.onLike, required this.onReply});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: hasSeparator ? Colors.grey[300]! : Colors.transparent,
              width: 1,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundImage:
                    comment.author.avatarUrl != null
                      ? NetworkImage(comment.author.avatarUrl!)
                      : const NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${comment.author.firstName} ${comment.author.lastName}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: colorPrimary,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  '${comment.rating.value}/10 - ${comment.rating}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ExpandableText(
              comment.content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.2,
              ),
              maxLines: 3,
              animation: true,
              collapseOnTextTap: true,
              expandText: 'xem thêm',
              collapseText: 'thu gọn',
              linkColor: colorPrimary,
              linkStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    onLike(comment.id);
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
                          comment.isLiked ? Icons.thumb_up : Icons.thumb_up_alt_outlined,
                          color: colorPrimary,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          comment.likes.toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: comment.isLiked ? colorPrimary : Colors.grey[600]!,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    onReply();
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
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
