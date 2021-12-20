dependencies-build:
	carthage build --platform iOS --cache-builds --use-xcframeworks --no-use-binaries

dependencies-update:
	carthage update --platform iOS --cache-builds --use-xcframeworks --no-use-binaries