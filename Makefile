# 初期化
.PHONY: setup
setup:
	fvm install
	fvm flutter clean
	fvm flutter pub get

# 自動生成
.PHONY: build_runner
build_runner:
	fvm flutter pub run build_runner build --delete-conflicting-outputs

# フォーマット
.PHONY: format
format:
	fvm dart format lib
	fvm dart fix --apply lib

# テスト
.PHONY: test
test:
	fvm flutter test

# Androidビルド(app bundle)
.PHONY: build_android
build_android:
	make setup
	make test
	fvm flutter build appbundle

# Android 実機インストール
.PHONY: install_android
install_android:
	make build_android
	fvm flutter install

# iosビルド
.PHONY: build_ios
build_ios:
	make setup
	make test
	fvm flutter build ios

# ios 実機インストール
.PHONY: install_ios
install_ios:
	make build_ios
	fvm flutter install

# widgetbookビルド
.PHONY: widgetbook
widgetbook:
	cd widgetbook && flutter pub run build_runner build --delete-conflicting-outputs
	
# widgetbook起動(Chrome)
.PHONY: widgetbook_run
widgetbook_run:
	make widgetbook
	cd widgetbook && flutter run -d Chrome
	