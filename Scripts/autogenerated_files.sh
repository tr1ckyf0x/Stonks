#!/bin/sh

SWIFTGEN_MODULES=(
	"SharedResources"
	)

MODULES_FOLDER="./Packages"

for MODULE in "${SWIFTGEN_MODULES[@]}"; do
	MODULE_DIR="${MODULES_FOLDER}/${MODULE}"
	mkdir -p "${MODULE_DIR}/Sources/${MODULE}/Generated"
	swiftgen config run --config "${MODULE_DIR}/swiftgen.yml"
done

# StonksWidget

mkdir -p "StonksWidget/Generated"
swiftgen config run --config  "StonksWidget/swiftgen.yml"

# Stonks

mkdir -p "Stonks/Generated"
swiftgen config run --config  "Stonks/swiftgen.yml"