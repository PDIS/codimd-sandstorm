SandMD 2 
===

CodiMD on sandstorm

base on hackmd/codimd (#5606380)

More info: https://github.com/hackmdio/codimd

## Something different between SandMD 2 and CodiMD

- Using `winston-sandstorm` replace `winston` as an dependency
Because `process.memoryUsage()` can't be executed on sandstorm. We fork `winston` package, remove usage of `process.memoryUsage()` and pack an new package  `winston-sandstorm`, upload to npm
- Link of image upload (which upload to filesystem) will be relative path instead of uri
- Using `multer` replace `formidable`
    Prevent randomly failure of image upload
- Single note per grain
    - If logged on sandstorm, auto login into CodiMD and find or create note then redirect to show note.
    - Otherwise, show note if note is exists or redirect 404 not found page
  To disable single note per grain(i.e. behavior as CodiMD default), remove following line on `luncher.sh`
  ```
  export CMD_SINGLE_NOTE=true
  ```


## License

**License under AGPL.**