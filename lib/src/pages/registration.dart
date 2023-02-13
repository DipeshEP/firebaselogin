import 'package:firebaselogincubit/src/cubit/auth/auth_cubit.dart';
import 'package:firebaselogincubit/src/pages/home_page.dart';
import 'package:firebaselogincubit/src/pages/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
TextEditingController _emailController=TextEditingController();
TextEditingController _passwordController=TextEditingController();

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit,AuthState>(
      listener: (BuildContext context, state) {
        if(state is AuthLoaded){
          // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SucessFully created")));
        }else if(state is AuthError){
        return;        }
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
                          BlocProvider.of<AuthCubit>(context).registerWithEmailPassword(_emailController.text, _passwordController.text);
                        }, child: const Text("Register"))
                      ],
                    );
                  } else if (state is AuthLoading) {
                    return CircularProgressIndicator();
                  } else {
                    return Container(
                      height: 100,
                      width: 100,
                      color: Colors.green,
                    );
                  }
                },
              ),
            ),
          )
      ),
    );
  }
}
