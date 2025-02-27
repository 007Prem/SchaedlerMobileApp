import 'package:equatable/equatable.dart';

import 'package:commerce_flutter_app/features/domain/enums/device_authentication_option.dart';

class BiometricInfoEntity extends Equatable {
  final DeviceAuthenticationOption biometricOption;
  final String password;

  const BiometricInfoEntity({
    required this.biometricOption,
    required this.password,
  });

  @override
  List<Object?> get props => [biometricOption, password];

  BiometricInfoEntity copyWith({
    DeviceAuthenticationOption? biometricOption,
    String? password,
  }) {
    return BiometricInfoEntity(
      biometricOption: biometricOption ?? this.biometricOption,
      password: password ?? this.password,
    );
  }
}
