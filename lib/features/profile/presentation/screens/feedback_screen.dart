import 'package:fixit_provider/common/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewForm extends StatelessWidget {
  final TextEditingController _reviewController = TextEditingController();

  ReviewForm({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFeedbackInputField(media),
              _buildSubmitSection(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to build the feedback input field
  Widget _buildFeedbackInputField(Size media) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: media.width,
        height: media.height - 200,
        decoration: BoxDecoration(border: Border.all(width: 2)),
        child: TextField(
          controller: _reviewController,
          maxLines: null,
          decoration: const InputDecoration(
            labelText: 'We value your feedback | Help us to improve',
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  // Widget to build the submit section with the button and note
  Widget _buildSubmitSection(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: RoundButton(
            title: 'Submit',
            onPressed: () => _handleSubmit(context),
          ),
        ),
        const Text(
          'Note: External application will be used for sharing feedback',
          style: TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  // Method to handle the submission of the review
  void _handleSubmit(BuildContext context) {
    final review = _reviewController.text;
    if (review.isNotEmpty) {
      _submitReview(review);
      _reviewController.clear();
      Navigator.pop(context);
    }
  }

  // Method to submit the review via email
  Future<void> _submitReview(String review) async {
    final Uri emailUrl = Uri.parse(
        'mailto:melbinbabu066@gmail.com?subject=Feedback&body=$review');

    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl);
    } else {
      throw 'Could not launch $emailUrl';
    }
  }
}
