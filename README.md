## iOS 커리어 스타터 캠프

### 계산기

# 목차
  
1. [제목](#제목)
2. [소개](#소개)
3. [팀원](#팀원)
4. [타임라인](#타임라인)
5. [프로젝트 구조](#프로젝트-구조)
6. [실행화면](#실행화면)
7. [트러블 슈팅](#트러블-슈팅)
8. [참고 링크](#참고-링크)

## 제목

- 계산기

## 소개

- 사용자가 숫자패드와 기호를 통해 입력한 값의 연산 결과를 출력하는 앱입니다.

## 팀원

| [Ayaan](https://github.com/oneStar92) | [제이푸시](https://github.com/jjpush) |
|:---:|:---:|
|<img src= "https://i.imgur.com/Unq1bdd.png" width ="100%"/>| <img src= "https://i.imgur.com/bRxss8l.jpg" width = "300"/>|


## 타임라인

- Step 1
    - CalculatorQueue 병합
    - ExpressionParser 병합
    - FormulaStackView 병합
<details>
<summary>Details</summary>
    <div markdown="1">

- 2022.10.04
    - CalculatorQueue 병합
    - ExpressionParser 병합
    - FormulaStackView 병합

    </div>
</details>

- Step 2
    - 네이밍 변경.
    - 기능과 역할 분리
<details>
<summary>Details</summary>
    <div markdown="1">
        
- 2022.10.06
    - NumberLabel 역할 분리
- 2022.10.07
    - 숫자 입력 기능 Refactoring
    - 연산자 입력 기능 Refactoring
    - 부호 입력 기능 Refactoring
    - 소수점 입력 기능 Refactoring
    - 전반적인 네이밍 및 컨벤션 수정

    </div>
</details>
  
## 프로젝트 구조


## 실행화면

|정상적인 계산|연산자 변경|
|:---:|:---:|
| <img src="https://i.imgur.com/MLjDxur.gif" width="400"/>| <img src="https://i.imgur.com/RjYZTea.gif" width="400"/>|

|0으로 나누기| 소수 계산|
|:---:|:---:|
| <img src="https://i.imgur.com/RPvuIVh.gif" width="400"/>| <img src="https://i.imgur.com/1A1fLpl.gif" width="400"/>|

## 트러블 슈팅

### 0이 중복으로 입력되는 버그
- 숫자를 저장하는 `numberString` 프로퍼티에 0이 계속해서 쌓이는 버그가 발생했습니다.
- `propertyWrapper`를 이용해서 0과 00을 클릭할 시 현재 저장되어 있던 숫자가 0이면 숫자의 입력 결과는 0이 되도록 구현하여서 해결했습니다.

| Before | After |
|:---:|:---:|
|<img src="https://i.imgur.com/4ZZqOZx.gif" width="400"/>|<img src="https://i.imgur.com/BilARAq.gif" width="400"/>|


### 0에 소수점 입력시 0이 사라지는 버그
- 0의 중복을 체크하는 로직에 의해 소수점을 입력하면 숫자가 저장되는 변수가 '.'가 되어 0이 없어지는 버그가 발생했습니다.
- 0의 중복을 체크하는 로직을 수정하여 숫자가 저장되는 변수에 소수점이 정상적으로 입력되게 수정했습니다. 

| Before | After |
|:---:|:---:|
|<img src="https://i.imgur.com/zyEn6rD.gif" width="400"/>|<img src="https://i.imgur.com/VjeNoQw.gif" width="400"/>|


### 계속해서 소수점이 입력되는 버그
- `last`키워드를 사용하여 마지막 값이 소수점이 아니면 소수점을 입력하는 로직을 사용하여서 계속해서 소수점을 입력할 수 있는 버그가 발생했습니다.
- `contains()`메소드를 이용하여 소수점이 없는경우에만 소수점을 입력하게 수정하여서 해당 버그를 해결했습니다.

| Before | After |
|:---:|:---:|
|<img src="https://i.imgur.com/6BJctYT.gif" width="400"/>|<img src="https://i.imgur.com/oJKZBjv.gif" width="400"/>|



### 초기화면에서 연산자가 변경 가능한 버그
- 초기화면에서 연산자가 변경이 가능하여 숫자를 입력한 후 연산자를 입력하면 초기화면에서 변경된 연산자가 StackView에 같이 등록되는 버그가 발생했습니다.
- 초기화면이라는 상태를 알려주는 변수 및 현재 상태가 초기화면인지 확인하는 로직을 추가해서 연산자를 변경하지 못하게 방어했으며 이를 통해 해당 버그를 해결했습니다.

| Before | After |
|:---:|:---:|
|<img src="https://i.imgur.com/XaQ0iAJ.gif" width="400"/>|<img src="https://i.imgur.com/6MjXzBu.gif" width="400"/>|

### 계산 결과에 소수점 아래 쓸모없는 값이 출력되는 버그
- 계산결과인 Double형태를 직접 숫자를 저장하는 프로퍼티에 String형태로 변환하여 할당해줬습니다. 이로 인해 소수점 아래 쓸모없는 값이 출력되는 버그가 발생했습니다.
- 계산 결과를 NumberFormatter로 변환한 후 변환된 값을 숫자를 저장하는 로직을 통해서 해당 문제를 해결했습니다.

| Before | After |
|:---:|:---:|
|<img src="https://i.imgur.com/vuQ7kFP.gif" width="400"/>|<img src="https://i.imgur.com/rvDSc8i.gif" width="400"/>|


## 참고 링크
https://developer.apple.com/documentation/swift/caseiterable
https://ko.wikipedia.org/wiki/%ED%85%8C%EC%8A%A4%ED%8A%B8_%EC%A3%BC%EB%8F%84_%EA%B0%9C%EB%B0%9C
https://en.wikipedia.org/wiki/Queue
https://ko.wikipedia.org/wiki/%EC%97%B0%EA%B2%B0_%EB%A6%AC%EC%8A%A4%ED%8A%B8
https://en.wikipedia.org/wiki/Doubly_linked_list
https://developer.apple.com/documentation/uikit/uibutton
https://developer.apple.com/documentation/uikit/uilabel
https://developer.apple.com/documentation/uikit/uistackview
https://developer.apple.com/documentation/uikit/uiscrollview
https://developer.apple.com/documentation/foundation/numberformatter
