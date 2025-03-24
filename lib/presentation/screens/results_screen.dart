import 'package:flutter/material.dart';
import 'package:vibepick/theme/theme.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  // Hardcoded movie data
  final List<Map<String, dynamic>> mockMovies = [
    {
      'poster': 'https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg',
      'title': 'Oppenheimer',
      'genre': 'Biography, Drama, History',
      'imdbRating': 8.4,
      'overview':
          'The story of J. Robert Oppenheimer’s role in the development of the atomic bomb during World War II, exploring the moral dilemmas and scientific breakthroughs that shaped history.',
    },
    {
      'poster': 'https://image.tmdb.org/t/p/w500/kP7t6RwGz2dXU1CENM7gVOoLhP.jpg',
      'title': 'Barbie',
      'genre': 'Comedy, Fantasy',
      'imdbRating': 7.0,
      'overview':
          'Barbie and Ken leave the perfect world of Barbieland to explore the real world, discovering the joys and challenges of being human in a whimsical and heartfelt adventure.',
    },
    {
      'poster': 'https://image.tmdb.org/t/p/w500/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg',
      'title': 'Spider-Man: Across the Spider-Verse',
      'genre': 'Animation, Action, Adventure',
      'imdbRating': 8.7,
      'overview':
          'Miles Morales embarks on a multiversal adventure, teaming up with Gwen Stacy and a new crew of Spider-People to face a powerful villain threatening every dimension.',
    },
    {
      'poster': 'https://image.tmdb.org/t/p/w500/iuFNMS8U5cb6xfzi51Dbkovj7vM.jpg',
      'title': 'The Godfather',
      'genre': 'Crime, Drama',
      'imdbRating': 9.2,
      'overview':
          'The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son, leading to a saga of power, loyalty, and betrayal.',
    },
    {
      'poster': 'https://image.tmdb.org/t/p/w500/7WsyChQLEftFiDOVTGkv3hFpyD6.jpg',
      'title': 'The Matrix',
      'genre': 'Action, Sci-Fi',
      'imdbRating': 8.7,
      'overview':
          'A computer hacker learns about the true nature of reality and joins a group of rebels to fight a war against a powerful AI that has enslaved humanity in a simulated world.',
    },
  ];

  int? _expandedIndex; // Track which card is expanded

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
          bottom: false, // Ignore the bottom safe area
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button and Header
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.vibrantYellow,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context); // Navigate back to HomeScreen
                      },
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Your VibePick Recommendations',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.pureWhite,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Here are some movies tailored to your vibe!',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.lightGray,
                  ),
                ),
                const SizedBox(height: 16),

                // Movie Cards List
                Expanded(
                  child: ListView.builder(
                    itemCount: mockMovies.length,
                    itemBuilder: (context, index) {
                      final movie = mockMovies[index];
                      final isExpanded = _expandedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _expandedIndex = isExpanded ? null : index;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: AppTheme.softGray.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.vibrantYellow.withValues(alpha: 0.3),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Movie Poster
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        movie['poster'],
                                        width: 100,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Container(
                                            width: 100,
                                            height: 150,
                                            color: AppTheme.lightGray,
                                            child: const Icon(
                                              Icons.broken_image,
                                              color: AppTheme.deepBlack,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),

                                    // Movie Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Title
                                          Text(
                                            movie['title'],
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.pureWhite,
                                            ),
                                          ),
                                          const SizedBox(height: 4),

                                          // Genre
                                          Text(
                                            movie['genre'],
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: AppTheme.lightGray,
                                            ),
                                          ),
                                          const SizedBox(height: 8),

                                          // IMDb Rating
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star_rounded,
                                                color: AppTheme.vibrantYellow,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                '${movie['imdbRating']}/10',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppTheme.vibrantYellow,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Expand/Collapse Icon
                                    Icon(
                                      isExpanded
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      color: AppTheme.vibrantYellow,
                                    ),
                                  ],
                                ),
                              ),

                              // Overview (shown when expanded)
                              if (isExpanded)
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    movie['overview'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: AppTheme.lightGray,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
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