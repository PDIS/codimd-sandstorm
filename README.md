SandMD 2 
===

CodiMD on sandstorm

base on hackmd/codimd (#5606380)

More info: https://github.com/hackmdio/codimd

## Different between

- Using `winston-sandstorm` replace `winston` as an dependency
Because `process.memoryUsage()` can't be executed on sandstorm. We fork `winston` package, remove usage of `process.memoryUsage()` and pack as new npm package `winston-sandstorm`
- Link of image upload (which upload to filesystem) will be relative path instead of uri
- Using `multer` replace `formidable`
    Prevent randomly failure of image upload

## License

**License under AGPL.**