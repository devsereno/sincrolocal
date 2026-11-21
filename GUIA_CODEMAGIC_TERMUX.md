# SincroLocal - verificacao preventiva Codemagic

Este pacote parte do ZIP de correcao AGP 9 anterior. O YAML registra versoes efetivas de Flutter, Dart, Java, Gradle, AGP e Kotlin, verifica duplicidade de scripts Gradle, instala dependencias, executa analise estatica e testes, e compila APK release com log detalhado.

**Importante:** `flutter: stable` NAO fixa uma versao de Flutter; ela e registrada em cada build. Fixar a versao exige saber qual release e compatível com os plugins e o projeto. A compatibilidade AGP/Kotlin ainda depende de validacao real no Codemagic. `flutter analyze` e `flutter test` interrompem o fluxo caso encontrem falhas; isso e intencional para nao mascarar erros.

O APK usa assinatura de debug no build release conforme configuracao existente; NAO esta pronto para publicacao na Play Store.

## Enviar pelo Termux (exemplo)

Instale `pkg install unzip git` e tenha o repositorio clonado e autenticado. Extraia o ZIP, copie os arquivos da pasta `sincro-local-main` para a raiz do repositorio, confira `git status`, depois `git add . && git commit -m "Diagnostico preventivo Codemagic" && git push`. Nao coloque a pasta `sincro-local-main` dentro da raiz do repositorio.

Se houver falha, envie o trecho completo da primeira etapa que falhou; os erros de compilacao posteriores nao podem ser garantidos sem executar o build.
