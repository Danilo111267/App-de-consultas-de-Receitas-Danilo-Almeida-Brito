# Consulta de Receitas

Aplicativo Flutter de pesquisa de receitas pela API pública TheMealDB.

Integrante: Danilo Almeida Brito.

## Executar

Abra a pasta do projeto no VS Code e execute:

```bash
flutter create . --platforms=android,web
flutter pub get
flutter run -d chrome
```

Também é possível executar em um emulador Android configurado no Flutter.

A pesquisa utiliza a API `https://www.themealdb.com/api/json/v1/1/search.php?s=` e não armazena dados localmente.
