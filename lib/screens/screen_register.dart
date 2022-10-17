import 'package:flutter/material.dart';
import 'package:flutter_shopping_mall/models/model_auth.dart';
import 'package:flutter_shopping_mall/models/model_register.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RegisterFieldModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("회원가입 화면"),
        ),
        body: Column(
          children: [
            EmailInput(),
            PasswordInput(),
            PasswordConfirmInput(),
            RegisterButton(),
          ],
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: false); //불필요한 빌드 발생 방지
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (email) {
          registerField.setEmail(email);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: '이메일',
          helperText: '',
        ),
      ),
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: false);
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (password) {
          registerField.setPassword(password);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: '비밀번호',
          helperText: '',
        ),
      ),
    );
  }
}

class PasswordConfirmInput extends StatelessWidget {
  const PasswordConfirmInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerField = Provider.of<RegisterFieldModel>(
        context); //listen = true : password 값과 실시간으로 비교하여 같지 않을 때 에러 메시지를 발생하도록
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: TextField(
        onChanged: (passwordConfirm) {
          registerField.setPasswordConfirm(passwordConfirm);
        },
        obscureText: true,
        decoration: InputDecoration(
          labelText: '비밀번호 확인',
          helperText: '',
          errorText: registerField.password != registerField.passwordConfirm
              ? '비밀번호가 일치하지 않습니다.'
              : null,
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authClient =
        Provider.of<FirebaseAuthProvider>(context, listen: false); //회원가입 요청을 보내는 단계이기 때문에 추가
    final registerField =
        Provider.of<RegisterFieldModel>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        onPressed: () async {
          await authClient
              .registerWithEmail(registerField.email, registerField.password)
              .then((registerStatus) {//authCllient에 대한 요청의 결과가
            if (registerStatus == AuthStatus.registerSuccess) {//AuthStatus.registerSuccess면
              //스낵바를 통해 회원가입 성공을 알린다.
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar() //cascade 표기법: 함수가 반환한 객체에 바로 접근
                ..showSnackBar(
                  SnackBar(content: Text('회원가입이 완료되었습니다!')),
                );
              //그리고 LoginScreen으로 돌아간다.
              Navigator.pop(context);
            }else{
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text('회원가입을 실패했습니다. 다시 시도해주세요.')),
                );
              // 실패했다면 화면을 이동하지 않는다. Navigator.pop(context);
            }
          });
        },
        child: Text('회원가입'),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )),
      ),
    );
  }
}
