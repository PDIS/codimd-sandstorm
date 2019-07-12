CodiMD
===

The CodiMD (`hackmdio/codimd`) on Sandstorm, base on `hackmdio/codimd#5606380`

More information

## Feature

The feature about CodiMD, please refer the [document](https://github.com/hackmdio/codimd/blob/master/public/docs/features.md) from `hackmdio/codimd`

There are something different between this package and upstream

- Single note per grain
    - If logged on sandstorm, auto login into CodiMD and find or create note then redirect to show it.
    - Otherwise, show note if note is exists or redirect 404 not found page
    - Remove `New` button
- Remove `Publish` button
- Default permission are `freely`

    The default value of CodiMD is `editable`
    
- Hidden export on menu
- Add print mode
    
    Popup print dialog when the page are loaded

- Unsupported on Internet Explore
  
    The default 

## License

**License under AGPL.**