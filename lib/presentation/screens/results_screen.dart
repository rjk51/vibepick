import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class ResultsScreen extends StatefulWidget {
  final List<dynamic>? movies; // Dynamic list of movies from the API

  const ResultsScreen({super.key, this.movies});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int? _expandedIndex; // Track which card is expanded

  @override
  Widget build(BuildContext context) {
    // Check if movies are null or empty
    if (widget.movies == null || widget.movies!.isEmpty) {
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
            bottom: false,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'No Recommendations Found',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.pureWhite,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Try a different query or mood.',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.lightGray,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Go back to HomeScreen
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 24,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.vibrantYellow,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.vibrantYellow.withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Text(
                        'Go Back',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.deepBlack,
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
          bottom: false,
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
                        Icons.arrow_back_rounded,
                        color: AppTheme.vibrantYellow,
                        size: 28,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
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
                    itemCount: widget.movies!.length,
                    itemBuilder: (context, index) {
                      final movie = widget.movies![index];
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
                            color: AppTheme.softGray.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: AppTheme.vibrantYellow.withOpacity(0.3),
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
                                        movie['poster'] ?? 'https://via.placeholder.com/100x150',
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
                                            movie['title'] ?? 'Unknown Title',
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: AppTheme.pureWhite,
                                            ),
                                          ),
                                          const SizedBox(height: 4),

                                          // Genre
                                          Text(
                                            movie['genre'] ?? 'Unknown Genre',
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
                                                '${movie['imdbRating'] ?? 'N/A'}/10',
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
                                    movie['overview'] ?? 'No overview available.',
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
