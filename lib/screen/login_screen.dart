import 'package:email_password_login/screen/home_screen.dart';
import 'package:email_password_login/screen/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //Firebase
  final _auth = FirebaseAuth.instance;

  //formkey
  final _formKey=GlobalKey<FormState>();

  //Editing controller for email and password
  final TextEditingController emailController=new TextEditingController();
  final TextEditingController passwordController=new TextEditingController();

  @override
  Widget build(BuildContext context) {

    //email field
    final emailField=TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value){
        if(value!.isEmpty){
          return "please enter your email";
        }
        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+").hasMatch(value)){
          return "please enter valid email";
        }
        return null;
      },
      onSaved: (value){
        emailController.text=value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.mail),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Email",
        labelText: "Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );
    
    //passwordField
    final passwordField=TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value){
        RegExp regExp=new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return "Enter your password";
        }
        if(!regExp.hasMatch(value)){
          return "Enter a valid password minimum 6 character";
        }
        
      },
      onSaved: (value){
       passwordController.text=value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          labelText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final loginButton=Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signIn(emailController.text, passwordController.text);
        },
        child: Text("Login"),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:<Widget> [
                    SizedBox(
                      height: 200,
                      child: Image.asset("images/face.png",
                      fit: BoxFit.contain,),

                    ),
                    SizedBox(height: 20.0,),
                    emailField,
                    SizedBox(height: 20.0,),
                    passwordField,
                    SizedBox(height: 20.0,),
                    loginButton,
                    SizedBox(height: 20.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account? "),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder:(context)=>RegistrationScreen()));
                          },
                          child: Text("SignUp",
                          style: TextStyle(color: Colors.red,
                          fontSize: 18.0,fontWeight: FontWeight.bold),),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  //login Function
 void signIn(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid){
            Fluttertoast.showToast(msg: "Login Succesfull");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>HomeScreen()));
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
 }

}

