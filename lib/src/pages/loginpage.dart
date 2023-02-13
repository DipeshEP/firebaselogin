import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaselogincubit/src/cubit/auth/auth_cubit.dart';
import 'package:firebaselogincubit/src/pages/home_page.dart';
import 'package:firebaselogincubit/src/pages/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        
        if(state is AuthLoaded){
          final UserCredential result=state.userCredential;
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(userCredential: result,)));
        }else if (state is AuthError){
          // Fluttertoast.showToast(msg: state.errorMessage);
          return ;
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {

                if (state is AuthInitial) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: "Email"
                        ),
                      ),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password"
                        ),
                      ),
                      ElevatedButton(onPressed: () {
                        BlocProvider.of<AuthCubit>(context).loginWithEmailPassword(_emailController.text.trim(),_passwordController.text.trim());
                      }, child: const Text("Login")),

                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationPage()));
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage(email: res,)));
                      }, child: Text('Register now'))
                    ],
                  );
                } else if (state is AuthLoading) {
                  return CircularProgressIndicator();
                } else {
                  return Container(
                    color: Colors.red,
                    height: 100,
                    width: 100,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
