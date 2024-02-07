// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeatherModel {
  String get city => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  double get temperatureF => throw _privateConstructorUsedError;
  double get temperatureC => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  bool get isFavourite => throw _privateConstructorUsedError;
  String get icon => throw _privateConstructorUsedError;
  String get windDir => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherModelCopyWith<WeatherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherModelCopyWith<$Res> {
  factory $WeatherModelCopyWith(
          WeatherModel value, $Res Function(WeatherModel) then) =
      _$WeatherModelCopyWithImpl<$Res, WeatherModel>;
  @useResult
  $Res call(
      {String city,
      String country,
      double temperatureF,
      double temperatureC,
      String description,
      bool isFavourite,
      String icon,
      String windDir});
}

/// @nodoc
class _$WeatherModelCopyWithImpl<$Res, $Val extends WeatherModel>
    implements $WeatherModelCopyWith<$Res> {
  _$WeatherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = null,
    Object? country = null,
    Object? temperatureF = null,
    Object? temperatureC = null,
    Object? description = null,
    Object? isFavourite = null,
    Object? icon = null,
    Object? windDir = null,
  }) {
    return _then(_value.copyWith(
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      temperatureF: null == temperatureF
          ? _value.temperatureF
          : temperatureF // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureC: null == temperatureC
          ? _value.temperatureC
          : temperatureC // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      windDir: null == windDir
          ? _value.windDir
          : windDir // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherModelImplCopyWith<$Res>
    implements $WeatherModelCopyWith<$Res> {
  factory _$$WeatherModelImplCopyWith(
          _$WeatherModelImpl value, $Res Function(_$WeatherModelImpl) then) =
      __$$WeatherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String city,
      String country,
      double temperatureF,
      double temperatureC,
      String description,
      bool isFavourite,
      String icon,
      String windDir});
}

/// @nodoc
class __$$WeatherModelImplCopyWithImpl<$Res>
    extends _$WeatherModelCopyWithImpl<$Res, _$WeatherModelImpl>
    implements _$$WeatherModelImplCopyWith<$Res> {
  __$$WeatherModelImplCopyWithImpl(
      _$WeatherModelImpl _value, $Res Function(_$WeatherModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? city = null,
    Object? country = null,
    Object? temperatureF = null,
    Object? temperatureC = null,
    Object? description = null,
    Object? isFavourite = null,
    Object? icon = null,
    Object? windDir = null,
  }) {
    return _then(_$WeatherModelImpl(
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      temperatureF: null == temperatureF
          ? _value.temperatureF
          : temperatureF // ignore: cast_nullable_to_non_nullable
              as double,
      temperatureC: null == temperatureC
          ? _value.temperatureC
          : temperatureC // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      icon: null == icon
          ? _value.icon
          : icon // ignore: cast_nullable_to_non_nullable
              as String,
      windDir: null == windDir
          ? _value.windDir
          : windDir // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WeatherModelImpl extends _WeatherModel {
  const _$WeatherModelImpl(
      {required this.city,
      required this.country,
      required this.temperatureF,
      required this.temperatureC,
      required this.description,
      required this.isFavourite,
      required this.icon,
      required this.windDir})
      : super._();

  @override
  final String city;
  @override
  final String country;
  @override
  final double temperatureF;
  @override
  final double temperatureC;
  @override
  final String description;
  @override
  final bool isFavourite;
  @override
  final String icon;
  @override
  final String windDir;

  @override
  String toString() {
    return 'WeatherModel(city: $city, country: $country, temperatureF: $temperatureF, temperatureC: $temperatureC, description: $description, isFavourite: $isFavourite, icon: $icon, windDir: $windDir)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherModelImpl &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.temperatureF, temperatureF) ||
                other.temperatureF == temperatureF) &&
            (identical(other.temperatureC, temperatureC) ||
                other.temperatureC == temperatureC) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.windDir, windDir) || other.windDir == windDir));
  }

  @override
  int get hashCode => Object.hash(runtimeType, city, country, temperatureF,
      temperatureC, description, isFavourite, icon, windDir);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherModelImplCopyWith<_$WeatherModelImpl> get copyWith =>
      __$$WeatherModelImplCopyWithImpl<_$WeatherModelImpl>(this, _$identity);
}

abstract class _WeatherModel extends WeatherModel {
  const factory _WeatherModel(
      {required final String city,
      required final String country,
      required final double temperatureF,
      required final double temperatureC,
      required final String description,
      required final bool isFavourite,
      required final String icon,
      required final String windDir}) = _$WeatherModelImpl;
  const _WeatherModel._() : super._();

  @override
  String get city;
  @override
  String get country;
  @override
  double get temperatureF;
  @override
  double get temperatureC;
  @override
  String get description;
  @override
  bool get isFavourite;
  @override
  String get icon;
  @override
  String get windDir;
  @override
  @JsonKey(ignore: true)
  _$$WeatherModelImplCopyWith<_$WeatherModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
