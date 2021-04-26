#!/bin/bash

SWIFTLINT_VERSION=0.33.0

echo "🕛 Проверяем наличие установленного Homebrew..."

if which brew >/dev/null; then
  brew update
else
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "🕐 Проверяем наличие установленного SwiftLint версии ${SWIFTLINT_VERSION}..."

if which swiftlint >/dev/null; then
	CURRENT_SWIFTLINT_VERSION=$(swiftlint version)
	if [ $CURRENT_SWIFTLINT_VERSION != $SWIFTLINT_VERSION ]; then
		brew upgrade swiftlint
		echo "✅ Обновление до версии $(SWIFTLINT_VERSION)"
	else
		brew switch swiftlint $SWIFTLINT_VERSION
		echo "✅ Установлена актуальная версия SwiftLint"	
	fi
else
	echo "Установка SwiftLint"
	brew install swiftlint
fi
