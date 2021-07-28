# WKWebView 생성과 관련된 예제 앱
- [원본 질문](https://iphonedev.co.kr/hybridAppQna/183803)
- 해당 질문에서 발생한 wkwebview를 벗어나는 문제에 대해서 궁금증에 만들게 된 앱.
1. WKWebview의 top이 safearea의 top과 동일한 상태에서 navigation bar가 투명인 경우 : m.daum.net에서 스크롤시 정상적으로 보여짐(벗어나는 부분 없음)
2. WKWebview의 top이 superview의 top과 동일한 상태에서 navigation bar가 투명인 경우 : m.daum.net에서 스크롤시 상단에 나타나는 bar는 navigation의 하단(safearea영역)에 나타나는데, contents는 safearea를 벗어나서 superview와 동일하게 보임.
