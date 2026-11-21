import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sincro_local/transfer.dart';

void main() {
  late Directory temp;
  setUp(() async => temp = await Directory.systemTemp.createTemp('sincro-test-'));
  tearDown(() async => temp.delete(recursive: true));

  test('cópia concluída preserva conteúdo e hash', () async {
    final source = File('${temp.path}/origem.txt')..writeAsStringSync('SincroLocal');
    final dest = File('${temp.path}/destino.txt');
    final digest = await copyHashed(source: source, dest: dest, cancel: CancelFlag(), onProgress: (_) {});
    expect(await dest.readAsString(), 'SincroLocal');
    expect(digest.length, 64);
  });

  test('cópia cancelada não deixa arquivo final', () async {
    final source = File('${temp.path}/origem.txt')..writeAsStringSync('conteudo');
    final dest = File('${temp.path}/destino.txt');
    final flag = CancelFlag()..cancelled = true;
    await expectLater(copyHashed(source: source, dest: dest, cancel: flag, onProgress: (_) {}), throwsStateError);
    expect(await dest.exists(), false);
  });

  test('recebimento incompleto não sobrescreve arquivo existente', () async {
    final dest = File('${temp.path}/destino.txt')..writeAsStringSync('original');
    await expectLater(writeHashed(source: Stream.value([1, 2]), dest: dest, total: 3, cancel: CancelFlag(), onProgress: (_) {}), throwsStateError);
    expect(await dest.readAsString(), 'original');
  });

  test('arquivo menor existente não é apagado', () async {
    final existing = File('${temp.path}/foto.jpg')..writeAsBytesSync([1, 2]);
    final target = await incomingTarget(temp, 'foto.jpg', 10);
    expect(target.file.path, isNot(existing.path));
    expect(await existing.readAsBytes(), [1, 2]);
  });
}
