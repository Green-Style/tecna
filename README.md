# Green Style

Uma aplicação criada com o objetivo de
conscientizar o usuário sobre o
meio-ambiente, que recebe informações
do usuário para realizar o cálculo de
sua emissão de gás carbônico e sugerir
práticas de acordo.

## Como rodar
Para rodar a aplicação, pode ser usado o
Android Studio, VS Code ou outra IDE,
desde que se tenha o `flutter` instalado.

Após instalar as dependências do flutter
e garantir que não se tenham erros com o
comando `flutter doctor`, deve-se, na
pasta do projeto, rodar `flutter pug get`
para realizar o download das bibliotecas.

Com `flutter run` se roda a aplicação.

## Como gerar arquivos APK
Ao rodar o comando

```bash
$ flutter build apk --split-per-abi
```

serão gerados os apks para armeabi-v7a, arm64-v8a
e x86_64.