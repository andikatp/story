import 'package:flutter/material.dart';

class TextFieldStory extends StatelessWidget {
  const TextFieldStory({
    required this.descriptionController,
    required this.addStory,
    super.key,
  });

  final TextEditingController descriptionController;
  final VoidCallback addStory;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.black38,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        child: TextField(
          controller: descriptionController,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          maxLines: 6,
          minLines: 1,
          autofocus: true,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Add Caption....',
            hintStyle: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
            suffixIcon: IconButton(
              onPressed: addStory,
              style: IconButton.styleFrom(
                backgroundColor: Colors.tealAccent[700],
              ),
              icon: const Icon(
                Icons.check,
                color: Colors.white,
                size: 27,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
