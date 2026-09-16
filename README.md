# Coil

Лента + мессенджер в одном native iOS 26 приложении. SwiftUI, Liquid Glass, без Xcode — сборка через GitHub Actions.

## Стек

- SwiftUI, iOS 26
- XcodeGen — генерация проекта из `project.yml`
- GitHub Actions (`macos-26`) — сборка и неподписанный `.ipa` в релизе `latest`

## Структура

```
Coil/
  App/            точка входа
  Navigation/     таб-бар, корневая навигация
  DesignSystem/   цвета, типографика, Liquid Glass, компоненты
  Data/           модели, текущий пользователь
  Features/       экраны по разделам
  Resources/      Info.plist, ассеты
```

## Сборка

Каждый пуш в `main` собирает неподписанный `.ipa` и публикует его в релиз `latest` — устанавливается через Sideloadly бесплатным Apple ID.
