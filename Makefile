xcode:
	open ios/Runner.xcworkspace

fastlane_upload_ios:
	cd ios && fastlane beta

test_coverage:
	flutter test --no-pub --coverage

pub_get:
	flutter pub get

build_coverage:
	make test_coverage && genhtml -o coverage coverage/lcov.info

open_coverage:
	make build_coverage && open coverage/index.html

built_value_watch:
	flutter packages pub run build_runner watch --delete-conflicting-outputs

run_mock:
	flutter run --flavor mock --dart-define=env.mode=mock --no-tree-shake-icons

run_prod:
	flutter run --flavor prod --dart-define=env.mode=prod --no-tree-shake-icons

run_staging:
	flutter run --flavor staging --dart-define=env.mode=staging --no-tree-shake-icons

run_dev:
	flutter run --flavor dev --dart-define=env.mode=dev --no-tree-shake-icons