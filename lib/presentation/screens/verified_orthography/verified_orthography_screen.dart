import 'package:antiphishing/presentation/constants/app_colors.dart';
import 'package:antiphishing/presentation/constants/app_text.dart';
import 'package:antiphishing/presentation/constants/app_webp.dart';
import 'package:antiphishing/presentation/screens/verified_orthography/verified_orthography_bloc.dart';
import 'package:antiphishing/presentation/screens/verified_orthography/verified_orthography_state.dart';
import 'package:antiphishing/presentation/widgets/app_bar/anti_phishing_app_bar.dart';
import 'package:antiphishing/presentation/widgets/default_button.dart';
import 'package:antiphishing/presentation/widgets/information_card.dart';
import 'package:antiphishing/presentation/widgets/verification_result_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifiedOrthographyScreen extends StatefulWidget {
  const VerifiedOrthographyScreen({super.key});

  @override
  State<VerifiedOrthographyScreen> createState() => _VerifiedOrthographyScreenState();
}

class _VerifiedOrthographyScreenState extends State<VerifiedOrthographyScreen> {
  late final VerifiedOrthographyBloc bloc = BlocProvider.of<VerifiedOrthographyBloc>(context);
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(onTextUpdate);
  }

  void onTextUpdate() {
    bloc.onDataUpdate(_textController.value.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VerifiedOrthographyBloc, VerifiedOrthographyState>(
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
                            AppText.insertText,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.grey1A, fontSize: 20.0),
                          ),
                          const SizedBox(height: 32.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppWebp.copyAndPasteIcon, width: 45, height: 45),
                              const SizedBox(width: 16.0),
                              Expanded(
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxHeight: 80.0,
                                  ),
                                  child: TextField(
                                    expands: true,
                                    maxLines: null,
                                    minLines: null,
                                    controller: _textController,
                                    decoration: InputDecoration(
                                      hintText: AppText.pasteText,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                        horizontal: 16.0,
                                      ),
                                    ),
                                    keyboardType: TextInputType.url,
                                  ),
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
                                    final isASafeOrthography =
                                        await bloc.isASafeOrthography(_textController.value.text);
                                    if (isASafeOrthography && context.mounted) {
                                      await showDialog<Map<String, dynamic>>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const VerificationResultModal(
                                            imageUrl: AppWebp.resultVerificationFalseIcon,
                                            text: AppText.falseForPhishingInText,
                                          );
                                        },
                                      );
                                    }

                                    if (!isASafeOrthography && context.mounted) {
                                      await showDialog<Map<String, dynamic>>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (BuildContext context) {
                                          return const VerificationResultModal(
                                            imageUrl: AppWebp.resultVerificationTrueIcon,
                                            text: AppText.trueForPhishingInText,
                                          );
                                        },
                                      );
                                    }
                                    if (context.mounted) {
                                      FocusScope.of(context).requestFocus(FocusNode());
                                      _textController.clear();
                                    }
                                  }
                                : null,
                            text: AppText.sendText,
                          ),
                          const SizedBox(height: 32.0),
                          const InformationCard(
                            title: AppText.warning,
                            description: AppText.warningText,
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
