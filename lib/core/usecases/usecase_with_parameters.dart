abstract class UseCaseWithParameters<Type, Parameters> {
  Type call(Parameters parameters);
}