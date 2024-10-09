import 'package:admin_app/components/button/cr_elevated_button.dart';
import 'package:admin_app/constants/app_color.dart';
import 'package:admin_app/services/local/shared_prefs.dart';
import 'package:flutter/material.dart';
import '../../models/onboarding_model.dart';
import '../auth/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final pageController = PageController();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SharedPrefs.isAccessed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 38.0, bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'WELCOME TO 24/7 VEHICLE \n RESCUE SERVICE',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w800,
                  color: AppColor.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                height: 350.0,
                child: PageView(
                  controller: pageController,
                  onPageChanged: (pageViewIndex) {
                    currentIndex = pageViewIndex;
                    setState(() {});
                  },
                  children: List.generate(
                    onboardings.length,
                    (index) => Image.asset(onboardings[index].imagePath ?? '',
                        fit: BoxFit.fitHeight),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  onboardings[currentIndex].text ?? '',
                  style: const TextStyle(
                      color: AppColor.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardings.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.6),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: index == currentIndex ? 30.0 : 10.0,
                      height: 10.0,
                      decoration: BoxDecoration(
                          color:
                              index == currentIndex ? Colors.red : Colors.grey,
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 56.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    currentIndex > 0
                        ? CrElevatedButton.outline(
                            onPressed: () {
                              currentIndex--;
                              pageController.animateToPage(currentIndex,
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeInOut);
                              // setState(() {});
                            },
                            text: 'Back',
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                          )
                        : CrElevatedButton.outline(
                            text: 'Back',
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            textColor: AppColor.orange.withOpacity(0.6),
                            borderColor: AppColor.orange.withOpacity(0.6),
                          ),
                    CrElevatedButton(
                      onPressed: () {
                        if (currentIndex < onboardings.length - 1) {
                          currentIndex++;
                          pageController.animateToPage(currentIndex,
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInOut);
                          // setState(() {});
                        } else {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        }
                      },
                      text: currentIndex == onboardings.length - 1
                          ? 'Start'
                          : 'Next',
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
