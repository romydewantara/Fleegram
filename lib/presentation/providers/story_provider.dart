import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/models/story_model.dart';
import '../../data/repositories/story_repository.dart';

class StoryProvider extends ChangeNotifier {
  final StoryRepository repository;

  StoryProvider(this.repository);

  final List<Story> _stories = [];
  bool _isLoading = false;
  bool _hasMore = true;
  String? _errorMessage;

  int _page = 1;
  static const int _size = 10;

  List<Story> get stories => _stories;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  String? get errorMessage => _errorMessage;

  Future<void> fetchInitialStories() async {
    _stories.clear();
    _page = 1;
    _hasMore = true;
    _errorMessage = null;

    await _fetchStories();
  }

  Future<void> fetchNextStories() async {
    if (_isLoading || !_hasMore) return;
    await _fetchStories();
  }

  Future<void> _fetchStories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final newStories = await repository.getStories(page: _page, size: _size);

      if (newStories.length < _size) {
        _hasMore = false;
      }

      _stories.addAll(newStories);
      _page++;
    } catch (_) {
      _hasMore = false;
      _errorMessage = 'error fetch stories';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> uploadStory({
    required File imageFile,
    required String description,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.uploadStory(
        imageFile: imageFile,
        description: description,
      );
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
