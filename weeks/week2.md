# 2주차 주간회고록

- 기간: 2023.08.10 (목) ~ 08.16 (수)

<br>

## 💝 핵심 요약

    - 다행히 초심을 잃지 않고 꾸준히 강의 내용을 정리하고 있다.
    - 플러터 UI 만드는 작업이 노가다스럽긴 한데(들여쓰기의 압박) 내장 기능이 많아서 기능 구현은 훨씬 수월한 것 같다.
    - Dart의 클래스 문법이 아직 익숙하지 않은데, 많이 접해보면서 얼른 친해져야겠다.
    - 우버이츠 챌린지가 끝나면 틱톡클론과 애니메이션 강의도 부지런히 예습해야겠다.

<br>

## 🎯 이번주 목표 (완료 시 체크)

- [x] 매일 강의 듣고 일일 스프린트 작성
- [x] Dart 코드 챌린지(Dictionary 구현), Flutter 코드 챌린지(UI Clone)
- [ ] 틱톡클론 예습

<br>

## 👏 칭찬하고 싶은 점

- 강의 내용 요약 정리하는 게 습관화 되고 있다. (힘겹게 느껴지지 않고 즐거움)
- 아침에 일찍 일어나고, 공부하는 동안 스마트폰도 멀리하고 있다.

<br>

## 😓 고치거나 버려야 할 점

- 자기 전에 보상심리로 스마트폰 오랫동안 들여다 보지 않기

<br>

## 🏃‍♀️ 일일 스프린트

- [2023-08-10 (목)](../TIL/20230810.md)

  - [x] Dart 강의 4.0~4.10

- [2023-08-11 (금)](../dart/dictionary.dart)

  - [x] Dart Code Challenge (Dictionary)

- [2023-08-14 (월)](../TIL/20230814.md)

  - [x] 플러터 강의 1.0~2.5
  - [x] 플러터 퀴즈 풀기

- [2023-08-15 (화)](../TIL/20230815.md)

  - [x] 플러터 강의 3.0~3.9
  - [x] [플러터 코드 챌린지 과제 (UI Clone)](../ui_clone/README.md)

- [2023-08-16 (수)](../TIL/20230816.md)

  - [x] 플러터 강의 4.0~4.4
  - [x] 주간회고록 작성

  <br>

## 📝 이번주 배운 내용

### 😊 새롭게 알게 된 것

#### `Dart에서 생성자를 통해 클래스를 다루는 법`

자바스크립트에도 클래스 문법이 있지만, 리액트에서는 주로 함수형 컴포넌트만 다루기 때문에 거의 아는 바가 없었다. 용어 이름 정도만 알았던 constructor, this 등이 클래스 문법에서 어떤 역할을 하는지 알게 되었다. new 키워드를 붙이지 않는 점도 편리했다.

아직까지는 문법이 익숙치 않아서 코드가 거추장스럽 게 느껴진다. 빨리 적응하고 다양한 실전 예제들도 접하면서, **객체지향 언어**의 묘미(?)를 느끼고 싶다!

<br>

#### `Dictionary 코드 챌린지`

Dictionary 클래스를 만들고, 단어를 추가·수정·삭제하는 등의 메소드를 구현하는 과제였다. 관건은 **타입을 어떻게 정의하느냐**였다. 나는 Dart 챌린지를 이미 수료했기 때문에 이전에 했던 과제를 참고해서 제출했지만, Dart를 처음 배운 사람이라면 어떻게 시작해야할지 굉장히 막막했을 것 같다.😨 (나 역시 그랬다..)

내 코드와 니꼬쌤이 작성한 코드를 비교해보았다.

- `Word` 클래스

  - String 타입의 term과 definition을 인자로 받아, Named parameters를 통해 생성자 함수를 선언하고 파라미터를 초기화한다.
  - `질문❓: final 키워드 붙이고 안붙이고의 차이?`  
     final 키워드는 값을 수정할 수 없는 변수를 나타낸다. 나는 term과 definition이 단어를 추가하거나 업데이트하면서 바뀌는 값이라고 생각해서 붙이지 않았는데 니꼬쌤 코드에는 final 키워드가 붙어있었다. Word 클래스 내에서 값을 다시 할당하지 않는다는 뜻인걸까..??

          ```dart
          class Word {
          final String term;
          final String definition;
          Word({
              required this.term,
              required this.definition,
          });
          }
          ```

- `Dictionary` 클래스

  - 단어목록을 저장하는 멤버변수를 선언하고, 이에 대한 타입을 지정해줘야 한다.
  - 나는 `{"김치":"한국음식", "초밥":"일본음식"}`과 같은 `Map<String, String>` 형태로 선언했는데,  
    니꼬쌤은 `Map<String, Word>`로 선언하고, Word 클래스를 Map의 value 값으로 사용했다.

    ```dart
    // 내가 작성한 코드
    typedef DictType = Map<String, String>;

    class Dictionary {
    DictType dict = {};
    }

    // 니꼬쌤이 작성한 코드
    class Dictionary {
    Map<String, Word> words = {};
    }
    ```

  - 내가 작성한 코드는 `Word 클래스의 생성자 함수를 전혀 활용하지 않았다.` (회고록 쓰면서 발견함 🤣)
    - 단어를 추가할 때, 니꼬쌤은 생성자를 호출하여 Word 클래스의 인스턴스를 만들었다.
    ```dart
    void add(String term, String definition) {
        if (!exists(term)) {
        words[term] = Word(
            term: term,
            definition: definition,
        );
        }
    }
    ```
    - 반면 내 코드는 위에서 만든 Word 클래스를 전혀 사용하지 않고,(그냥 선언만 하고 끝남😅) 객체의 value 값으로 definiton을 지정하고 끝나버렸다.
    ```dart
    void add(String term, String definition) {
        if (this.dict.containsKey(term)) {
        print('<$term> already exists in dictionary!');
        } else {
        this.dict[term] = definition;
        print('<$term> added!');
        }
    }
    ```

- `메소드 구현`

  - add, get, delete, update 등 메소드 구현은 그동안 많이 연습했던 CRUD와 구글링의 힘으로 어렵지 않게 수행할 수 있었다.
  - `containsKey` 메서드(Map에 특정 key가 존재하는지 확인)를 사용하여 exist 메소드를 구현하였다.

<br>

#### `UI Clone 코드 챌린지`

- 반복되는 UI를 별도 위젯으로 추출하여 재사용하는 방법에 대해 알게 되었다.
- 클래스 문법을 활용하여 위젯에 파라미터를 전달하고 UI에 값을 바인딩하는 방법을 익혔다.
- 프로필 아바타를 쉽게 만들어주는 `CircleAvatar 위젯`이란 것도 있다.
- 로컬 이미지를 삽입할 때는 `AssetImage`, 외부 이미지를 사용할 때는 `NetworkImage`를 사용한다.

<br>

### 🤔 질문

- 클래스 멤버변수 선언 시 final 키워드 붙이고 안붙이고의 차이
- UI Clone 챌린지에서 사람 이름(ALEX, NANA 등) 하드코딩 하셨는지, 클래스를 활용하셨는지 궁금함

<br>

## ✨ 주간 회의와 조별 활동

### 이번 주 활동

    - 저녁알바 때문에 주간회의에는 참여하지 못할 것 같다.

### 기억에 남는 것

    - 우리 조 이름은 `브이✌조`로 정해졌다고 한다. 조원분의 발표도 기대된다! (주간회의에 참여하지 못하지만 발표 자료는 공유해주시겠죠?🙏)

<br>
