CodiMD-Sandstorm
===

CodiMD on sandstorm

base on hackmdio/codimd (2.3.2)

More info: https://github.com/hackmdio/codimd

## Something different between CodiMD-Sandstorm and CodiMD

- Using `Anonymous - (Date.ISOString)` as user display name and `x-sandstorm-tab-id` as user profile id to create user when user is not logged in sandstorm.
  > To disable this feature, you need to modify `.sandstorm/launcher.sh`, set `CMD_ENABLE_ANONYMOUS_USER` to `false`

- Using `winston-sandstorm` replace `winston` as an dependency

    Because `process.memoryUsage()` can't be executed on sandstorm. We fork `winston` package, remove usage of `process.memoryUsage()` and pack an new package  `winston-sandstorm` upload to npm
- Link of image upload (which upload to filesystem) will be relative path instead of uri
- Using `multer` replace `formidable`

    Prevent randomly failure of image upload
- Single note per grain
    - If logged on sandstorm, auto login into CodiMD and find or create note then redirect to show it.
    - Otherwise, show note if note is exists or redirect 404 not found page
    - Remove `New` button

        To disable single note per grain(i.e. behavior as CodiMD default), remove following line on `launcher.sh`
        ```
        export CMD_SINGLE_NOTE=true
        ```
- Remove `Publish` button
- Default permission are `freely`

    To using CodiMD default value `editable`, remove following line on `launcher.sh` and rebuild it
    ```
    export CMD_DEFAULT_PERMISSION=freely
    ```
- Hidden export on menu
- Add print mode
- Unsupported on Internet Explore

## Changelog

**2.3.2**

Merge 2.3.2 from upstream (hackmdio/codimd).

Check [release note](https://hackmd.io/@codimd/release-notes/%2F%40codimd%2Fv2_3_0) to know more new new features.

**2.2.0**

Merge 2.2.0 from upstream (hackmdio/codimd).

Check [release note](https://hackmd.io/@codimd/release-notes/%2F%40codimd%2Fv2_2_0) to know more new new features.

**2.0.1**

Merge 2.0.1 from upstream (hackmdio/codimd).

Check [release note](https://hackmd.io/@codimd/release-notes/%2F%40codimd%2Fv2_0_1) to know more new new features.

**Fix**

- Show print dialog after markdown has been rendered. (Prevent empty content be printed.)

**2.0.0**

Merge 2.0.0 from upstream (hackmdio/codimd).

Check [release note](https://hackmd.io/@codimd/release-notes/%2F%40codimd%2Fv2_0_0) to know more new new features.

**New feature only on sandstorm version**
- Using `Anonymous - (Date.ISOString)` as user display name and `x-sandstorm-tab-id` as user profile id to create user when user is not logged in sandstorm.
  > To disable this feature, you need to modify `.sandstorm/launcher.sh`, set `CMD_ENABLE_ANONYMOUS_USER` to `false`

**1.4.1**
Merge 1.4.1 from upstream (hackmdio/codimd).

**0.1.2**
- Fix bug
	- Can not access note after click document on single note mode

**0.1.0**
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

**0.0.6**
- Upgrade dependency version
- Rewrite description document

**0.0.5**
- Internet Explorer user will get alert message

**0.0.4**
- Hidden export list
- Add print mode
  Open new window and pop up print dialog of browser
- Default permission are `freely`

    To using CodiMD default value `editable`, remove following line on `launcher.sh` and rebuild it
    ```
    export CMD_DEFAULT_PERMISSION=freely
    ```
- Workaround: add `zh-tw` on i18n list for Safari

**0.0.3**

- Fix bug case by file not be list in file list
  - Emoji missing
  - MathJax not working

**0.0.2**

- Remove `Publish` button
- Remove `New` button on CMD_SINGLE_NOTE=true
- Change bad request condition on sandstorm auth, maybe can fix bug: return `400 Bad request` after logged sandstorm


**0.0.1**

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


## License

**License under AGPL.**
