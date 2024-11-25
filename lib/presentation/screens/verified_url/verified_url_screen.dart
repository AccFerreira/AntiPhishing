import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:antiphishing/presentation/constants/app_text.dart';
import 'package:antiphishing/presentation/constants/app_webp.dart';
import 'package:antiphishing/presentation/screens/verified_url/verified_url_bloc.dart';
import 'package:antiphishing/presentation/screens/verified_url/verified_url_state.dart';
import 'package:antiphishing/presentation/widgets/app_bar/anti_phishing_app_bar.dart';
import 'package:antiphishing/presentation/widgets/default_button.dart';
import 'package:antiphishing/presentation/widgets/information_card.dart';
import 'package:antiphishing/presentation/widgets/verification_result_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifiedUrlScreen extends StatefulWidget {
  const VerifiedUrlScreen({super.key});

  @override
  State<VerifiedUrlScreen> createState() => _VerifiedUrlScreenState();
}

class _VerifiedUrlScreenState extends State<VerifiedUrlScreen> {
  late final VerifiedUrlBloc bloc = BlocProvider.of<VerifiedUrlBloc>(context);
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _urlController.addListener(onTextUpdate);
  }

  void onTextUpdate() {
    bloc.onDataUpdate(_urlController.value.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifiedUrlBloc, VerifiedUrlState>(
        bloc: bloc,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: const AntiPhishingAppBar(),
            body: state.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            AppText.insertUrl,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.grey1A, fontSize: 20.0),
                          ),
                          const SizedBox(height: 32.0),
                          Row(
                            children: [
                              Image.asset(AppWebp.searchIcon, width: 45, height: 45),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: TextField(
                                  controller: _urlController,
                                  decoration: InputDecoration(
                                    hintText: AppText.pasteUrl,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0,
                                      horizontal: 16.0,
                                    ),
                                  ),
                                  keyboardType: TextInputType.url,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32.0),
                          DefaultButton(
                            onTap: state.isButtonEnabled
                                ? () async {
                                    FocusScope.of(context).unfocus();
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    String modifiedUrl = _urlController.value.text.trim();
                                    if (!modifiedUrl.startsWith("http://") && !modifiedUrl.startsWith("https://")) {
                                      modifiedUrl = "https://$modifiedUrl";
                                    }

                                    final doesUrlExists = await bloc.doesUrlExists(modifiedUrl);

                                    if ((doesUrlExists == null || !doesUrlExists) && context.mounted) {
                                      await showDialog<Map<String, dynamic>>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const VerificationResultModal(
                                            imageUrl: AppWebp.urlNotFoundIllustration,
                                            text: AppText.notFoundUrl,
                                          );
                                        },
                                      );
                                      return;
                                    }

                                    final isASafeUrl = await bloc.isASafeUrl(modifiedUrl);

                                    if (isASafeUrl == null && context.mounted) {
                                      await showDialog<Map<String, dynamic>>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const VerificationResultModal(
                                            imageUrl: AppWebp.systemErrorIllustration,
                                            text: AppText.errorFind,
                                          );
                                        },
                                      );
                                      return;
                                    }

                                    if (isASafeUrl! && context.mounted) {
                                      await showDialog<Map<String, dynamic>>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const VerificationResultModal(
                                            imageUrl: AppWebp.resultVerificationFalseIcon,
                                            text: AppText.falseForPhishingInUrl,
                                          );
                                        },
                                      );
                                    }

                                    if (!isASafeUrl && context.mounted) {
                                      await showDialog<Map<String, dynamic>>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const VerificationResultModal(
                                            imageUrl: AppWebp.resultVerificationTrueIcon,
                                            text: AppText.trueForPhishingInUrl,
                                          );
                                        },
                                      );
                                    }
                                    if (context.mounted) {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      _urlController.clear();
                                    }
                                  }
                                : null,
                            text: AppText.sendUrl,
                          ),
                          const SizedBox(height: 32.0),
                          const InformationCard(
                            title: AppText.warning,
                            description: AppText.warningUrl,
                            imageUrl: AppWebp.alertIcon,
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }
}
