import 'dart:io';

void main() {
  Process.run('dart', ['run', 'build_runner', 'build']).then((result) {
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  });
}
