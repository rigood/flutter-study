# 6주차 주간회고록

- 기간: 2023.09.07 (목) ~ 09.13 (수)

<br>

## 💝 핵심 요약

- 웹개발과 달리 휴대폰 내장기능을 활용할 수 있어 신기하고 재밌다.
- 예습을 안하면 내 머리와 손이 고생한다.
  - Router migration 코드챌린지 할 때, 스케쥴 표에 나와있는 강의만 듣고 겨우겨우 제출했는데 section 20에서 니꼬쌤이 방법을 다 알려주셨다 ㅎㅎ
  - 미리 예습했으면 좀 더 수월하게 할 수 있었겠지만, 삽질을 통해 배우는 것도 의미가 있다고 생각한다! 😂
- 니꼬쌤은 정말 잘 가르치시는 것 같다..👍

  <br>

## 🎯 이번주 목표 (완료 시 체크)

- [🔺] 틱톡클론 강의 내용 정리
  - ❌ 14 반응형, 15 다크모드, 16 번역, 17 내비게이션1
  - ⭕ 18 내비게이션2, 19 비디오녹화, 20 상태관리
- [⭕] 틱톡클론 코드챌린지 제출 (Photos, Dark mode, Navigator2, Router migration)
- [❌] 틱톡클론 강의 예습

<br>

## 👏 칭찬하고 싶은 점

- 지난주보다는 열심히 공부한 점

<br>

## 😓 고치거나 버려야 할 점

- 코드챌린지 부분만 공부하고, 나머지는 강의만 대충 듣고 지나간 점
- Firebase 설치까지 해보려고 했는데, 수강생 분들이 설치 오류 관련하여 댓글 달아놓은 거 보고 의욕을 잃고 포기한 점

  <br>

## 🏃‍♀️ 일일 스프린트

- 2023-09-07 (목)

  - [x] [5주차 주간회고록 작성](./week5.md)
  - [x] [틱톡클론 강의 19 video recording](../TIL/tiktok_19_video_recording.md)

- 2023-09-08 (금)

  - [x] [코드챌린지 과제 (Photos)](../threads/README.md/#code-challenge-photos)

- 2023-09-10 (일)

  - [x] [코드챌린지 과제 (Dark mode)](../threads/README.md/#code-challenge-dark-mode)

- 2023-09-11 (월)

  - [x] [틱톡클론 강의 18 Navigator2](../TIL/tiktok_18_navigator2.md)

- 2023-09-12 (화)

  - [x] [코드챌린지 과제 (Router migration)](../threads/README.md/#code-challenge-router-migration)

- 2023-09-13 (수)

  - [x] [틱톡클론 강의 20 Router](../TIL/tiktok_20_router.md)
  - [x] [틱톡클론 강의 20 State Management](../TIL/tiktok_20_state_management.md)
  - [x] 틱톡클론 퀴즈 풀기
  - [x] [코드챌린지 과제 리팩토링 (Router migration)](https://github.com/rigood/flutter-study/commit/fc71e821acf7b856e9b5f3892fe4d764273e547e#)
  - [x] [6주차 주간회고록 작성](./week6.md)

  <br>

## 📝 이번주 배운 내용

### 😊 새롭게 알게 된 것

#### section 19 video recording

- 여러가지 `패키지` 사용방법 학습

  - `camera` : 카메라 (사진촬영, 비디오녹화)
  - `permission_handler` : 권한 설정
  - `video_player` : 비디오 재생
  - `gallery_saver` : 갤러리에 저장
  - `image_picker` : 갤러리에서 사진 선택

- `AnimationController`를 사용하여 로딩바가 채워지는 효과 구현하기

  - CircularProgressIndicator의 value에 AnimationController.value를 넣어줌
  - addListener로 매 순간 상태변화를 감지하고,
  - addStatusListener를 통해 애니메이션이 끝났을 때 녹화를 중단함

- `GoRouter`

  - URL을 기반으로 페이지를 이동하는 방식, go_router 패키지 설치해야함
  - routerConfig를 만들어서 MaterialApp.router에 적용
  - context가 확장되어 push, pop, go 등의 메소드를 사용할 수 있음
  - GoRouter에 name을 부여할 수 있으며, context.pushNamed(name), context.goNamed(name)으로 페이지 이동
  - URL에 파라미터, 쿼리스트링 사용하는 방법 (state.params, state.queryparams)
  - URL에 표시하지 않고 데이터를 보내는 방법 (state.extra)
  - 중첩 라우팅
  - pageBuilder에 CustomTransitionPage를 사용하여 페이지 전환 시 트랜지션 적용

- `State Management`
  - InheritedWidget
    - 위젯 트리 최상단에 InheritedWidget을 놓고 데이터를 저장하면, 자식 위젯 어디에서든지 데이터에 접근할 수 있음
    - 단점: 데이터가 변경되면 앱 전체가 rebuild되어 성능저하, 여러개의 InheritedWidget을 사용하는 경우 구조가 복잡해짐, 데이터를 업데이트 할 수 없음
  - InheritedWidget & StatefulWidget
    - StatefulWidget에서 데이터와 데이터 변경함수를 생성하고, 자식 위젯인 InheritedWidget에게 넘겨준다.
    - 단점: 앱의 구조가 장황하고 복잡해짐
  - ChangeNotifier
    - notifyListeners()로 데이터가 변경되었다고 listeners에게 알려준다.
  - ValueNotifier
    - 단일 값에 대해 적용되며, 값이 변경되면 listeners에게 알려준다.
  - provider
    - 상태관리를 위한 패키지
    - 데이터를 사용할 부분을 Provider로 감싸서 사용한다. provider가 여러개인 경우 MultiProvider로 감싸고 providers에 Provider 리스트를 전달한다.
    - context.watch(), context.read()를 통해 프로퍼티, 메소드에 접근할 수 있다.

### 🤔 질문

- AppLifecycleState에 resumed, inactive, hidden 등이 있는데 정확히 언제 해당 이벤트가 발생하는 건지, 어떻게 활용할 수 있는지 궁금하다.

  <br>

## ✨ 주간 회의와 조별 활동

### 이번 주 활동

### 기억에 남는 것

<br>
