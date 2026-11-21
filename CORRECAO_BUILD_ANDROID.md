# Correção de build Android (Codemagic)

O log recebido informa que Flutter exige Android Gradle Plugin (AGP) >= 9.1.1 e recomenda Gradle >= 9.5.0.

Alterações:
- `android/settings.gradle`: AGP 8.11.1 -> 9.1.1.
- `android/gradle/wrapper/gradle-wrapper.properties`: Gradle 9.3.1 -> 9.5.0.
- Removidos os arquivos `.gradle.kts` duplicados para manter os arquivos Groovy `.gradle` como fonte única.

Atenção: AGP 9 pode revelar novas incompatibilidades com o plugin Kotlin e dependências Flutter. Não foi possível executar Flutter/Gradle aqui. Se aparecer outro erro, envie o trecho inicial a partir de `* What went wrong:` e as linhas anteriores. Não usar `--android-skip-build-dependency-validation` como solução definitiva.

Para testar: suba o conteúdo da pasta `sincro-local-main` para a raiz do repositório e execute o workflow `android-apk` no Codemagic.
