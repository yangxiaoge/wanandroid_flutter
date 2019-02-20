import 'package:rxdart/rxdart.dart';

import 'bloc_provider.dart';

///RxDart原理 https://juejin.im/post/5bcea438e51d4536c65d2232
class ApplicationBloc implements BlocBase {
  ///缓存最新一次事件的广播流控制器：BehaviorSubject
  BehaviorSubject<int> _appEvent = BehaviorSubject<int>();

  Sink<int> get _appEventSink => _appEvent.sink;

  Stream<int> get appEventStream => _appEvent.stream;

  @override
  void dispose() {
    _appEvent.close();
  }

  @override
  Future getData({String labelId, int page}) {
    return null;
  }

  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return null;
  }

  ///add 到 Observable（可观察者）之后，listen（监听者）就能收到
  void sendAppEvent(int type) {
    _appEventSink.add(type);
  }
}
