import 'package:flutter/material.dart';

class BaseStreamBuilder<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(T data) builder;
  final Widget? Function(Object? error)? errorBuilder;
  final Widget? loadingWidget;

  const BaseStreamBuilder({
    super.key,
    required this.stream,
    required this.builder,
    this.errorBuilder,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        final emptyWidget = SizedBox.shrink();

        if (snapshot.hasData) {
          final data = snapshot.data;
          return data == null ? emptyWidget : builder(data);
        } else if (snapshot.hasError) {
          return errorBuilder?.call(snapshot.error) ?? emptyWidget;
        }

        return loadingWidget ?? emptyWidget;
      },
    );
  }
}
