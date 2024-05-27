import 'dart:async';

final logs = <String>[];

List<String> getLog(String method, Object? event) {
  return ['[base_bloc_observer.dart] $method(FakeBloc, $event)'];
}

void Function() overridePrint(void Function() testFn) {
  return () {
    final spec = ZoneSpecification(
      print: (_, __, ___, String msg) => logs.add(msg),
    );
    return Zone.current.fork(specification: spec).run<void>(testFn);
  };
}
