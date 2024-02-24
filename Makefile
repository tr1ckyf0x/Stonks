bootstrap: mint_bootstrap generate_xcodeproj_file

mint_bootstrap:
	MINT_LINK_PATH=.bin mint bootstrap --link

install_bundle:
	bundle install

generate_xcodeproj_file:
	mint run xcodegen

git_clean:
	git clean -f -d -x
