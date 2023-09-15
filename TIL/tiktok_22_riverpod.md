## 틱톡클론 강의 내용 정리 (#22 Riverpod)

### 22.0 Introduction

#### Riverpod이란?

- Provider의 문제점을 해결하고 발전시킨 상태관리 패키지
- Provider간의 결합을 간소화시키고, 위젯트리 밖에서도 사용할 수 있음

#### Riverpod 설치

- 코드 생성 기능 비활성화 후 설치

```dart
// pubspec.yaml
flutter_riverpod: ^2.1.3
```

</br>

### 22.1 NotifierProvider

#### 기존 Provider 관련 코드 삭제

- main.dart의 MultiProvider와 ChangeNotifierProvider를 삭제하고, 앱을 ProviderScope로 감싼다.
- 다른 파일에서도 Provider와 관련된 코드 모두 삭제

#### Notifier 생성

- ViewModel에서 ChangeNotifier를 지우고 riverpod의 Notifier를 생성한다.
- expose할 데이터 타입을 지정해준다.

```dart
// playback_config_vm.dart

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {}
```

- model 대신 state를 통해 데이터에 접근한다. (기존 model 관련 코드 삭제)
- state를 mutate할 수 없으므로 Model을 새로 만들어서 기존 state를 교체한다.

```dart
  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlaybackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }
```

- build 메소드를 통해 데이터 초기값을 반환한다.

```dart
  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
```

#### NotifierProvider 생성

- NotifierProvider를 생성하고, 두개의 타입을 지정해준다. (expose하고 싶은 Provider, Provider가 expose할 데이터)

```dart
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => PlaybackConfigViewModel(),
);

// 원래는 PlaybackConfigViewModel에 repository를 인자로 넣어줘야함
// repository는 sharedpreferences를 필요로 하고
// sharedpreferences는 비동기 작업으로 불러와야 하므로
// 이번 강의에서만 아래와 같이 임시적으로 에러 발생시키고
// main.dart에서 sharedpreference를 불러온 후
// ProviderScope에서 PlaybackConfigViewModel을 override함
final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);

// main.dart
  ProviderScope(
      overrides: [
        playbackConfigProvider
            .overrideWith(() => PlaybackConfigViewModel(repository))
      ],
      child: const TikTokApp(),
    ),
```

</br>

### 22.2 ConsumerWidget

- StatefulWidget을 stateless한 ConsumerWidget으로 변경

```dart
class SettingsScreen extends ConsumerWidget
```

- UI를 업데이트 하는 로직 삭제 (\_onNotificationsChange 메서드 삭제)

#### ConsumerWidget의 build 메소드

- 두번째 인자로 WidgetRef를 받는다.
- WidgetRef를 통해 Proivder의 데이터나 notifier 클래스에 접근할 수 있다.

```dart
   SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) =>
                ref.read(playbackConfigProvider.notifier).setMuted(value),
          ),
```

</br>

### 22.3 Recap

#### Proivder -> Riverpod 마이그레이션

- video_post.dart의 StatefulWidget을 ConsumerStatefulWidget으로, State를 ConsumerState로 바꿔준다.
- WidgetRef를 어디에서나 사용할 수 있다. (cf: ConsumerWidget에서는 build메서드 내에서만 ref 사용 가능)
- ref의 read, watch를 통해 Provider의 데이터에 접근한다.

</br>

### 22.4 AsyncNotifierProvider

#### Model 생성

```dart
class VideoModel {
  String title;
  VideoModel({required this.title});
}
```

#### ViewModel 생성

- AsyncNotifier로 TimelineViewModel을 생성한다.
- AsyncNotifier의 build 메소드는 FutureOr 타입(지정한 타입의 모델 또는 Future)을 반환한다.
- 현재는 DB가 없기 때문에 시뮬레이션을 위해 API 응답시간을 5초로 가정한다.
- build 메소드는 화면이 받을 초기 데이터를 반환한다.

```dart
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  List<VideoModel> _list = [];

  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5));
    return _list;
  }
}

```

#### AsyncNotifierProvider 생성

- 2가지 타입을 지정해준다. (Provider에 해당하는 ViewModel, 데이터에 해당하는 Model)
- ViewModel을 초기화해주는 함수를 인자로 넣어준다.

```dart
final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
```

#### ConsumerStatefulWidget 생성

- TimelineScreen의 StatefulWidget을 ConsumerStatefulWidget으로 변경, State를 ConsumerState로 변경

```dart
class VideoTimelineScreen extends ConsumerStatefulWidget

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {}
```

#### when

- ref.watch를 사용하여 timelineProvider의 데이터에 접근하고, 데이터 응답을 기다리기 위해 `when`
  을 사용한다.

- when의 loading, error 옵션에 로딩, 에러 발생 시 반환할 위젯을 설정할 수 있다.
- when의 data 옵션에서는 데이터를 받은 후 반환할 위젯을 설정해준다.

```dart
Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              'Could not load videos: $error',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (videos) => RefreshIndicator(
            onRefresh: _onRefresh,
            displacement: 50,
            edgeOffset: 20,
            color: Theme.of(context).primaryColor,
            child: PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: _onPageChanged,
              itemCount: videos.length,
              itemBuilder: (context, index) => VideoPost(
                onVideoFinished: _onVideoFinished,
                index: index,
              ),
            ),
          ),
        );
}
```

### 강제로 로딩 상태 유발하기

- state를 loading 상태로 지정한다.

```dart
 Future<void> uploadVideo() async {
    state = const AsyncValue.loading();
    await Future.delayed(const Duration(seconds: 2));
    final newVideo = VideoModel(title: "${DateTime.now()}");
    _list = [..._list, newVideo];
    state = AsyncValue.data(_list);
  }
```
