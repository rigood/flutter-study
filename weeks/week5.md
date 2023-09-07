# 5주차 주간회고록

- 기간: 2023.08.31 (목) ~ 09.06 (수)

<br>

## 💝 핵심 요약

    - 과제만 겨우 끝내고 예습을 못하고 있다. 😂
    - 플러터 위젯의 끝은 어디인가? 신기하면서도 그만큼 공부할 게 많아 벅차다.

<br>

## 🎯 이번주 목표 (완료 시 체크)

- [🔺] 틱톡클론 강의 내용 정리
- [⭕] 틱톡클론 코드챌린지 제출 (Write Screen, Search & Activity, Profile & Settings)

<br>

## 👏 칭찬하고 싶은 점

- 없다.

<br>

## 😓 고치거나 버려야 할 점

- 낮잠 그만 자기
- 부지런히 예습하기

  <br>

## 🏃‍♀️ 일일 스프린트

- 2023-08-31 (목)

  - [x] [코드챌린지 과제 (Write Screen)](../threads/README.md/#code-challenge-write-screen)

- 2023-09-02 (토)

  - [x] [코드챌린지 과제 (Search & Activity)](../threads/README.md/#code-challenge-search--acitivity)

- 2023-09-04 (월)

  - [x] [틱톡클론 강의 12 user profile](../TIL/tiktok_12_user_profile.md)
  - [x] [틱톡클론 강의 13 settings ](../TIL/tiktok_13_settings.md)

- 2023-09-05 (화)

  - [x] [코드챌린지 과제 (Profile and Settings)](../threads/README.md/#code-challenge-profile-and-settings)

  <br>

## 📝 이번주 배운 내용

### 😊 새롭게 알게 된 것

#### 코드챌린지 (Search & Activity)

- `CupertinoSearchTextField`
  - iOS 스타일의 검색바를 만들어주는 위젯
- `ListTile`
  - leading, title, trailing으로 구성됨
  - 간단한 UI를 만들 때는 편리하지만, 커스텀하기 어려운 것 같다.
- `TabBar`
  - DefaultTabController로 TabBar와 TabBarView를 연결하여 사용한다.

</br>

#### 코드챌린지 (Profile and Settings)

- `CustomScrollView`
  - sliver를 이용하여 스크롤 효과를 커스텀할 수 있음
- `SliverAppBar`
  - 스크롤에 따라 모양이 변하는 AppBar
- `SliverPersistentHeader`
  - 스크롤을 내릴 때 화면 상단에 고정시킬 수 있는 헤더
  - sliver 레이아웃에 대한 정보를 담은 SliverPersistentHeaderDelegate를 인자로 넣어줘야 한다.
  - SliverPersistentHeaderDelegate에서 maxExtent와 minExtent를 설정해야 하는데, 처음에는 임의의 값을 입력하여 실행한 후, 에러메시지에 나온 paintExtent 값을 넣어준다.
- `CupertinoAlertDialog` / `AlertDialog`
  - 전자는 iOS, 후자는 Android용 대화상자이다.
  - 바깥 영역을 클릭하면 자동으로 창이 닫힌다.
- `CircularProgressIndicator.adaptive()`
  - 플랫폼에 따라 알맞는 로딩바를 보여준다.
  - 크기를 직접 조절할 수는 없고, SizedBox로 감싸주어야 한다.

### 🤔 질문

<br>

## ✨ 주간 회의와 조별 활동

### 이번 주 활동

### 기억에 남는 것

<br>
