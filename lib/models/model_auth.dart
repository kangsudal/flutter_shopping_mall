/*
인증관련 기능 처리를 위한 모델
 */
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//인증 상태
enum AuthStatus {
  registerSuccess, //회원가입 성공
  registerFail, //회원가입 실패
  loginSuccess, //로그인 성공
  loginFail, //로그인 실패
}

class FirebaseAuthProvider with ChangeNotifier {
  FirebaseAuth authClient; //연결된 인스턴스 저장
  User? user; //현재 로그인된 유저 객체를 저장할 변수

  FirebaseAuthProvider({auth}) : authClient = auth ?? FirebaseAuth.instance;

  //이메일과 비밀번호를 인자로 받아 이메일 회원가입을 수행
  Future<AuthStatus> registerWithEmail(String email, String password) async {
    try {
      UserCredential credential =
          await authClient.createUserWithEmailAndPassword(
              email: email,
              password: password); //실제로 수행하는 기능. FirebaseAuth 패키지가 제공하는 함수
      return AuthStatus.registerSuccess; //정상적으로 회원가입이 되면
    } catch (e) {
      print(e);
      return AuthStatus.registerFail; //실패할경우
    }
  }

  Future<AuthStatus> loginWithEmail(String email, String password) async {
    print('#####################$email, $password');
    try {
      await authClient
          .signInWithEmailAndPassword(email: email, password: password)
          .then((credential) async {
        //signInWithEmailAndPassword()의 결과값으로 credential이 반환됨. 이 값은 인증 결과를 담고 있는 객체, 현재 로그인한 유저 정보가 들어있음.
        user = credential
            .user; //Provider클래스 내의 user 변수에 저장하여, 로그인한 유저 정보를 앱 전역에서 접근할 수 있음.
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLogin', true);
        prefs.setString('email', email);
        prefs.setString('password', password);
      });
      print('[+]로그인유저:' + user!.email.toString());
      return AuthStatus.loginSuccess;
    } catch (e) {
      print(e);
      return AuthStatus.loginFail;
    }
  }
}
