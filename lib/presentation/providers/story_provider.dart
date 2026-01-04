import 'dart:io';

import 'package:fleegram/core/network/network_exception.dart';
import 'package:fleegram/data/models/story.dart';
import 'package:fleegram/data/repositories/story_repository.dart';
import 'package:flutter/material.dart';

enum StoryError { network, unknown }

class StoryProvider extends ChangeNotifier {
  final StoryRepository repository;

  StoryProvider(this.repository);

  final List<Story> _stories = [];
  bool _isLoading = false;
  bool _hasMore = true;
  StoryError? _errorMessage;

  int _page = 1;
  static const int _size = 10;

  List<Story> get stories => _stories;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  StoryError? get errorMessage => _errorMessage;

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
    } on NetworkException {
      _hasMore = false;
      _errorMessage = StoryError.network;
    } catch (e) {
      _hasMore = false;
      _errorMessage = StoryError.unknown;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> uploadStory({
    required File imageFile,
    required String description,
    double? lat,
    double? lon,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await repository.uploadStory(
        imageFile: imageFile,
        description: description,
        lat: lat,
        lon: lon,
      );
    } on NetworkException catch (_) {
      _errorMessage = StoryError.network;
      rethrow;
    } catch (e) {
      _errorMessage = StoryError.unknown;
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
