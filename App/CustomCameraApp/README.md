# Custom Camera App
### [질문 원본 링크](https://iphonedev.co.kr/iOSDevQnA/183621)

- [카메라 참고 링크](https://youtu.be/ZYPNXLABf3c)
- [이미지의 touch event 처리 링크](https://stackoverflow.com/a/35088055/13049349)
- [이미지 Merge 참고 링크 1](https://stackoverflow.com/a/32408980/13049349)

## 실행 이미지
![RPReplay_Final1627351899](https://user-images.githubusercontent.com/37360920/127086461-bd66e8cf-c68b-4419-9307-ee166a521435.gif)

- 카메라 session이 실행되고, 그 위에 backgroundColor = .clear상태인 image를 그리기 위한 uiview(imageContainer), 그 위에 capture button이 그려진다.
- imageContainer안에는 원하는 Image가 들어가있는 UIImageView가 그려진다.(image가 존재할 때)
- Capture button을 터치하면, 사진을 캡쳐하고, 해당 이미지와 imageContainer의 이미지를 합성해서 새로운 image가 생성되어 반환된다.
- 그 후 UIImageView가 그려지는데, 해당 뷰는 단순히 만들어진 image를 보여주는 view이다.


### 미처리 사항
- Take Photo를 통해 생성된 Image와 imageContainer의 view를 합쳐서 만들 때 Image의 사이즈가 맞지 않아 resize되듯이 보이는 현상이 있음.
