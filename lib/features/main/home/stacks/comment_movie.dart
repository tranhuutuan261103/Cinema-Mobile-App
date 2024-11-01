import 'package:flutter/material.dart';

import '../../../../common/constants/colors.dart';
import '../../../../common/models/movie.dart';
import '../../../../common/widgets/buttons/custom_elevated_button.dart';

class CommentMovie extends StatefulWidget {
  final Movie movie;

  const CommentMovie({super.key, required this.movie});

  @override
  State<CommentMovie> createState() => _CommentMovieState();
}

class _CommentMovieState extends State<CommentMovie> {
  int maxRatingValue = 10;
  int ratingValue = 0;
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        title: const Text(
          'Viết đánh giá',
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
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.movie.imageUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(width: 8),
                        Text(widget.movie.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Column(
                      children: [
                        const Text("Nhấn để đánh giá phim này",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            )),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 1; i <= maxRatingValue; i++)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ratingValue = i;
                                  });
                                },
                                child: Icon(
                                  i <= ratingValue ? Icons.star : Icons.star_border,
                                  color: colorPrimary,
                                  size: 30,
                                ),
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                "Cảm nhận của bạn",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          TextField(
                            controller: commentController,
                            decoration: const InputDecoration(
                              hintText: "Giờ là lúc ngôn từ lên ngôi",
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(8.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: colorPrimary,
                                ),
                              ),
                            ),
                            maxLines: 5,
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomElevatedButton(
              onPressed: () {},
              text: "Gửi đánh giá",
            ),
          ),
        ],
      ),
    );
  }
}
