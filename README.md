# 쓰레기통 지도 앱
---

### Table of Content

> ** 1️⃣ OverView**
>
> - 프로젝트 기간
>
> ** 2️⃣ 프로젝트 구현**
>
> - 프로젝트 설계
> - 사용 기술/구성
> - 프로젝트 파일 구조
> - 구현 기능
> - 구현 상세


## 1️⃣ OverView

### 📍 프로젝트 기간

> 2023.04.02 ~ 2024.05.26 (56days)

## 2️⃣ 프로젝트 구현

### 📍 프로젝트 설계

- 디자인 패턴: `MVVM`

### 📍 사용 기술/구성

- SwiftUI 기반 어플리케이션 작성
- UIKit framework
- Code Base UI
- Combine

### 📍 프로젝트 파일 구조

```

├── GPX File example.xml
├── PlaceCollections-Info.plist
├── PlaceCollections.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   ├── IDEWorkspaceChecks.plist
│   │   │   └── swiftpm
│   │   │       ├── Package.resolved
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── dongjun.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   ├── xcshareddata
│   │   └── xcschemes
│   │       └── PlaceCollections.xcscheme
│   └── xcuserdata
│       └── dongjun.xcuserdatad
│           ├── xcdebugger
│           │   └── Breakpoints_v2.xcbkptlist
│           └── xcschemes
│               └── xcschememanagement.plist
└── PlaceColletions
    ├── App
    │   └── PlaceCollectionsApp.swift
    ├── Assets.xcassets
    │   ├── AccentColor.colorset
    │   │   └── Contents.json
    │   ├── AppIcon.appiconset
    │   │   └── Contents.json
    │   ├── BackgroundColor.colorset
    │   │   └── Contents.json
    │   ├── Contents.json
    │   ├── PlaceCollections.imageset
    │   │   ├── Contents.json
    │   │   └── PlaceCollections.png
    │   ├── PrimaryTextColor.colorset
    │   │   └── Contents.json
    │   ├── Profile.colorset
    │   │   └── Contents.json
    │   ├── SecondaryBackgroundColor.colorset
    │   │   └── Contents.json
    │   ├── facebook-sign-in-icon.imageset
    │   │   ├── Contents.json
    │   │   └── facebook-sign-in-icon.png
    │   ├── google-sign-in-icon.imageset
    │   │   ├── Contents.json
    │   │   └── google-sign-in-icon.png
    │   └── plus_photo.imageset
    │       ├── Contents.json
    │       └── plus_photo.png
    ├── ContentView.swift
    ├── Core
    │   ├── Authentication
    │   │   ├── ViewModels
    │   │   │   └── AuthViewModel.swift
    │   │   └── Views
    │   │       ├── LoginView.swift
    │   │       ├── ProfilePhotoSelectorView.swift
    │   │       └── RegistrationView.swift
    │   ├── Data
    │   │   └── SeoulTrashCan.csv
    │   ├── Home
    │   │   └── Views
    │   │       ├── HomeView.swift
    │   │       ├── MapViewActionButton.swift
    │   │       └── UberMapViewRepresentable.swift
    │   ├── LocationSearch
    │   │   ├── ViewModel
    │   │   │   └── LocationSearchViewModel.swift
    │   │   └── Views
    │   │       ├── LocationAndTrash.swift
    │   │       ├── LocationSearchActivationView.swift
    │   │       ├── LocationSearchResultCell.swift
    │   │       └── LocationSearchView.swift
    │   ├── SideMenu
    │   │   ├── ViewModel
    │   │   │   └── SideMenuOptionViewModel.swift
    │   │   └── Views
    │   │       ├── SideMenuOptionView.swift
    │   │       └── SideMenuView.swift
    │   ├── TrashType
    │   │   └── ViewModel
    │   │       └── TrashModel.swift
    │   └── Trips
    │       ├── RideRequestView.swift
    │       └── TrashView.swift
    ├── Extensions
    │   ├── Color.swift
    │   ├── Double.swift
    │   └── MKCoordinateRegion+Extensions.swift
    ├── GoogleService-Info.plist
    ├── Managers
    │   └── LocationManager.swift
    ├── Models
    │   ├── Landmark.swift
    │   ├── Location.swift
    │   ├── MapViewState.swift
    │   ├── SeoulTrashCan.swift
    │   ├── TrashType.swift
    │   └── User.swift
    ├── Preview Content
    │   └── Preview Assets.xcassets
    │       └── Contents.json
    ├── ReusableItems
    │   ├── CustomInputField.swift
    │   └── RoundedShape.swift
    ├── Services
    │   ├── ImageUploader.swift
    │   └── UserService.swift
    ├── Setting
    │   └── Views
    │       └── SettingView.swift
    ├── TrashDetailView.swift
    └── Utils
        └── ImagePicker.swift

```


### 📍 구현 기능

#### 로그인 화면

| 로그인 | 회원가입 | 사이드바 |
|:-------:|:-------:|:-------:|
| <img src="https://github.com/ehdwns0814/ios_trash_map/assets/97822621/fa037d87-e84d-4b63-838e-941d6bd4a70a" width="300px"> | <img src="https://github.com/ehdwns0814/ios_trash_map/assets/97822621/c046d5bf-606e-47d4-b914-8548f870a39e" width="300px"> | <img src="https://github.com/ehdwns0814/ios_trash_map/assets/97822621/f715d2ae-f10f-4d96-881c-4063078c52ed" width="300px">

#### 지도 화면


| 길찾기 | 쓰레기통 검색 |
|:----------------------------------:|:----------------------------------:| 
| <img width="280" height="auto" alt="Screenshot1" src="https://github.com/ehdwns0814/ios_trash_map/assets/97822621/71611f87-c7c7-4580-887f-f3d1533d9a0a"> | <img width="280" height="auto" alt="Screenshot1" src="https://github.com/ehdwns0814/ios_trash_map/assets/97822621/d35f3623-7e70-4f56-9971-38b06bd598fb"> | 


### 📍 구현 상세

- Firebase 아이디 저장 불러오기
- Kingfisher 프로필 이미지 설명
- MKLocalSearchCompleter 검색 자동완성 구현
- MKMapViewDelegate 목적지까지의 이동경로 구현
