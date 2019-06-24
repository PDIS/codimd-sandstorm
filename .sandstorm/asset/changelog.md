# 0.0.1

- Base on hackmd/codimd - #5606380
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
    - To disable single note per grain(i.e. behavior as CodiMD default), remove following line on `luncher.sh`
      ```
      export CMD_SINGLE_NOTE=true
      ```
  - Implement auth module `sandstorm`