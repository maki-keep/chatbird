import 'package:flutter/material.dart';

mixin LoadingMixin<T extends StatefulWidget> on State<T> {
  final ValueNotifier<bool> _isLoadingNotifier = ValueNotifier<bool>(false);

  bool get isLoading => _isLoadingNotifier.value;

  ValueNotifier<bool> get isLoadingNotifier => _isLoadingNotifier;

  // Invert the value of isLoading.
  void changeLoading({bool? isLoading}) {
    _isLoadingNotifier.value = isLoading ?? !_isLoadingNotifier.value;
  }
}
