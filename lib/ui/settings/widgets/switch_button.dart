import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mod_bloc/ui/settings/widgets/settings_card_button.dart';

import '../cubit/multi_page_cubit.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({super.key});
  ///as this widget consists of a lot of lines of code,
  ///so this is moved to a a separate widget to make code at 
  ///settings screen look clean
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
                  create: (context) => MultiPageCubit(),
                  child: BlocBuilder<MultiPageCubit, MultiPageState>(
                    builder: (context, state) {
                      if (state is MultiPageFalse) {
                        return SettingsCardButton(
                            icon: const Icon(
                              Icons.menu_sharp,
                              size: 40,
                              color: Colors.orange,
                            ),
                            txt: "Multi Page Menu",
                            button: CupertinoSwitch(
                              onChanged: (v) {
                                context
                                    .read<MultiPageCubit>()
                                    .onChangedPressed(v);
                              },
                              value: false,
                            )
                            );
                      }
                      if (state is MultiPageTrue) {
                        return SettingsCardButton(
                            icon: const Icon(
                              Icons.menu_sharp,
                              size: 40,
                              color: Colors.orange,
                            ),
                            txt: "Multi Page Menu",
                            button: CupertinoSwitch(
                              onChanged: (v) {
                                context
                                    .read<MultiPageCubit>()
                                    .onChangedPressed(v);
                              },
                              value: true,
                            ));
                      }
                      return const SizedBox();
                    },
                  ),
                );
  }
}