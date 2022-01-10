part of 'pages.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(24),
        child: Stack(
          children: [
            ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 24),
                      Image.asset("assets/images/tripsterlogo.png",
                          height: 150),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill this field";
                          } else {
                            if (!EmailValidator.validate(value)) {
                              return "Email isn't valid";
                            } else {
                              return null;
                            }
                          }
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: ctrlPassword,
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                            suffixIcon: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              child: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            )),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value.length < 6
                              ? "Password must have at least 6 characters"
                              : null;
                        },
                      ),
                      SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            //melanjutkan tahap berikutnya
                            setState(() {
                              isLoading = true;
                            });
                            await AuthServices.signIn(
                                    ctrlEmail.text, ctrlPassword.text)
                                .then((value) {
                              if (value == "success") {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(
                                    "Login success", Colors.greenAccent);
                                Navigator.pushReplacementNamed(
                                    context, MainMenu.routeName);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(
                                    value, Colors.redAccent);
                              }
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please check the fields",
                                backgroundColor: Colors.red);
                          }
                        },
                        icon: Icon(Icons.login_rounded),
                        label: Text("Login"),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFF8D2CEE),
                            onPrimary: Colors.white,
                            elevation: 8),
                      ),
                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Register.routeName);
                        },
                        child: Text(
                          '"Dont have an account? Sign Up Now"',
                          style:
                              TextStyle(color: Color(0xFF8D2CEE), fontSize: 16),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
