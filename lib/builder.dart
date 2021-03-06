import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/di/providers.dart';

Builder sealedBuilder(BuilderOptions options) => SharedPartBuilder(
      [provideGenerator()],
      'sealed',
    );
