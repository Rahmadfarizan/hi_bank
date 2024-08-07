import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_bank/pages/auth/presentation/page.dart';
import 'package:hi_bank/pages/auth/service/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 24,
          ),
          if (_user?.photoURL != null && _user != null)
            Align(
              alignment: Alignment.topCenter,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: Image.network(
                    _user!.photoURL!,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  )),
            ),
          const SizedBox(
            height: 12,
          ),
          Text(
            _user?.displayName ?? '-',
            style: GoogleFonts.poppins(
                fontSize: 16,
                color: const Color(0xFF000000),
                fontWeight: FontWeight.w700),
          ),
          Text(
            _user?.email ?? '-',
            style: GoogleFonts.montserrat(
                fontSize: 14,
                color: const Color(0xFF000000).withOpacity(0.5),
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 48,
          ),
          GestureDetector(
            onTap: () async {
              try {
                await _authService.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthScreen()),
                    (Route<dynamic> route) => false,
                  );
                }
              } catch (_) {
                if (kDebugMode) {
                  print("failed to logout");
                }
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 12),
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              decoration: BoxDecoration(
                  color: const Color(0xFFFF9738),
                  borderRadius: BorderRadius.circular(12)),
              child: Text(
                "Log Out",
                style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFFFFFFF)),
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
