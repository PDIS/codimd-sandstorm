# 0.1.1
- Fix bug
	- Can not access note after click document on single note mode

# 0.1.0
- Dependency replacement & upgrade
	- Replace jsdom-nogyp => jsdom
	- Upgrade lodash `~4.17.11` => `~4.17.13`
		- In order to fix security vulnerabilities
	- Remove `meta-marked`
		- meta-marked has been replace by `@hackmd/meta-marked` on upstream
	- Upgrade sequelize `5.3.5` => `~5.x`
		- In order to fix security vulnerabilityies
- Update `launcher.sh`
	- Remove sql statement which unnecessary on `--skip-grant-tables` model
- Rearrangement config of package
	- Remove file which path be include in `alwaysInclude` from file.list
	- Add `usr/lib/node_modules` into `alwaysInclude`
- Fix typo
	- Merge PR #2
	- `hackmd/codimd` => `hackmdio/codimd`
- Fix bug
	- sequence diagrams broken when useCDN is disabled

# 0.0.6
- Upgrade dependency version
- Rewrite description document

# 0.0.5
- Internet Explorer user will get alert message

# 0.0.4
- Hidden export list
- Add print mode
  Open new window and pop up print dialog of browser
- Default permission are `freely`

    To using CodiMD default value `editable`, remove following line on `launcher.sh` and rebuild it
    ```
    export CMD_DEFAULT_PERMISSION=freely
    ```
- Workaround: add `zh-tw` on i18n list for Safari

# 0.0.3

- Fix bug case by file not be list in file list
  - Emoji missing
  - MathJax not working

# 0.0.2

- Remove `Publish` button
- Remove `New` button on CMD_SINGLE_NOTE=true
- Change bad request condition on sandstorm auth, maybe can fix bug: return `400 Bad request` after logged sandstorm


# 0.0.1

- Base on hackmdio/codimd - #5606380
- Dependency change
  - Using `winston-sandstorm` replace `winston` as an dependency

    Because `process.memoryUsage()` can't be executed on sandstorm. We fork `winston` package, remove usage of `process.memoryUsage()` and pack an new package  `winston-sandstorm` upload to npm
  - Add `multer`
  - Remove `formidable`
- Image upload re-implement
  - Using `multer` replace `formidable`

    Prevent randomly failure of image upload
  - Link of image upload (which upload to filesystem) will be relative path instead of uri
- Add mode - single note per grain
  - In this mode, auto login by using `x-sandstorm-*` header
  - To disable single note per grain(i.e. behavior as CodiMD default), remove following line on `launcher.sh`
    ```
    export CMD_SINGLE_NOTE=true
    ```
- Implement auth module `sandstorm`
