import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_bank/pages/auth/service/auth_service.dart';
import 'package:hi_bank/pages/home/presentation/page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late Form form;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? errorMessage;

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _signIn() async {
    try {
      await _auth
          .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          )
          .then((val) => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const PostListScreen())));
    } catch (e) {
      _showErrorSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFFF9738,
      ),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: const Color(
          0xFFFF9738,
        ),
        surfaceTintColor: const Color(
          0xFFFF9738,
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "assets/images/home/pattern.png",
              ),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    "assets/images/general/logo_white.png",
                    width: 125,
                    height: 63,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  alignment: Alignment.bottomRight,
                  child: Image.asset(
                    "assets/images/auth/auth_vector.png",
                    width: 205,
                    height: 158,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.only(top: 200),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 22,
                  ),
                  Text(
                    "Hello,",
                    style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF000000)),
                  ),
                  Text(
                    "Please login to your account",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF000000).withOpacity(0.5)),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Email",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF000000).withOpacity(0.5)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: emailController,
                      onChanged: (val) {},
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Example: johndoe@gmail.com",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF000000).withOpacity(0.5),
                            fontWeight: FontWeight.w500),
                      ),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Password",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF000000).withOpacity(0.5)),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 6, bottom: 6),
                    decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: passwordController,
                      onChanged: (val) {},
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Your Password",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF000000).withOpacity(0.5),
                            fontWeight: FontWeight.w500),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        ),
                      ),
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000).withOpacity(0.5)),
                      )),
                  SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                    onTap: _signIn,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(
                          0xFFFF9738,
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width / 4,
                        color: Color(0xFFD9D9D9),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text("OR"),
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width / 4,
                        color: Color(0xFFD9D9D9),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  GestureDetector(
                      onTap: () async {
                        User? user = await _authService.signInWithGoogle();
                        if (user != null) {
                          if (context.mounted) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PostListScreen()));
                          }
                        }
                      },
                      child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  width: 1, color: Color(0xFFD9D9D9))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                "assets/images/general/google.png",
                                width: 23,
                                height: 24,
                              ),
                              Text(
                                'Sign in with Google',
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox()
                            ],
                          ))),
                  SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Dont have an account?",
                        style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF000000).withOpacity(0.5)),
                      ),
                      Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(
                            0xFFFF9738,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
