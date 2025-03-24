import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vibepick/theme/theme.dart';
import 'dart:convert';
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
  final List<String> _moods = ['Relaxed', 'Excited', 'Tired', 'Happy', 'Adventurous'];
  bool _isLoading = false;

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

  // Function to parse a movie object into the format expected by ResultsScreen
  Map<String, dynamic> _parseMovieData(dynamic movie) {
    return {
      'poster': movie['poster_url']?.toString() ?? '',
      'title': movie['title']?.toString() ?? 'Unknown Title',
      'genre': movie['genre']?.toString() ?? 'Unknown Genre',
      'imdbRating': movie['IMDB_rating']?.toString() ?? 'N/A',
      'overview': movie['overview']?.toString() ?? 'No overview available.',
    };
  }

  // Function to call the backend and navigate to the recommendations screen
  Future<void> _getRecommendations() async {
    if (_queryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a query to get recommendations.'),
          backgroundColor: AppTheme.playfulCoral,
        ),
      );
      return;
    }

    if (_selectedMood == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a mood.'),
          backgroundColor: AppTheme.playfulCoral,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final requestBody = {
        'text': _queryController.text,
        'mood': _selectedMood!,
      };

      final response = await http.post(
        Uri.parse('https://vibepick.onrender.com/moviesrecommend'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Log the raw response for debugging
        print('Raw API Response: $responseData');

        // Check if response has a 'message' field
        if (!responseData.containsKey('message')) {
          throw Exception('Response does not contain a "message" field.');
        }

        // The 'message' field is a JSON string, so decode it
        final modelOutput = jsonDecode(responseData['message']);

        // Handle the response format
        List<Map<String, dynamic>> movies = [];

        // Check if the decoded modelOutput has a 'choices' field
        if (modelOutput is Map && modelOutput.containsKey('choices')) {
          final choices = modelOutput['choices'] as List<dynamic>;
          if (choices.isEmpty) {
            throw Exception('No choices found in the response.');
          }

          final choice = choices[0] as Map<String, dynamic>;
          final message = choice['message'] as Map<String, dynamic>;
          final content = message['content'] as String;

          // Parse the content string, which is a JSON array of movies
          final movieList = jsonDecode(content) as List<dynamic>;

          if (movieList.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No recommendations found for your query.'),
                backgroundColor: AppTheme.playfulCoral,
              ),
            );
            return;
          }

          // Parse each movie into the required format
          movies = movieList.map((movie) {
            return _parseMovieData(movie);
          }).toList();
        } else {
          throw Exception('Unexpected response format: $modelOutput');
        }

        // Navigate to ResultsScreen with the parsed movies
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultsScreen(movies: movies),
          ),
        );
      } else if (response.statusCode == 400) {
        final responseData = jsonDecode(response.body);
        throw Exception('Backend error: ${responseData['detail'] ?? 'Unknown error'}');
      } else {
        throw Exception('Failed to fetch recommendations: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: AppTheme.playfulCoral,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
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
              Color(0xFF1A3C34),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.vibrantYellow.withOpacity(0.3),
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
                      fillColor: AppTheme.softGray.withOpacity(0.2),
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
                          fillColor: AppTheme.softGray.withOpacity(0.2),
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
                Center(
                  child: GestureDetector(
                    onTap: _isLoading ? null : _getRecommendations,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform: Matrix4.identity()..scale(1.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 32,
                        ),
                        decoration: BoxDecoration(
                          color: _isLoading
                              ? AppTheme.lightGray
                              : AppTheme.vibrantYellow,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.vibrantYellow.withOpacity(0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: AppTheme.deepBlack,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
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
