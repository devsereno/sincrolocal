# SincroLocal — melhorias de segurança e estabilidade

Este pacote parte do ZIP `sincro-local-main.zip` e preserva a estrutura Flutter, as telas e os fluxos existentes.

## Alterações implementadas
- `lib/transfer.dart`: gravação de cópias locais e recebimentos HTTP em arquivo temporário, com publicação do arquivo final somente depois da conclusão; falhas e cancelamentos removem o temporário sem apagar um arquivo final existente.
- `lib/transfer.dart`: ao encontrar um arquivo menor com o mesmo nome, preserva o arquivo existente e escolhe um novo nome em vez de apagá-lo.
- `lib/sync.dart`: quando a porta TCP fixa está ocupada, não cria uma porta aleatória inalcançável; o envio pode utilizar o fallback HTTP já existente.
- `lib/tcp_pipe.dart`: limita cabeçalhos TCP a 16 KB para evitar consumo sem limite por linhas malformadas.
- `test/transfer_test.dart`: testes de cópia, cancelamento, integridade e proteção de arquivo existente.

## Limitações que exigem desenvolvimento/testes adicionais
- O fluxo TCP direto ainda grava diretamente no destino, sem arquivo temporário nem SHA-256 ponta a ponta.
- A opção de ignorar arquivo existente usa tamanho igual, não hash; pode considerar como concluído um arquivo diferente de mesmo tamanho.
- Retomada por byte após interrupção não está implementada; a sessão salva quais arquivos terminaram.
- Licenças Premium, integração ARVOG, consentimento de diagnósticos, coleta/agrupamento local de erros e organizador inteligente completo **não foram implementados neste pacote**.
- Não foi possível executar Flutter analyze, Flutter test ou compilar APK neste ambiente: Flutter/Dart SDK não está instalado.

## Validação no Codemagic
1. Suba o ZIP como conteúdo do repositório Flutter (sem criar uma pasta extra na raiz do repositório).
2. Rode `flutter pub get`, `flutter analyze`, `flutter test` e `flutter build apk --release`.
3. Teste Wi-Fi e Hotspot em dois aparelhos reais, cancelamento, falta de espaço, arquivos com mesmo nome, queda de conexão e transferência acima de 4 GB.
4. Não distribua uma versão de produção sem validar a integridade dos dados recebidos.
