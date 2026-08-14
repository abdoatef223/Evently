import 'package:evently_c19/core/remote/network/firestore_manager.dart';
import 'package:evently_c19/core/resources/dialog_utilis.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:evently_c19/model/user.dart' as userModel;
import 'package:flutter/material.dart';

import '../../../core/resources/app_constants.dart';
import '../../../core/resources/assets_manager.dart';
import '../../../core/resources/routes_manager.dart';
import '../../../core/resources/strings_manager.dart';
import '../../../core/reusable_components/custom_btn.dart';
import '../../../core/reusable_components/custom_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPassController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmPassController.dispose();
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
                  StringsManager.createAcc,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                CustomField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.nameEmpty;
                    }
                    return null;
                  },
                  controller: nameController,
                  hint: StringsManager.nameHint,
                  prefixPath: AssetsManager.profile,
                  keyboard: TextInputType.name,
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                CustomField(
                  validation: (value) {
                    if (value != passwordController.text) {
                      return StringsManager.passwordsMatch;
                    }
                    return null;
                  },
                  isObscure: true,
                  controller: confirmPassController,
                  hint: StringsManager.confirmPassHint,
                  prefixPath: AssetsManager.lock,
                  keyboard: TextInputType.visiblePassword,
                ),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: CustomBtn(
                    title: StringsManager.signup,
                    onClick: () {
                      if (formKey.currentState?.validate() ?? false) {
                        createNewAccount();
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
                    title: StringsManager.signUpWithGoogle,
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
                      "${StringsManager.alreadyHaveAcc} ",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, RoutesManager.loginRouteName);
                      },
                      child: Text(
                        StringsManager.login,
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

  createNewAccount() async {
    try {
      DialogUtils.showLoadingDialog(context);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      await FirestoreManager.saveUser(userModel.User(
        id: FirebaseAuth.instance.currentUser!.uid,
        email: emailController.text,
        name: nameController.text,
        favorites: [],
      ));
      if (!mounted) return;
      Navigator.of(context).pop();
      Navigator.pushReplacementNamed(context, RoutesManager.homeRouteName);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      String message;
      if (e.code == 'weak-password') {
        message = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        message = "An account already exists for that email.";
      } else {
        message = "Sign up failed. Please try again.";
      }
      DialogUtils.showMessageDialog(
        context: context,
        content: message,
        actionTitle: "Ok",
        actionPress: () => Navigator.of(context).pop(),
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context).pop();
      DialogUtils.showMessageDialog(
        context: context,
        content: "Something went wrong. Please try again.",
        actionTitle: "Ok",
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
        actionTitle: "Ok",
        actionPress: () => Navigator.of(context).pop(),
      );
    }
  }
}