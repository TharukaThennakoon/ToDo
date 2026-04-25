import 'package:flutter/material.dart';

void main() {
  runApp(const DayPilotApp());
}

class DayPilotApp extends StatelessWidget {
  const DayPilotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DayPilot',
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff4f4fb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25),

              /// TOP IMAGE CARD
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 28),
                height: 430,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  image: const DecorationImage(
                    image: AssetImage("assets/images/welcome.jpg"),
                    
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    /// Timer Icon
                    Positioned(
                      top: 25,
                      left: 25,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white.withOpacity(.8),
                        child: const Icon(
                          Icons.timer,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),

                    /// Bottom Right Icon
                    Positioned(
                      bottom: 28,
                      right: 28,
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.white.withOpacity(.8),
                        child: const Icon(
                          Icons.done_all,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 55),

              /// TITLE
              const Text(
                "DayPilot",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 18),

              /// SUBTITLE
              const Text(
                "Organize your day with care",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurple,
                ),
              ),

              const SizedBox(height: 20),

              /// DESCRIPTION
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "This productive tool is designed to help\n"
                  "you better manage your tasks project-\n"
                  "wise conveniently!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    height: 1.8,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              /// BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Container(
                  height: 78,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withOpacity(.25),
                        blurRadius: 20,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Spacer(),
                      const Text(
                        "Let's Start",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 14),
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 35),

              /// LOGIN TEXT
              const Text(
                "Already have an account?",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black45,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Sign In",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),

              const SizedBox(height: 40),

              /// INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 10,
                    width: 55,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 12),
                  dot(),
                  const SizedBox(width: 12),
                  dot(),
                ],
              ),

              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }

  Widget dot() {
    return Container(
      height: 12,
      width: 12,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xffd5cdf7),
      ),
    );
  }
}