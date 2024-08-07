import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hi_bank/helper/mobx_helper.dart';
import 'package:hi_bank/pages/home/model/post_model.dart';
import 'package:hi_bank/pages/home/presentation/widgets/card_widget.dart';
import 'package:hi_bank/pages/home/presentation/widgets/item_widget.dart';
import 'package:hi_bank/pages/home/state/state.dart';
import 'package:hi_bank/pages/profile/presentation/page.dart';
import 'package:mobx/mobx.dart';

class PostListScreen extends StatefulWidget {
  const PostListScreen({super.key});

  @override
  State<PostListScreen> createState() => _PostListScreenState();
}

class _PostListScreenState extends State<PostListScreen> {
  late PostStore postStore;
  final TextEditingController _controller = TextEditingController();

  User? _user;

  @override
  void initState() {
    super.initState();
    postStore = MobXHelper().postStore..fetchPosts();
    _user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: const Color(0xFF000000).withOpacity(0.5),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        _user?.displayName ?? '-',
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  if (_user != null && _user?.photoURL != null)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(360),
                        child: Image.network(
                          _user!.photoURL!,
                          width: 56,
                          height: 56,
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              const CardWidget(),
              const SizedBox(
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                    color: const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (val) {
                          if (val.isEmpty) {
                            postStore.fetchPosts();
                            postStore.postFuture = null;
                          } else {
                            final id = int.tryParse(val);
                            if (id != null) {
                              postStore.postsFuture = null;
                              postStore.fetchPostById(id);
                            }
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search by Id",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 16,
                              color: const Color(0xFF000000).withOpacity(0.5),
                              fontWeight: FontWeight.w500),
                        ),
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const Icon(
                      Icons.search,
                      size: 24,
                      color: Color(0xFF000000),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(
                child: Observer(
                  builder: (_) {
                    if (postStore.postsFuture == null &&
                        postStore.postFuture == null) {
                      return GestureDetector(
                        onTap: () => postStore.fetchPosts(),
                        child: const Text('Press the button to fetch posts'),
                      );
                    }
        
                    if (postStore.postFuture != null &&
                        postStore.postFuture!.status == FutureStatus.fulfilled) {
                      final PostModel post = postStore.postFuture!.result!;
                      return SingleChildScrollView(child: ItemWidget(post: post));
                    }
        
                    if (postStore.postsFuture != null) {
                      switch (postStore.postsFuture!.status) {
                        case FutureStatus.pending:
                          return const Center(child: CircularProgressIndicator());
                        case FutureStatus.rejected:
                          return const Text('Failed to load posts');
                        case FutureStatus.fulfilled:
                          final List<PostModel> posts =
                              postStore.postsFuture!.result!;
                          return (posts.isNotEmpty)
                              ? ListView.builder(
                                  itemCount: posts.length,
                                  itemBuilder: (context, index) {
                                    return ItemWidget(
                                      post: posts[index],
                                    );
                                  },
                                )
                              : const Center(
                                  child: Text("Data tidak ditemukan"),
                                );
                      }
                    }
        
                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
