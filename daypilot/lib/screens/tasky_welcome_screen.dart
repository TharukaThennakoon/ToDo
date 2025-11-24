// Flutter screen that reproduces the provided "Tasky" welcome screen.
// The illustration file included by the user is available at:
// /mnt/data/19626961-af3e-4dd6-b71c-356deeb75fa3.jpg
// You can either keep using that full path (for preview/testing) or copy the image
// into your Flutter project's assets and reference it via AssetImage.

import 'dart:io';
import 'package:flutter/material.dart';

class TaskyWelcomeScreen extends StatelessWidget {
  // If your environment will transform the local path to a URL (as mentioned),
  // set `useLocalFile` to true and the widget will load the image from the
  // absolute path. Otherwise copy the file into your project's assets and set
  // `useLocalFile` to false.
  final bool useLocalFile;
  final String localPath;
  final String assetPath;

  const TaskyWelcomeScreen({
    Key? key,
    this.useLocalFile = true,
    this.localPath = '/mnt/data/19626961-af3e-4dd6-b71c-356deeb75fa3.jpg',
    this.assetPath = 'assets/images/tasky_illustration.jpg',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          // soft pastel vertical gradient similar to the reference image
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF6F0D9), Color(0xFFEEDFEF), Color(0xFFF6E7D9)],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 24),

              // Title
              Text(
                'Tasky',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),

              SizedBox(height: 8),

              // Illustration container
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Container(
                      // white card with rounded corners to mimic phone inset
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: _buildIllustration(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Start button
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 28,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 64,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate or start the app
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF7E9C9),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    if (useLocalFile) {
      // Load the exact image path provided by the user (the environment you
      // described will transform the path into a usable URL). We use Image.file
      // so the path is explicit.
      return Image.file(
        File(localPath),
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _placeholder();
        },
      );
    }

    // Fallback to asset image - put the file into your project's assets and
    // register it in pubspec.yaml under flutter: assets: - assets/images/...
    return Image.asset(assetPath, fit: BoxFit.cover);
  }

  Widget _placeholder() {
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Text(
          'Illustration\n(put your image at)\n$localPath',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black45),
        ),
      ),
    );
  }
}

// --------------------------- USAGE ---------------------------
// To preview this screen:
// 1) Place the file in your Flutter project under lib/screens/tasky_welcome_screen.dart
// 2) If you want to use the exact uploaded file path, leave `useLocalFile = true`.
//    The path is already set to '/mnt/data/19626961-af3e-4dd6-b71c-356deeb75fa3.jpg'.
//    (Your environment/tooling will transform that path into a usable resource URL.)
// 3) Or copy the image into your project's assets folder, update `assetPath`, and
//    set `useLocalFile = false`. Don't forget to add the asset to pubspec.yaml.
// 4) From main.dart use:
//     runApp(MaterialApp(home: TaskyWelcomeScreen()));
// ----------------------------------------------------------------
