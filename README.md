CodingTestPracticeDirectory
===========================
_코딩 테스트 연습을 위한 연습 파일들을 모아둔 프로젝트_
------------------------------------------


코딩 테스트 연습을 위해서 만든 프로젝트 또는 플레이 그라운드, 코드들을 모아둔 프로젝트입니다.
언어는 Swift, Java, Python, C#입니다.(2021. 06. 02기준)

## Contents
* [Contents](/../..#contents)
<!--
* [Codewars](/../..#codewars)
-->
* [C#](/../..#c)
* [Python](/../..#python)
* [Java](/../..#java)
* [Node.JS](/../..#nodejs)
* [iOS(Swift, Objective-C, RXSwift, SwiftUI)](/../..#iosswift-objective-c-rxswift-swiftui)
* [Wiki](/../..#wiki)
* [References](/../..#references)
* [Version](/../..#version-number)
* [License](/../..#license)

<!--
-------------------------------------------------
## Codewars

  ###### (last edited 2021.05.10)
-->

-------------------------------------------------
## C#

-------------------------------------------------
## Python
* [Python 통합 폴더](/Python): 이론, Codewars, Programmers등 알고리즘을 포함한 Directory
  ###### (last edited 2021.06.02)

-------------------------------------------------
## Java

-------------------------------------------------
## Node.JS

-------------------------------------------------
## iOS(Swift, Objective-C, RXSwift, SwiftUI)
* Codewars(Algorithm)
  - [Directory](/SwiftExamples/Codewars): Codewars문제들 중 Swift로 푼 것들을 모아둔 Playground가 있는 Directory
  ###### (last edited 2021.06.02)

* Playgrounds(for study theories)
  - [Thread](/SwiftExamples/SwiftThreadExample): DispatchQueue를 공부하기 위해서 테스트하는 예제들을 모아둔 Playground(Swift)
  ###### (last edited 2021.05.07)

* Example Applications(for study example UI or Funcions)
  - [Slider(CollectionView)](/SwiftExamples/Examples/CardSlideExampleApp): Horizontal collectionview를 이용한 custom view
  - [PickerViewExample](/SwiftExamples/Examples/PickerViewExample): PickerView와 관련된 예제 - [관련 이슈](https://github.com/pjh6954/CodingTestPracticeDirectory/issues/7#issuecomment-849411599)
  - [TabBar Test App](/SwiftExamples/Examples/TabBarTestApp): Tabbar 사용하는 것과 관련된 예제 - [관련 링크](https://iphonedev.co.kr/iOSDevQnA/178653#0)
  - [Table view select example app](/SwiftExamples/Examples/tableviewSelectExample): tableview와 관련된 질문 해결용 예제 app [관련 링크](https://iphonedev.co.kr/iOSDevQnA/178967#0)
  ###### (last edited 2021.05.31)

* Custom Applications
  - [ARRoboSkeleton](/App/ARRoboSkeleton/ARRoboSkeleton): Skeleton관련 테스트 어플리케이션.(create by DahNyue. 2021.05.10)
  - [DownloadApp](/App/FileDownloader/DownloadApp): 이 앱은 특정 사이트의 데이터를 자동으로 다운로드 하게 하기 위해서 만든 앱입니다.(Swift, Storyboard) - Using Alamofire, Kingfisher
  - [Hello Neumorphism](/App/HelloNeumorphism): Neumorphism 관련 예제 앱(create by DahNyue.)
  - [VideoEditorApp](/App/VideoEditorApp/VideoEditorApp): 이 앱은 영상 편집 기능(잘라내기, Slow motion 등)을 테스트하기 위한 앱입니다.(Swift, Storyboard)
  ###### (last edited 2021.06.01)
  
* SwiftUI
  - [Root Directory](/SwiftUI): SwiftUI와 관련된 Root Directory 경로
  - [FetchJSONandImagesDemo](/SwiftUI/Examples/FetchJSONandImagesDemo): JSON으로 받은 데이터를 이용한 imageview load관련 데모 프로젝트
  - [SwiftUI Full Screen modal](/SwiftUI/Examples/FullScreenModal): Full screen modal과 관련된 데모 프로젝트
  - [MVVM Observed Object LBTA](/SwiftUI/Examples/MVVMObservedObjectsLBTA): MVVM모델을 이용한 Observed object 예제 관련 데모 프로젝트
  - [MVVM Weather](/SwiftUI/Examples/MVVMWeather): MVVM모델을 이용한 날씨 관련 예제 프로젝트
  - [People list with delete feature](/SwiftUI/Examples/PeopleListWithDeleteFeature): listview를 이용하는 예제 관련 데모 프로젝트
  - [Swift UI Buttons](/SwiftUI/Examples/SwiftUIButtons): SwiftUI 버튼들을 만들어보는 예제 관련 데모 프로젝트
  ###### (last edited 2021.06.01)


-------------------------------------------------
## Wiki
* [Home](../../wiki)
* [iOS](../../wiki/iOS)
* [Swift](../../wiki/SWIFT)
* [Python](../../wiki/Python)
###### (last edited 2021.06.08)

-------------------------------------------------
## References
* [How To Write by Markdown](https://gist.github.com/ihoneymon/652be052a0727ad59601): 마크다운 작성에 도움을 많이 받은 링크 
* [SemVer](http://semver.org/): 버전 관리 관련 링크
* [Github 프로젝트 관리하기](https://cheese10yun.github.io/github-project-part3/): Github로 프로젝트 관리하는 방법
###### (last edited 2021.06.01)



### Version Number
[`2.0.1`](/VersionUpdateHistory)

Version Number의 변경방식 
- 버전을 `주.부.수` 숫자로 하고, 각 위치를 `주`, `부`, `수`라 부른다.
- `Root Directory`(해당 repository의 Root)에서 `File` 또는 `Directory`가 생성 또는 삭제 시 `주 버전`을 올린다.

    (새로운 언어 또는 코딩테스트 사이트 정리와 관련된 것이 추가되는 경우일 것이기 때문)
- `부 버전`의 경우 Root Directory의 파일에는 변경이 없으나, `하위 Directory들`에 파일이 추가 또는 삭제 시 올린다.
- `수 버전`의 경우 모든 경로의 `README.md` 또는 `설명 문서`가 변경사항이 있는 경우 올린다. 각 프로젝트(e.g. .playground, .xcodeproj etc)의 파일이 변경되는 경우는 `무시한다`.
- `Merge`와 관련된 액션을 할 때 description에 `현재 버전`과 수정사항 중 어떤 변경사항이 있어서 `변경 버전`으로 변경해야 하는지 설명한다.
```markdown
    Version: `1.0.0`
    Root Directory에 새 폴더 추가하여, `2.0.0`으로 변경 요구.
```


## License

MIT

**Free Software**
