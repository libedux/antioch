import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/auth/data/repository/auth_repository.dart';
import '../../../core/helpers/alert_dialog.dart';
import '../../../app/auth/data/model/credential.dart';
import '../../../app/auth/state/auth_cubit.dart';
import '../../../app/auth/state/auth_state.dart';
import '../../../app/auth/presentation/widgets/custom_button.dart';
import '../../../core/components/custom_textfield.dart';
import '../../../core/constants/constants.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _controller = PageController();
  Credential _credential = Credential(credentialType: CredentialType.email, authType: AuthType.login);
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final authCubit = AuthCubit(AuthRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: BlocProvider(
                        create: (_) => authCubit,
                        child: BlocConsumer<AuthCubit, AuthState>(builder: (providerContext, state) {
                          return Form(
                            key: _formkey,
                            child: PageView(
                                controller: _controller,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [_signIn(context), _signUp(context)]),
                          );
                        }, listener: (context, state) async {
                          if (state is AuthLoading) {
                            AlertDialogHelper.instance(context).showLoader();
                          } else if (state is AuthSuccess) {
                            await Navigator.pushReplacementNamed(context, '/onboard');
                          } else if (state is AuthError) {
                            AlertDialogHelper.instance(context).showError(state.error);
                          }
                        }),
                      ))))),
    );
  }

  Widget _signIn(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
        buildLogo(context),
        ..._emailAndPassword(),
        CustomButton(
            onPressed: () {
              authCubit.auth(_credential);
            },
            text: 'Giriş Yap'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: double.infinity,
              height: itemHeight,
              child: SignInButton(
                Buttons.Facebook,
                shape: const StadiumBorder(),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    _credential.credentialType = CredentialType.facebook;
                    authCubit.auth(_credential);
                  }
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
              text: TextSpan(
                  text: 'Eğer hesabın yoksa ',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                  children: [
                TextSpan(
                  text: 'Kayıt Ol',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _controller.nextPage(duration: const Duration(microseconds: 1000), curve: Curves.elasticOut);
                    },
                )
              ])),
        ),
        const SizedBox(height: 20),
      ]);

  Widget _signUp(BuildContext context) =>
      Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
        buildLogo(context),
        ..._emailAndPassword(),
        CustomTextfield(
          hint: 'Şifre Tekrar',
          onChanged: (String val) {
            _credential.confirmPassword = val;
          },
          validator: (String? val) {
            _credential.confirmPassword = val ?? '';
            if (_credential.password != _credential.confirmPassword) {
              return 'Şifreler uyuşmuyor';
            } else {
              return null;
            }
          },
        ),
        CustomButton(
            onPressed: () {
              if (_formkey.currentState!.validate()) {
                _credential.authType = AuthType.register;
                authCubit.auth(_credential);
              }
            },
            text: 'Kayıt Ol'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: double.infinity,
              height: itemHeight,
              child: SignInButton(
                Buttons.Facebook,
                text: "Facebook ile giriş yap",
                shape: const StadiumBorder(),
                onPressed: () async {
                  final facebookLoginResult = await FacebookAuth.i.login();
                  final userData = await FacebookAuth.i.getUserData();

                  _credential.authType = AuthType.register;
                  _credential.credentialType = CredentialType.facebook;
                },
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichText(
              text: TextSpan(
                  text: 'Eğer hesabın varsa ',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.normal,
                      ),
                  children: [
                TextSpan(
                  text: 'Giriş Yap',
                  style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _controller.previousPage(duration: const Duration(microseconds: 1000), curve: Curves.elasticOut);
                    },
                )
              ])),
        ),
        const SizedBox(height: 20),
      ]);

  List<Widget> _emailAndPassword() => [
        CustomTextfield(
            keyboardType: TextInputType.emailAddress,
            hint: 'Email adresi',
            onChanged: (String val) {
              _credential.email = val;
            }),
        CustomTextfield(
            hint: 'Şifre',
            onChanged: (String val) {
              _credential.password = val;
            }),
      ];

  Widget buildLogo(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: const [
              Text(
                'Fogeto',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                "Fogeto'ya hoşgeldiniz, yapay zeka destekli eşleşme sistemi ile hergün bir kişi ile eşleşin \n",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
