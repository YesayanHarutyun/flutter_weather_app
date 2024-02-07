// Mocks generated by Mockito 5.4.3 from annotations
// in flutter_weather_app/test/mock/domain/usecase/base_usecase_mock.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i2;

import 'package:flutter_weather_app/domain/base/base_usecase.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeFuture_0<T> extends _i1.SmartFake implements _i2.Future<T> {
  _FakeFuture_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BaseUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockBaseUseCase<Input, Output> extends _i1.Mock
    implements _i3.BaseUseCase<Input, Output> {
  MockBaseUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Future<Output> execute({required Input? input}) => (super.noSuchMethod(
        Invocation.method(
          #execute,
          [],
          {#input: input},
        ),
        returnValue: _i4.ifNotNull(
              _i4.dummyValueOrNull<Output>(
                this,
                Invocation.method(
                  #execute,
                  [],
                  {#input: input},
                ),
              ),
              (Output v) => _i2.Future<Output>.value(v),
            ) ??
            _FakeFuture_0<Output>(
              this,
              Invocation.method(
                #execute,
                [],
                {#input: input},
              ),
            ),
      ) as _i2.Future<Output>);
}