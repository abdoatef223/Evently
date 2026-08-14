import 'package:evently_c19/core/resources/app_constants.dart';
import 'package:evently_c19/core/resources/dialog_utilis.dart';
import 'package:evently_c19/core/resources/routes_manager.dart';
import 'package:evently_c19/core/resources/strings_manager.dart';
import 'package:evently_c19/core/remote/network/firestore_manager.dart';
import 'package:evently_c19/core/reusable_components/custom_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_manager.dart';
import '../../../core/reusable_components/custom_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          height: 27,
          fit: BoxFit.fitHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManager.loginToYourAccount,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                CustomField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.emailEmpty;
                    }
                    if (!RegExp(AppConstants.emailRegex).hasMatch(value)) {
                      return StringsManager.emailInvalid;
                    }
                    return null;
                  },
                  controller: emailController,
                  hint: StringsManager.emailHint,
                  prefixPath: AssetsManager.email,
                  keyboard: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.passwordEmpty;
                    }
                    if (value.length < 8) {
                      return StringsManager.passwordWeak;
                    }
                    return null;
                  },
                  isObscure: true,
                  controller: passwordController,
                  hint: StringsManager.passwordHint,
                  prefixPath: AssetsManager.lock,
                  keyboard: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesManager.forgetpassRouteName);
                    },
                    child: Text(
                      StringsManager.forgetPassAsk,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: CustomBtn(
                    title: StringsManager.login,
                    onClick: () {
                      if (formKey.currentState?.validate() ?? false) {
                        login();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(StringsManager.or,
                          style: Theme.of(context).textTheme.labelSmall),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CustomBtn(
                    title: StringsManager.loginWithGoogle,
                    outlined: true,
                    icon: Image.asset(AssetsManager.googleLogo,
                        height: 20, width: 20),
                    onClick: signInWithGoogle,
                  ),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${StringsManager.dontHaveAcc} ",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.signupRouteName);
                      },
                      child: Text(
                        StringsManager.signup,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    try {
      DialogUtils.showLoadingDialog(context);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, RoutesManager.homeRouteName);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      String message;
      if (e.code == 'invalid-credential' ||
          e.code == 'user-not-found' ||
          e.code == 'wrong-password') {
        message = "Invalid email or password. Please try again.";
      } else if (e.code == 'user-disabled') {
        message = "This account has been disabled.";
      } else if (e.code == 'too-many-requests') {
        message = "Too many attempts. Please try again later.";
      } else {
        message = "Login failed. Please try again.";
      }
      DialogUtils.showMessageDialog(
        context: context,
        content: message,
        actionTitle: "OK",
        actionPress: () => Navigator.of(context).pop(),
      );
    }
  }

  signInWithGoogle() async {
    try {
      DialogUtils.showLoadingDialog(context);
      await FirestoreManager.signInWithGoogle();
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, RoutesManager.homeRouteName);
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      DialogUtils.showMessageDialog(
        context: context,
        content: "Google sign-in failed. Please try again.",
        actionTitle: "OK",
        actionPress: () => Navigator.of(context).pop(),
      );
    }
  }
}