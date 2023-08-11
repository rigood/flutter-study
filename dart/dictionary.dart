class Word {
  String term, definition;

  Word({required this.term, required this.definition});
}

typedef DictType = Map<String, String>;
typedef BulkType = List<DictType>;

class Dictionary {
  DictType dict = {};

  void add(String term, String definition) {
    if (this.dict.containsKey(term)) {
      print('<$term> already exists in dictionary!');
    } else {
      this.dict[term] = definition;
      print('<$term> added!');
    }
  }

  String? get(String term) {
    if (this.dict.containsKey(term)) {
      return this.dict[term];
    } else {
      return '<$term> does not exist in dictionary!';
    }
  }

  void delete(String term) {
    if (this.dict.containsKey(term)) {
      this.dict.remove(term);
      print('<$term> deleted!');
    } else {
      print('cannot delete <$term> because it does not exist in dictionary!');
    }
  }

  void update(String term, String definition) {
    if (this.dict.containsKey(term)) {
      print('<$term> updated from <${this.dict[term]}> to <$definition>');
      this.dict[term] = definition;
    } else {
      print('cannot update <$term> because it does not exist in dictionary!');
    }
  }

  void showAll() {
    print(this.dict);
  }

  int count() {
    return this.dict.length;
  }

  void upsert(String term, String definition) {
    if (this.dict.containsKey(term)) {
      print('<$term> updated from <${this.dict[term]}> to <$definition>');
    } else {
      print('<$term> inserted!');
    }
    this.dict[term] = definition;
  }

  void exists(String term) {
    if (this.dict.containsKey(term)) {
      print('<$term> exists!');
    } else {
      print('<$term> does not exist!');
    }
  }

  void bulkAdd(BulkType listOfWords) {
    for (var word in listOfWords) {
      this.dict[word["term"]!] = word["definition"]!;
      print('<${word['term']}> added!');
    }
  }

  void bulkDelete(List<String> listOfTerms) {
    for (var term in listOfTerms) {
      this.dict.remove(term);
      print('<$term> deleted!');
    }
  }
}

void main() {
  // 인스턴스 생성
  var myDict = Dictionary();

  // 단어 추가
  myDict.add('apple', '사과');
  myDict.add('apple', '사과');

  // 단어 정의 리턴
  print(myDict.get('apple'));

  // 단어 삭제
  myDict.delete('banana');
  myDict.delete('apple');
  print(myDict.get('apple'));

  // 단어 업데이트
  myDict.update('apple', '사과');
  myDict.add('apple', '포도');
  myDict.update('apple', '사과');
  print(myDict.get('apple'));

  // 모든 단어 보기
  myDict.add('banana', '바나나');
  myDict.showAll();

  // 단어 개수
  print(myDict.count());

  // 단어 업데이트+삽입
  myDict.upsert('apple', '맛있는 사과');
  myDict.upsert('watermelon', '수박');

  // 단어 존재 여부 확인
  myDict.exists('strawberry');
  myDict.exists('watermelon');

  // 단어 여러개 추가
  myDict.bulkAdd([
    {"term": "김치", "definition": "대박이네~"},
    {"term": "아파트", "definition": "비싸네~"}
  ]);

  // 단어 여러개 삭제
  myDict.bulkDelete(["김치", "아파트"]);
}
