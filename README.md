# flutter_shopping_mall

## 기능
1. 회원가입/로그인

2. 상품목록 조회/상세조회

3. 장바구니에 상품 담기/삭제


## 화면 구성
screens

-screen_index.dart: tabs를 포함하는 메인 화면

-screen_login.dart: 로그인 화면

-screen_register.dart: 회원가입 화면

-screen_splash.dart: 로고를 보여주며 로그인/상품 가져오기를 수행할 스플래시 화면

-screen_search.dart: 상품 검색 화면

-screen_detail.dart: 상품 상세보기 화면


tabs

-tab_home.dart: 상품 목록을 보여주는 메인 탭

_tab_screen.dart: 검색 탭(screen_search의 상품 검색 화면으로 대체)

-tab_cart.dart: 장바구니 탭

-tab_profile.dart: 로그아웃 기능을 포함하는 마이페이지 화면(마이페이지 내용은 구현하지 않음)


##사용할 기술

1. provider: 상태관리/디자인 패턴

2. firebase: 백엔드(회원/상품/장바구니)

3. shared_preferences: 자동 로그인
