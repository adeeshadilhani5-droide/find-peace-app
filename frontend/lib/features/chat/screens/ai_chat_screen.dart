import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_colors.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  // BACKEND CONFIGURATION
  // Set your backend URL according to target environment:
  // - Chrome / Windows / Web: 'http://127.0.0.1:5000'
  // - Android Emulator:       'http://10.0.2.2:5000'
  // - Physical Device:        'http://<YOUR_LOCAL_IP>:5000'
  final String baseUrl = 'http://127.0.0.1:5000';

  final TextEditingController _inputController = TextEditingController();
  bool _isLoading = false;
  int? _sessionId; // Stores active Flask session ID

  final List<Map<String, String>> _messages = [
    {
      'sender': 'ai',
      'text':
          'Namo Buddhaya 🙏 Welcome to Find Peace AI. Ask any question about Dhamma, meditation, or coping with life\'s difficulties.',
    },
  ];

  /// Ensures a chat session exists on the Flask backend before sending queries
  Future<void> _ensureSessionExists() async {
    if (_sessionId != null) return;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sessions'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _sessionId = data['id'];
      }
    } catch (e) {
      debugPrint('Failed to create backend session: $e');
    }
  }

  Future<void> _sendMessage(String text) async {
    final queryText = text.trim();
    if (queryText.isEmpty || _isLoading) return;

    setState(() {
      _messages.add({'sender': 'user', 'text': queryText});
      _isLoading = true;
      _inputController.clear();
    });

    try {
      // 1. Create session on backend if not yet initialized
      await _ensureSessionExists();

      if (_sessionId == null) {
        throw Exception('Could not establish chat session with server.');
      }

      // 2. Send query along with session_id to Flask /chat route
      final response = await http.post(
        Uri.parse('$baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'session_id': _sessionId, // <--- Required parameter fix
          'query': queryText,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final String aiAnswer = data['answer'] ?? data['response'] ?? 'No answer provided by server.';

        if (mounted) {
          setState(() {
            _messages.add({'sender': 'ai', 'text': aiAnswer});
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _messages.add({
              'sender': 'ai',
              'text': 'Server Error (${response.statusCode}): ${response.body}',
            });
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _messages.add({
            'sender': 'ai',
            'text': 'Connection Error: $e',
          });
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.navyBackgroundGradient : AppColors.lightBackgroundGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded, color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.15),
                      ),
                      child: const Text('🪷', style: TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.translate('findPeaceAI'),
                          style: GoogleFonts.cinzel(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.textGold : AppColors.lightTextGold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        Text(
                          'Online · RAG Active',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 11,
                            color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Divider(height: 1, color: AppColors.navyBorder),

              // Chat Messages List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    final isUser = msg['sender'] == 'user';
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!isUser) ...[
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (isDark ? AppColors.goldPrimary : AppColors.lightPrimary).withValues(alpha: 0.2),
                              ),
                              child: const Center(child: Text('🪷', style: TextStyle(fontSize: 16))),
                            ),
                            const SizedBox(width: 10),
                          ],
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? (isDark ? AppColors.goldPrimary : AppColors.lightPrimary)
                                    : (isDark ? AppColors.navyCard : AppColors.lightCard),
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20),
                                  topRight: const Radius.circular(20),
                                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                                  bottomRight: Radius.circular(isUser ? 4 : 20),
                                ),
                                border: isUser
                                    ? null
                                    : Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
                              ),
                              child: Text(
                                msg['text']!,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  color: isUser
                                      ? (isDark ? AppColors.navyBackground : Colors.white)
                                      : (isDark ? AppColors.textWhite : AppColors.lightTextPrimary),
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 300.ms),
                    );
                  },
                ),
              ),

              // Loading Indicator
              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isDark ? AppColors.goldPrimary : AppColors.lightPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Searching Suttas...',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

              // Suggestions Chips
              SizedBox(
                height: 36,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildChip('How to deal with grief?'),
                    _buildChip('Tell me a Jataka story'),
                    _buildChip('What is karma?'),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Bottom Input Bar
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.navyCard : AppColors.lightCard,
                  border: Border(top: BorderSide(color: isDark ? AppColors.navyBorder : AppColors.lightBorder)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inputController,
                        enabled: !_isLoading,
                        style: GoogleFonts.plusJakartaSans(color: isDark ? AppColors.textWhite : AppColors.lightTextPrimary, fontSize: 14),
                        decoration: InputDecoration(
                          hintText: loc.translate('searchHint'),
                          hintStyle: GoogleFonts.plusJakartaSans(color: isDark ? AppColors.textSecondary : AppColors.lightTextSecondary, fontSize: 13),
                          border: InputBorder.none,
                        ),
                        onSubmitted: _sendMessage,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send_rounded, color: isDark ? AppColors.goldPrimary : AppColors.lightPrimary),
                      onPressed: _isLoading ? null : () => _sendMessage(_inputController.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: _isLoading ? null : () => _sendMessage(label),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? AppColors.navyCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: isDark ? AppColors.navyBorder : AppColors.lightBorder),
          ),
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              color: isDark ? AppColors.textGold : AppColors.lightTextGold,
            ),
          ),
        ),
      ),
    );
  }
}