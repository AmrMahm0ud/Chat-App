import 'dart:io';
import 'package:chat_app_version2/widgets/picker/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  AuthForm(this.submitFn , this.isLoading);
  final bool isLoading ;
  final void Function(String email , String password , String username ,File image ,bool isLogin , BuildContext ctx)submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail = '';
  String _userPassword = '' ;
  String _userName= '';
  File _userImageFile;

  void _pickImage(File image) {
    _userImageFile = image;

  }

  void _trySubmit(){
    final isVaild = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(_userImageFile == null && !_isLogin ) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Pleas pick an imgae"),
      backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }


    if (isVaild ){
      _formkey.currentState.save();
      widget.submitFn(_userEmail.trim() , _userPassword.trim() , _userName.trim(),_userImageFile , _isLogin , context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(!_isLogin)UserImagePicker(_pickImage),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if(value.isEmpty  ||  !value.contains('@')){
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _userEmail = value ;
                    },
                    keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(labelText: 'Email address'),
                  ),
                  if(!_isLogin)
                  TextFormField(
                    validator: (value) {
                      if(value.isEmpty  ||  value.length < 4){
                        return 'Please enta at least 4 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value ;
                    },
                    decoration: InputDecoration(labelText: 'Username'),
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if(value.isEmpty  ||  value.length < 7){
                        return 'Password must be 7 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _userPassword = value ;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if(!widget.isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'Login' : 'Signup'),
                    onPressed:_trySubmit,
                  ),
                  if(!widget.isLoading)
                  FlatButton(
                    child: Text(_isLogin ? 'Create new account' : 'I alerady have a account'),
                    textColor:  Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
