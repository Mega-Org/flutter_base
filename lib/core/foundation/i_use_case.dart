part of core;

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class IUseCase<Output, Params> {
  DomainServiceType<Output> call(final Params params);
}

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  const NoParams();

  Map<String, dynamic> get toMap => {};

  @override
  List<Object?> get props => <Object?>[];
}
