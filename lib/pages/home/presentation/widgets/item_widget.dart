
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_bank/pages/home/model/post_model.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.post,
  });

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Id : ${post.id}",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
            ),
            Text(
              "User Id : ${post.userId}",
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post.title,
              style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF000000)),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            post.body,
            style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color:
                    const Color(0xFF000000).withOpacity(0.5)),
          ),
        ),
        const SizedBox(height: 32,)
      ],
    );
  }
}
