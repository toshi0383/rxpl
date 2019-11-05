# rxpl

<a href="https://github.com/toshi0383/rxpl/releases"><img src="https://img.shields.io/github/release/toshi0383/rxpl.svg" alt="Git Version" /></a><a href="https://github.com/toshi0383/rxpl/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-lightgray.svg" alt="license" /></a>

rxpl is short for RxSwift Playground. RxSwift code runner in CLI.

You don't need playground GUI with Xcode to try out small things!

## Usage

```
// hellorx.swift
import RxSwift

_ = Observable.just(1).debug("[A]").subscribe()
```

```bash
$ rxpl run hellorx.swift
2019-11-06 00:43:38.540: [A] -> subscribed
2019-11-06 00:43:38.546: [A] -> Event next(1)
2019-11-06 00:43:38.546: [A] -> Event completed
2019-11-06 00:43:38.546: [A] -> isDisposed
```

## Install

### [Mint](https://github.com/yonaskolb/Mint)

```
mint install toshi0383/rxpl
```

## Why rxpl ?

`rxpl` is lightweight and for quick use in command-line.

If you need Xcode Playground, try these awesome tools!

- https://github.com/bow-swift/nef

## License

MIT
