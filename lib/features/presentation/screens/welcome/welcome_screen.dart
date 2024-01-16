import 'package:commerce_flutter_app/core/constants/app_route.dart';
import 'package:commerce_flutter_app/core/constants/localization_constants.dart';
import 'package:commerce_flutter_app/core/injection/injection_container.dart';
import 'package:commerce_flutter_app/features/domain/enums/domain_redirect_status.dart';
import 'package:commerce_flutter_app/features/presentation/bloc/domain_redirect/domain_redirect_cubit.dart';
import 'package:commerce_flutter_app/features/presentation/components/buttons.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_components.dart';
import 'package:commerce_flutter_app/features/presentation/screens/welcome/welcome_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WelcomeBaseScreen(
      child: BlocProvider(
        create: (context) => DomainRedirectCubit(sl()),
        child: const WelcomeFirstPage(),
      ),
    );
  }
}

class WelcomeFirstPage extends StatelessWidget {
  const WelcomeFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DomainRedirectCubit, DomainRedirectStatus>(
      listener: (context, state) {
        if (state == DomainRedirectStatus.redirect) {
          context.go(AppRoute.shop.path);
        }
      },
      child: WelcomeCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              LocalizationKeyword.firstTimeWelcome,
              style: WelcomeStyle.welcomeCardHeaderStyle,
            ),
            WelcomeStyle.welcomeCardTextSpacer,
            const Text(
              'This app enables Optimizely customers to easily access their B2B Commerce application.',
              style: WelcomeStyle.welcomeCardTextStyle,
            ),
            WelcomeStyle.welcomeCardTextSpacer,
            const Text(
              'If you\'re new to Optimizely and would like access to the mobile app version of your storefront, visit our website.',
              style: WelcomeStyle.welcomeCardTextStyle,
            ),
            WelcomeStyle.welcomeCardTextSpacer,
            const Text(
              'Sign in below if you are an existing customer.',
              style: WelcomeStyle.welcomeCardTextStyle,
            ),
            const Expanded(child: SizedBox()),
            PrimaryButton(
              onPressed: () {
                context.push(AppRoute.domainSelection.path);
              },
              child: const Text(
                LocalizationKeyword.signInPrompt,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            TertiaryButton(
              onPressed: () {},
              backgroundColor: Colors.transparent,
              child: const Text(
                LocalizationKeyword.visitWebsite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
