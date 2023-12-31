# 1. Code Challenge [Navigation Time]

- Requirements

  - Home Screen: 스크롤 가능한 글 목록
  - Post Component
    - 게시물 종류 2가지: 1) 텍스트, 2) 이미지(스와이프 기능)
  - Navigation
    - 5개의 탭 아이콘
    - 탭 아이콘 색상 (회색 -> 선택 시 검은색)
    - Home Screen 이외 화면은 Placeholder 사용 가능

- [🚀 구현 영상 제출](https://imgur.com/a/wQPSKNL)

</br>

# 2. Code Challenge [Bottom Sheet]

- Requirements

  - ellipsis 버튼 클릭 시 하단 bottomSheet 팝업
  - 하단 시트에는 Unfollow, Mute, Hide, Report 버튼 존재
  - Report 버튼 클릭 시 하단 시트 내 다른 화면으로 이동
  - Report 화면에는 헤더와 신고 항목 목록이 존재

- [🚀 구현 영상 제출](https://imgur.com/a/wvrnTi1)

  <img src="./demo2-bottom-sheet.gif"  width="300"/>

</br>

# 3. Code Challenge [Write Screen]

- Requirements

  - 하단 Navigation의 3번째 아이콘 버튼 클릭 시 Write 화면으로 이동
  - Write 화면은 화면 하단에서 올라와야함
  - Cancel 버튼을 누르면 뒤로 돌아가기
  - 사용자가 입력창에 글을 입력하면 Post 버튼 활성화

- [🚀 구현 영상 제출](https://imgur.com/a/1ooo7hN)

  <img src="./demo3-write-screen.gif"  width="300"/>

</br>

# 4. Code Challenge [Search & Acitivity]

- Requirements

  - CupertinoSearchTextField, ListTitle, TabBar 사용하기
  - 최대한 주어진 스크린샷과 비슷하게 클론코딩 하기

- [🚀 구현 영상 제출](https://imgur.com/a/C9yavyP)

  <img src="./demo4-search-activity.gif"  width="300"/>

</br>

# 5. Code Challenge [Profile and Settings]

- Requirements

  - Profile Screen
    - 헤더와 2개의 탭(Threads, Replies)
    - 오른쪽 상단 아이콘 클릭 시 Settings 화면으로 이동
    - CustomScrollView, SliverAppBar, SliverPersistentHeader 사용
  - Settings Screen
    - ListTile 사용
    - Privacy 타일 클릭 시 Privacy 화면으로 이동
    - 로그아웃 버튼 클릭 시 플랫폼에 맞는 로딩 인디케이터 표시
    - iOS는 CupertinoAlertDialog 사용, Android는 AlertDialog 사용
  - Privacy Screen
    - SwitchListTile 사용

- [🚀 구현 영상 제출](https://imgur.com/a/cNVHdHX)

  <img src="./demo5-profile-settings.gif"  width="300"/>

</br>

# 6. Code Challenge [Photos]

- Requirements

  - Write Screen
    - 첨부파일 아이콘 클릭 시 Camera 화면으로 이동
  - Camera Screen
    - 사진을 찍거나 갤러리에서 사진 선택
    - 촬영한 사진 또는 선택한 사진이 첨부된 Write 화면으로 이동

- [🚀 구현 영상 제출](https://imgur.com/a/8jAz4Yu)

</br>

# 7. Code Challenge [Dark Mode]

- Requirements

  - Home, Search, Activity, Profile 화면을 다크모드로 바꾸기

- [🚀 구현 영상 제출](https://imgur.com/a/A9GnEmB)

  <img src="./demo7-dark-mode.gif"  width="300"/>

</br>

# 8. Code Challenge [Router Migration]

- Requirements

  - GoRouter로 마이그레이션

  ```dart
  /: Home Screen
  /search: Search Screen
  /activity: Activity Screen
  /profile: Profile Screen
  /settings: Settings Screen
  /settings/privacy: Privacy Screen
  ```

- [🚀 구현 영상 제출](https://imgur.com/a/3krvCK6)

  <img src="./demo8-router-migration.gif"  width="300"/>

</br>

# 9. Code Challenge [MVVM + Provider + Dark Mode]

- Requirements

  - Provider, MVVM 패턴을 사용하여 설정 화면에서 다크모드 스위치 구현
  - ChangeNotifier, ChangeNotifierProvider 사용

- [🚀 구현 영상 제출](https://imgur.com/a/4sBfjsE)

  <img src="./demo9-mvvm-provider-darkmode.gif"  width="300"/>

</br>

# 10. Code Challenge [Riverpod]

- Requirements

  - Proivder -> Riverpod으로 마이그레이션
  - Riverpod, MVVM 패턴을 사용하여 설정 화면에서 다크모드 스위치 구현

- [🧸 깃허브 커밋 링크](https://github.com/rigood/flutter-study/commit/b8313c9418a834efae195d64ba1ecce61dcf798b)

</br>

# 11. Code Challenge [Authentication]

- Requirements

  - Firebase authentication을 사용하여 계정 생성 및 로그인 구현
  - 계정생성, 로그인 화면에는 이메일, 비밀번호를 입력받는 양식이 있어야함
  - 사용자가 양식을 제출하면 Firebase 인증을 통해 계정생성/로그인 후 홈 화면으로 이동해야함

- [🚀 구현 영상 제출](https://imgur.com/a/4sBfjsE)

  <img src="./demo11-authentication.gif"  width="600"/>

</br>

# 12. Code Challenge [Real Data]

- Requirements

  - Write Screen
    - 글에 이미지 첨부 기능 구현
    - 이미지는 Firebase Storage에 저장
    - 글은 Firebase FireStore에 저장
  - Home Screen
    - Firebase FireStore에서 글 불러오기
    - Firebase Storage에서 이미지 불러오기

- [🚀 구현 영상 제출 (수정 전)](https://imgur.com/a/qbyOylK)
- [🚀 구현 영상 제출 (글 업로드 후 목록에 반영되도록 수정)](https://imgur.com/a/9WkIfoW)  
  <img src="./demo12-real-data.gif"  width="600"/>

</br>

# 13. Code Challenge [Search posts]

- Requirements

  - 검색창에 입력한 텍스트를 기준으로 필터링
  - 글은 Firebase FireStore에서 불러오기

- [🚀 구현 영상 제출](https://imgur.com/a/8lTzeRx)

  <img src="./demo13-search-posts.gif"  width="300"/>
