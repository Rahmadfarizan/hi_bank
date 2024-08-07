
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          color: const Color(
            0xFFFF9738,
          ),
          image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/home/pattern.png")),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/images/general/logo_white.png",
                  width: 64,
                  height: 32,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 36),
                alignment: Alignment.centerLeft,
                child: Text(
                  "5022 8200 8100 4575",
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500),
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "MEMBER\nSINCE",
                          style: GoogleFonts.montserrat(
                              fontSize: 8,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "22",
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 22,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "VALID\nTHRU",
                          style: GoogleFonts.montserrat(
                              fontSize: 8,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "09/27",
                          style: GoogleFonts.montserrat(
                              fontSize: 12,
                              color: const Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Image.asset(
                    "assets/images/home/mastercard.png",
                    width: 52,
                    height: 32,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
