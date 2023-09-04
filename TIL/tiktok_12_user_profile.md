## 틱톡클론 강의 내용 정리 (#12 user profile)

## 12.0 Introduction

- 이번 섹션에서는 CustomScrollView에 대해 배울 예정
- 스크롤에 따라 Header 숨기기

</br>

## 12.1 CustomScrollView

- CustomScrollView의 slivers 속성에 스크롤할 대상을 넣어준다.
- sliver에는 특정한 위젯만 사용할 수 있다.
- SliverAppBar란 스크롤 가능하며 확장할 수 있는 AppBar이다.

```dart
CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          stretch: true,
          pinned: true,
          backgroundColor: Colors.teal,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
            ],
            background: Image.asset(
              "assets/images/placeholder.jpg",
              fit: BoxFit.cover,
            ),
            title: const Text("Hello!"),
          ),
        )
      ],
    );
```

</br>

## 12.2 SliverAppBar

#### SliverAppBar 속성

- SliverAppBar의 기본동작: 아래로 스크롤하면 배경이미지 -> 배경색 -> flexible space bar의 title -> 전부 사라짐

- `floating: true`: 위로 살짝 스크롤하면 SliverAppBar가 서서히 다시 나타나고 올라갈 때까지 사라지지 않음

- `pinned: true`: 배경색과 flexible space bar의 title을 보여줌

- `snap: true`: 위로 살짝만 스크롤해도 SliverAppBar 전체가 나타남

- `stretch: true`: flexibleSpace의 stretchModes 활성화, 배경이미지를 blur, zoom하거나 title에 fade 효과를 줄 수 있음

#### SliverFixedExtentList

```dart
  SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          itemExtent: 100,
        )
```

</br>

## 12.3 SliverGrid

```dart
  SliverGrid(
          delegate: SliverChildBuilderDelegate(
            childCount: 50,
            (context, index) => Container(
              color: Colors.blue[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1,
          ),
        )
```

</br>

## 12.4 SliverPersistentHeader

#### list, grid에 header 달아주고 화면에 고정시키기

- SliverPersistentHeader 위젯 사용, delegate 속성에는 SliverPersistentHeaderDelegate를 확장한 CustomDelegate를 넣어줌

```dart
        SliverPersistentHeader(
          delegate: CustomDelegate(),
          floating: true,
        ),
```

- CustomDelegate에서 SliverPersistentHeaderDelegate 위젯의 4가지 메소드를 override 해야함

```dart
class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        heightFactor: 1,
        child: Center(
          child: Text(
            'Title!!!!!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
```

- 최대높이, 최저높이를 나타내는 maxExtent, minExtent는 getter이므로 double을 return
- build 메소드는 widget을 return
- persistentHeader 표시 여부를 나타내는 shouldRebuild 메소드는 bool 값을 return

  - maxExtent, minExtent의 값을 변경하려면 true를 return 해야함

- SliverPersistentHeader를 고정시키려면 `pinned: true` 설정

#### SliverToBoxAdapter

- CustomScrollView에 랜덤한 위젯을 포함시킬 때 사용하는 위젯

```dart
       SliverToBoxAdapter(
          child: Column(
            children: const [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
              )
            ],
          ),
        ),
```

</br>

### 12.5 Vertical Divider

- 특정 높이를 가진 parent 아래에 사용할 수 있다.
- indent, endIndent를 이용하여 선이 시작하는 위치, 끝나는 위치를 지정할 수 있다.
- thickness는 선의 굵기를, width는 옆 위젯과의 간격을 나타낸다.

```dart
  VerticalDivider(
        width: Sizes.size32,
        thickness: Sizes.size1,
        color: Colors.grey.shade400,
        indent: Sizes.size14,
        endIndent: Sizes.size14,
    ),
```

</br>

### 12.6 TabBar

- TabBar 위젯을 사용하여 grid, heart 아이콘으로 탭 만들기

- TabBar 아래에 스크롤되는 grid를 넣으려면?

  - SliverGrid -> SliverToBoxAdapter 안에서 사용할 수 없음
  - GridView.builder -> CustomScrollView, GridView에서 이중 스크롤 되는 문제
  - NestedScrollView

</br>

### 12.7 PersistentTabBar

#### NestedScrolView

- CustomScrollView를 NestedScrolView로 변경
- NestedScrolView의 headerSliverBuilder에는 SliverAppBar, SliverToBoxAdapter를 넣어주고
- NestedScrolView의 body에는 TabBarView(GridView 포함), TabBarView를 넣어줌

#### PersistentTabBar

- 12.4에서 배웠던 내용 복습

</br>

### 12.8 Conclusions

- video_post 위젯 버그 수정
  - \_onVisibilityChanged 메소드에 `if(!mounted) return` 코드 추가
  - mount 되었을 때만 \_onVisibilityChanged 메소드 내 코드 실행하도록 변경
