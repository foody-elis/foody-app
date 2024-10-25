import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

/// Creates [MultiSelectController] that will be disposed automatically.
MultiSelectController<T> useMultiSelectController<T>() {
  return use(_MultiSelectControllerHook<T>());
}

class _MultiSelectControllerHook<T> extends Hook<MultiSelectController<T>> {
  const _MultiSelectControllerHook();

  @override
  HookState<MultiSelectController<T>, Hook<MultiSelectController<T>>>
      createState() => _MultiSelectControllerHookState<T>();
}

class _MultiSelectControllerHookState<T>
    extends HookState<MultiSelectController<T>, _MultiSelectControllerHook<T>> {
  late final controller = MultiSelectController<T>();

  @override
  MultiSelectController<T> build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useMultiSelectController';
}
