# 4주차 주간회고록

- 기간: 2023.08.24 (목) ~ 08.30 (수)

<br>

## 💝 핵심 요약

    - 코드챌린지 과제도 제출하고, 강의 내용 정리도 꾸준히 하고 있다.
    - 시간에 쫒기면서 하느라 마감 기한 지키는데 의의를 두고 있는데, 앞으로는 퀄리티에도 신경쓰자.
    - 코드챌린지에 정답이나 피드백이 없어서 아쉽다. 내 코드가 잘 짜여진건지, 더 나은 방법은 없는지 알고 싶다.
    - 예습하는데 좀 더 시간 투자를 해야할 것 같다.

<br>

## 🎯 이번주 목표 (완료 시 체크)

- [x] 틱톡클론 강의 내용 정리
- [x] 틱톡클론 코드챌린지 제출 (onBoarding part2, Navigation Time)

<br>

## 👏 칭찬하고 싶은 점

- 플러터 우수졸업작품에 선정되었다.
- 코드챌린지 제출 후 다시 한번 리팩토링을 진행했다. (onBoard1)
- 집중력이 좋아지고 딴짓하는 시간이 줄었다.

<br>

## 😓 고치거나 버려야 할 점

- 예습에 좀 더 시간 투자하기

  <br>

## 🏃‍♀️ 일일 스프린트

- 2023-08-25 (금)

  - [x] [틱톡클론 강의 5.1~5.4](../TIL/20230825.md)
  - [x] [코드챌린지 과제 리팩토링 (onBoarding1)](../onboarding/README.md)

- 2023-08-26 (토)

  - [x] [코드챌린지 과제 (onBoarding2)](../onboarding/README.md)

- 2023-08-28 (월)

  - [x] [틱톡클론 강의 6.0~6.8](../TIL/20230828.md)

- 2023-08-29 (화)

  - [x] [코드챌린지 과제 (Navigation Time)](../threads/README.md)

- 2023-08-30 (수)

  - [x] [틱톡클론 강의 8.0~8.4](../TIL/20230830.md)
  - [x] [4주차 주간회고록 작성](week4.md)

  <br>

## 📝 이번주 배운 내용

### 😊 새롭게 알게 된 것

#### 틱톡클론 #5 OnBoarding

- `collection for, collection if`를 활용하여 children에서 위젯을 렌더링 하는 방법
- flex-wrap: wrap에 해당하는 `Wrap 위젯`
- `버튼 생성` 3가지 방법(Container로 커스텀, TextButton, CupertinoButton)
- `Scrollbar 위젯`으로 스크롤바 생성 (controller 달아줘야함)
- `AnimatedOpcacity, AnimatedContainer 위젯`으로 애니메이션 주기
- `TabBarView, TabPageSelector`로 탭 화면, 인디케이터 만들기
- `AnimatedCrossFade`로 두 컴포넌트 간에 fade in, out 효과 주기

#### 틱톡클론 #6 Tab Navigation

- `Navigator.pushAndRemoveUntil`로 화면 푸쉬할 때 이전화면 제거하기
- bottomNavigationBar에 사용되는 위젯
  - `BottomNavigationBar` - material design2, 탭 아이콘을 items로 표현
  - `NavigationBar` - material design3, 탭 아이콘을 destinations으로 표현
  - `CupertinoTabBar` - iOS 위젯이므로 상위 위젯도 cupertino 버전으로 바꿔야함
  - `BottomAppBar` - 커스텀할 때 사용
- 탭 화면 전환 시에도 state를 유지하려면 `Offstage 위젯`을 사용하여 화면을 숨기는 방법 사용
- `Stack 위젯`을 사용하여 위젯을 겹칠 수 있음, 자식 위젯으로는 Stack의 크기를 결정하며 기준점이 되는 Container가 있어야 하고, 이 Container를 기준으로 `Positioned 위젯`으로 offset값을 조절하여 배치

#### 틱톡클론 #8 Comments

- `showModalBottomSheet`로 하단시트를 불러올 수 있음
- Future를 반환하므로 async-await으로 하단시트를 불러온 후 실행할 동작을 설정할 수 있음
- `ListView.separated`로 아이템 목록과 구분자를 렌더링하는 방법 복습
- Row에서 Expanded 사용하면 남은 공간을 다 차지함
- 댓글입력창은 키보드 위로 올라와야 하므로 키보드가 올라올 때 아래로 사라지는 bottomNavigationBar 대신 Stack 구조에서 Positioned로 위치를 잡아줘야함
- `TextInputAction`을 통해 입력 후 실행할 동작을 설정할 수 있고, `minLines` 등을 통해 TextField의 라인수를 지정할 수 있음

#### 코드챌린지

- Column의 남는 공간을 다 차지하는 수직선 긋기 (잌하이님 Tip)

  - `Expanded` 안에 `VerticalDivider` 사용

- `IntrinsicHeight` (henry님 Tip)

  - 레이아웃 위젯에 속하는 Row 위젯은 제약조건이 없으면 무한한 높이를 가지므로,
  - IntrinsicHeight으로 감싸서 자식의 높이만큼 height를 가지도록 설정해준다.

- `FocusScopeNode`

  - 한 글자씩 Code를 입력하는 창에서 다음 칸으로 포커스를 줄 때 사용

  ```dart
  final FocusScopeNode focus;

  TextField(
          autofocus: true,
          keyboardType: TextInputType.number,
          onChanged: (newValue) {
          if (newValue.length == 1) {
              focus.unfocus();
              if (!isLastFocus) {
              focus.nextFocus();
              } else {
              onComplete!();
              }
          }
          },
          textInputAction: TextInputAction.next,
  )
  ```

### 🤔 질문

<br>

## ✨ 주간 회의와 조별 활동

### 이번 주 활동

    - 코어타임 2번 참여

### 기억에 남는 것

<br>
