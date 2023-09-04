## 틱톡클론 강의 내용 정리 (#13 settings)

### 13.0 ListWheelScrollView

- CloseButton 위젯: 화면 닫기 기능이 있는 x 버튼 아이콘

- ListWheelScrollView 위젯: 3D 효과가 적용된 바퀴(wheel) 모양 리스트를 만들어주는 위젯, 돋보기 효과(magnification), 직경 비율(diameterRatio) 조절 가능

- CupertinoActivityIndicator(iOS 버전), CircularProgressIndicator(Android 버전), CircularProgressIndicator.adaptive(플랫폼에 맞는 인디케이터)

</br>

### 13.1 AboutListTile

- showAboutDialog 위젯: 팝업을 띄우는 위젯, parameter를 설정하여 애플리케이션 정보를 표시할 수 있음

- AboutListTile 위젯: 애플리케이션에 대한 정보를 팝업으로 띄워주는 위젯, ViewLicenses 클릭 시 앱 라이센스 정보 확인 가능

</br>

### 13.2 showDateRangePicker

- showDatePicker 위젯: Material design 달력에서 날짜를 선택할 수 있는 위젯

- showTimePicker: 시간을 선택할 수 있는 Material design 위젯

- showDateRangePicker: 날짜 범위를 선택할 수 있는 Material design 위젯, appBar 배경색이 흰색인 경우 상단 아이콘이 안보일 수 있으니 builder 옵션에서 appBarTheme을 변경

</br>

### 13.3 SwitchListTile

- SwitchListTile, CheckboxListTile: 끝에 스위치/체크박스가 달려있는 ListTile, value, onChanged 옵션으로 선택 여부 상태 관리

- Switch, CupertinoSwitch, Checkbox 위젯

</br>

### 13.4 CupertinoAlertDialog

- showCupertinoDialog 위젯: builder에서 CupertinoAlertDialog 위젯 반환, actions에는 CupertinoDialogAction 위젯 사용
  - Android 버전은 showDialog/AlertDialog, actions에는 아무 위젯 사용 가능
  - 뒤로가기를 하려면 Navigator.of(context).pop() 사용

</br>

### 13.5 CupertinoActionSheet

- showCupertinoModalPopup 위젯: 모달 외부 영역 클릭 시 모달이 닫힘, builder에는 CupertinoActionSheet 사용, actions에는 CupertinoActionSheetAction 사용

</br>

### 13.6 Conclusions

- Widget Catalog에서 새로운 위젯 참고
