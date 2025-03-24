import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../theme/theme.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _queryController = TextEditingController();
  String? _selectedMood;
  File? _selectedImage;
  // Updated moods list with two new moods
  final List<String> _moods = ['Relaxed', 'Excited', 'Tired', 'Happy', 'Adventurous'];

  // Function to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Function to navigate to the recommendations screen
  void _getRecommendations() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ResultsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.deepBlack,
              Color(0xFF1A3C34), // Darker teal shade
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                const Text(
                  'Find Your Vibe',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.pureWhite,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Tell us what you’re in the mood for!',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.lightGray,
                  ),
                ),
                const SizedBox(height: 54),
                Center(child: Image.asset('assets/images/home.gif', height: 200)),
                const Spacer(),

                // Text Field (Point of Interest)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.vibrantYellow.withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _queryController,
                    style: const TextStyle(color: AppTheme.pureWhite),
                    cursorColor: AppTheme.vibrantYellow,
                    decoration: InputDecoration(
                      hintText: 'What do you want to watch or listen to?',
                      hintStyle: const TextStyle(color: AppTheme.lightGray),
                      filled: true,
                      fillColor: AppTheme.softGray.withValues(alpha: 0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppTheme.vibrantYellow,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Mood Dropdown
                Row(
                  children: [
                    const Text(
                      'Mood:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.pureWhite,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _selectedMood,
                        hint: const Text(
                          'Select your mood',
                          style: TextStyle(color: AppTheme.lightGray),
                        ),
                        dropdownColor: AppTheme.deepBlack,
                        style: const TextStyle(color: AppTheme.pureWhite),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppTheme.vibrantYellow,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppTheme.softGray.withValues(alpha: 0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: _moods.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: AppTheme.getMoodColor(value),
                                ),
                                const SizedBox(width: 8),
                                Text(value),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedMood = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Image Upload (Optional)
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppTheme.lightGray,
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: _selectedImage == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt_rounded,
                                size: 40,
                                color: AppTheme.vibrantYellow,
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Upload a photo of your ambience (Optional)',
                                style: TextStyle(
                                  color: AppTheme.lightGray,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 150,
                            ),
                          ),
                  ),
                ),
                const Spacer(),

                // Get Recommendations Button
                Center(
                  child: GestureDetector(
                    onTap: _getRecommendations,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: Matrix4.identity()..scale(1.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.vibrantYellow,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.vibrantYellow.withValues(alpha: 0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: const Text(
                          'Get Recommendations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.deepBlack,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
