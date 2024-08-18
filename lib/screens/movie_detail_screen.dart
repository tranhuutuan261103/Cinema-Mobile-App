import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/movie.dart';
import '../models/comment.dart';
import '../widgets/comment_container.dart';
import '../services/comment_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<List<Comment>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = CommentService().getComments(movieId: widget.movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(
          'Thông tin phim',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
              color: Color.fromRGBO(255, 255, 255, 1)),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Movie Poster and Details
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: Image.network(
                                widget.movie.imageUrl,
                                width: 100,
                                height: 100 * 4 / 3, // Image height
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(
                              width:
                                  16, // Spacing between the image and the text
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 100 *
                                    4 /
                                    3, // Match the height of the image
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.movie.title,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.movie.categories
                                          .map((category) => category.name)
                                          .join(", "),
                                      style: const TextStyle(fontSize: 14),
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Date, Duration, Language Information
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildDetailColumn('Ngày khởi chiếu',
                                '${widget.movie.releaseDate.day}/${widget.movie.releaseDate.month}/${widget.movie.releaseDate.year}'),
                            _buildSeperator(),
                            _buildDetailColumn(
                                'Thời lượng', '${widget.movie.duration} phút'),
                            _buildSeperator(),
                            _buildDetailColumn('Ngôn ngữ', widget.movie.language),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 8.0,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildDescription(widget.movie.description),
                  ),
                  Container(
                    height: 8.0,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCommentSection(),
                  ),
                ],
              ),
            ),
          ),
          // Fixed Book Ticket Button at the bottom
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: _buildBookTicketButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSeperator() {
    return Container(
      height: 60,
      width: 1,
      color: Colors.grey,
    );
  }

  Widget _buildDescription(String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nội dung phim',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildCommentSection() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Cộng đồng Tune Cinema nghĩ gì?',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Row(
        children: [
          const Icon(
            Icons.star,
            color: colorPrimary,
          ),
          const SizedBox(width: 4),
          const Text(
            '9.5/10',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            ' (1000 đánh giá)',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          TextButton(
              onPressed: () {
                print("View all comments");
              },
              style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent)),
              child: const Text('Viết đánh giá')),
        ],
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(16),
        ),
        child: FutureBuilder<List<Comment>>(
          future: _commentsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Failed to load comments'),
                );
              } else {
                final comments = snapshot.data!;
                
                return Column(
                  children: comments
                      .map((comment) => CommentContainer(comment: comment))
                      .toList(),
                );
              }
            }
          },
        ),
      ),
    ]);
  }

  Widget _buildBookTicketButton(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Makes the button take up 100% of the width
      child: ElevatedButton(
        onPressed: () {
          // Navigate to the booking screen
          Navigator.pushNamed(context, '/booking', arguments: widget.movie);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        child: const Text('Đặt vé'),
      ),
    );
  }
}
