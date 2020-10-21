class GenerateConstDeclarationUseCase {
  String call(bool isConst) {
    return isConst ? 'const' : '';
  }
}
