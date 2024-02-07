// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeatherRequestModel {
  bool get isCurrent => throw _privateConstructorUsedError;
  String get cityName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherRequestModelCopyWith<WeatherRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherRequestModelCopyWith<$Res> {
  factory $WeatherRequestModelCopyWith(
          WeatherRequestModel value, $Res Function(WeatherRequestModel) then) =
      _$WeatherRequestModelCopyWithImpl<$Res, WeatherRequestModel>;
  @useResult
  $Res call({bool isCurrent, String cityName});
}

/// @nodoc
class _$WeatherRequestModelCopyWithImpl<$Res, $Val extends WeatherRequestModel>
    implements $WeatherRequestModelCopyWith<$Res> {
  _$WeatherRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCurrent = null,
    Object? cityName = null,
  }) {
    return _then(_value.copyWith(
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherRequestModelImplCopyWith<$Res>
    implements $WeatherRequestModelCopyWith<$Res> {
  factory _$$WeatherRequestModelImplCopyWith(_$WeatherRequestModelImpl value,
          $Res Function(_$WeatherRequestModelImpl) then) =
      __$$WeatherRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isCurrent, String cityName});
}

/// @nodoc
class __$$WeatherRequestModelImplCopyWithImpl<$Res>
    extends _$WeatherRequestModelCopyWithImpl<$Res, _$WeatherRequestModelImpl>
    implements _$$WeatherRequestModelImplCopyWith<$Res> {
  __$$WeatherRequestModelImplCopyWithImpl(_$WeatherRequestModelImpl _value,
      $Res Function(_$WeatherRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isCurrent = null,
    Object? cityName = null,
  }) {
    return _then(_$WeatherRequestModelImpl(
      isCurrent: null == isCurrent
          ? _value.isCurrent
          : isCurrent // ignore: cast_nullable_to_non_nullable
              as bool,
      cityName: null == cityName
          ? _value.cityName
          : cityName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WeatherRequestModelImpl implements _WeatherRequestModel {
  const _$WeatherRequestModelImpl(
      {required this.isCurrent, required this.cityName});

  @override
  final bool isCurrent;
  @override
  final String cityName;

  @override
  String toString() {
    return 'WeatherRequestModel(isCurrent: $isCurrent, cityName: $cityName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherRequestModelImpl &&
            (identical(other.isCurrent, isCurrent) ||
                other.isCurrent == isCurrent) &&
            (identical(other.cityName, cityName) ||
                other.cityName == cityName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isCurrent, cityName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherRequestModelImplCopyWith<_$WeatherRequestModelImpl> get copyWith =>
      __$$WeatherRequestModelImplCopyWithImpl<_$WeatherRequestModelImpl>(
          this, _$identity);
}

abstract class _WeatherRequestModel implements WeatherRequestModel {
  const factory _WeatherRequestModel(
      {required final bool isCurrent,
      required final String cityName}) = _$WeatherRequestModelImpl;

  @override
  bool get isCurrent;
  @override
  String get cityName;
  @override
  @JsonKey(ignore: true)
  _$$WeatherRequestModelImplCopyWith<_$WeatherRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
