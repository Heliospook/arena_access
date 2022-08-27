import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login/Signup"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/grass_texture1.webp'),
            fit: BoxFit.cover,
          )),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              isLogin ? LoginPage() : SignupPage(),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: TextStyle(fontSize: 15)),
                  child: Text(isLogin ? 'Sign up Instead' : 'Login Instead'))
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: emailCont,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: passCont,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await Provider.of<Auth>(context, listen: false)
                      .login(emailCont.text, passCont.text);
                      Navigator.of(context).pop();
                } catch (error) {
                  var errormessage = 'Authentication Failed!';
                  throw (error);
                }
                
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailCont = TextEditingController();
  final passCont = TextEditingController();
  final confPassCont = TextEditingController();
  // final nameCont = TextEditingController();

  bool isAlert = false;
  String alertText = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Card(
              color: Theme.of(context).primaryColor,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text('Please register with your IIITB email id.'),
              ),
            ),
            // TextField(
            //   controller: nameCont,
            //   decoration: const InputDecoration(labelText: 'Name'),
            // ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailCont,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: passCont,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: confPassCont,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            if (isAlert)
              Text(
                alertText,
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                // String name = nameCont.text;
                String email = emailCont.text;
                String pass1 = passCont.text;
                String pass2 = confPassCont.text;
                // if (name.isEmpty) {
                //   setState(() {
                //     isAlert = true;
                //     alertText = 'Name should not be empty.';
                //   });
                //   return;
                // }
                // if (name.length > 30) {
                //   setState(() {
                //     isAlert = true;
                //     alertText = 'Name is too long';
                //   });
                //   return;
                // }
                if (email.isEmpty || !email.contains('@iiitb.ac.in')) {
                  setState(() {
                    isAlert = true;
                    alertText = 'Please enter correct institute email';
                  });
                  return;
                }
                if (pass1 != pass2) {
                  setState(() {
                    isAlert = true;
                    alertText = 'Entered passwords do not match';
                  });
                  return;
                }
                setState(() {
                  isAlert = false;
                  alertText = '';
                });
                try {
                  await Provider.of<Auth>(context, listen: false).signup(
                    email,
                    pass1,
                  );
                  Navigator.of(context).pop();
                } catch (error) {
                  var errorMessage = 'Authentication Failed!';
                  throw (error);
                }
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
