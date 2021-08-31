part of '../navigator/contexted_navigator.dart';

/// структура описывающая навигационный стек выбранной ветви контекста
class NavigatorStack {
  /// текущий навигатор
  final _ContextedNavigator _navigator;

  /// дочерние навигаторы
  final List<NavigatorStack> _children = [];

  /// если `true`, значит этот навигатор находится наверху
  /// навигационного стека его родительского навигатора
  /// необходим для работы `WillPopScope`
  bool _isActive;

  bool get isActive => _isActive;

  ContextedNavigator get navigator => _navigator;

  List<NavigatorStack> get children => List.of(_children);

  NavigatorStack({
    required _ContextedNavigator navigator,
  })  : _navigator = navigator,
        _isActive = true;

  static NavigatorStack? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_NavigatorStackInherited>()
        ?.stack;
  }

  /// возвращает часть стека в которой лежит указаный навигатор
  /// возвращает `null` если подходящий стек не найден
  NavigatorStack? findStack(Type currentNavigator) {
    if (navigator.runtimeType == currentNavigator) {
      return this;
    }
    for (var child in children) {
      final res = child.findStack(currentNavigator);
      if (res != null) return res;
    }
  }

  /// возвращяет самый верхний (активный) навигатор из стека
  /// возвращает `null` все навигаторы в стеке не активны
  ContextedNavigator? findLastActive() {
    if (isActive) {
      return _deepFindLastActive();
    }
  }

  _ContextedNavigator _deepFindLastActive() {
    if (children.isEmpty) {
      return _navigator;
    } else {
      for (var child in children) {
        if (child.isActive) {
          return child._deepFindLastActive();
        }
      }
      return _navigator;
    }
  }

  /// возвращяет самый верхний (активный) стек
  /// возвращает `null` все навигаторы в стеке не активны
  NavigatorStack? _findLastActiveStack() {
    if (isActive) {
      return _deepFindLastActiveStack();
    }
  }

  NavigatorStack _deepFindLastActiveStack() {
    if (children.isEmpty) {
      return this;
    } else {
      for (var child in children) {
        if (child.isActive) {
          return child._deepFindLastActiveStack();
        }
      }
      return this;
    }
  }

  void _add(_ContextedNavigator newNavigator) {
    if (_children.map((e) => e.navigator).contains(newNavigator)) {
      final newChildren = _children
          .where((element) => element.navigator != newNavigator)
          .toList()
            ..add(NavigatorStack(navigator: newNavigator));
      _children
        ..clear()
        ..addAll(newChildren);
    } else {
      _children.add(NavigatorStack(navigator: newNavigator));
    }
  }

  void _remove(_ContextedNavigator currentNavigator) {
    _children.removeWhere((element) => element._navigator == currentNavigator);
  }

  void log() {
    var object = JsonDecoder().convert(_toJson());
    var prettyString = JsonEncoder.withIndent('  ').convert(object);
    print('-------------${DateTime.now()}---------------');
    prettyString.split('\n').forEach((element) => print(element));
  }

  String _toJson() => json.encode(_toMap());

  Map<String, dynamic> _toMap() {
    return {
      'navigator':
          '${_navigator.delegate.runtimeType.toString()}, ${_navigator.hashCode}',
      'isActive': isActive,
      'children': children.map((x) => x._toMap()).toList(),
    };
  }
}
