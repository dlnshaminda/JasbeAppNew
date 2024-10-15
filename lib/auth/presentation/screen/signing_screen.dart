import 'package:flutter/material.dart';
import 'package:jasbe/auth/presentation/screen/sign_in_tab.dart';
import 'package:jasbe/auth/presentation/screen/sign_up_tab.dart';
import 'package:jasbe/common/functions.dart';

class SigningScreen extends StatefulWidget {
  const SigningScreen({super.key, this.newUser = true});

  final bool newUser;

  @override
  State<SigningScreen> createState() => _SigningScreenState();
}

class _SigningScreenState extends State<SigningScreen> with TickerProviderStateMixin {
  bool newUser = true;

  @override
  void initState() {
    initValues();
    super.initState();
  }

  initValues() {
    newUser = widget.newUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              signingTabs(),

              // Contents
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: newUser
                    ? const SignUpContent(
                        key: ValueKey("sign-up"),
                      )
                    : const SignInContent(
                        key: ValueKey("sign-in"),
                      ),
              ),
            ],
          ),
        ));
  }

  Widget signingTabs() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40),
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: Row(
            children: [
              // Sign In Tab
              InkWell(
                onTap: () {
                  setState(() {
                    newUser = false;
                  });
                },
                child: Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("Sign In", textAlign: TextAlign.center),
                ),
              ),

              // Sign Up Tab
              InkWell(
                onTap: () {
                  setState(() {
                    newUser = true;
                  });
                },
                child: Container(
                  width: 100,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("Sign Up"),
                ),
              ),
              const Spacer(),

              // User Profile
              AnimatedScale(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOutBack,
                scale: newUser ? 0 : 1,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: ShapeDecoration(shape: CircleBorder(side: BorderSide(color: context.borderColor))),
                  child: const CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.lightBlueAccent,
                    child: Icon(Icons.person, color: Colors.lightBlue, size: 35),
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),

        // Animation Slide Bar
        AnimatedPositioned(
          bottom: 0,
          left: newUser ? 100 : 0,
          duration: const Duration(milliseconds: 400),
          child: Container(
            width: 100,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 3,
              width: 100,
              decoration: BoxDecoration(color: Colors.lightBlue, borderRadius: BorderRadius.circular(7)),
            ),
          ),
        )
      ],
    );
  }
}
