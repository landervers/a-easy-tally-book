import 'package:flutter/material.dart';

class BlocOption {
  Map<String, dynamic> query;

  BlocOption(this.query);
}

abstract class BaseBloc {
  late BlocOption option;

  void dispose();
}

class BlocProvider<T extends BaseBloc > extends StatefulWidget {
  final T bloc;
  final Widget child;

  const BlocProvider({
    Key? key,
    required this.bloc,
    required this.child,
  }) : super(key: key);

  @override
  _BlocProviderState createState() => _BlocProviderState();

  static T of<T extends BaseBloc>(BuildContext context) {
    BlocProvider<T>? provider = context.findAncestorWidgetOfExactType.call();
    return provider!.bloc;
  }
}

class _BlocProviderState<T> extends State<BlocProvider<BaseBloc>> {
  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }
}
