# homebrew-muffle

Homebrew tap for [Muffle](https://github.com/Thavarshan/muffle), a native
C++17 command wrapper that suppresses successful output and shows failure
details.

Install with:

```sh
brew install Thavarshan/muffle/muffle
muffle --version
```

Homebrew 7 may ask you to trust this third-party formula. Review the formula
source and approve the trust prompt if shown. The formula builds Muffle from
its immutable upstream version tag with CMake.

Update and uninstall with:

```sh
brew update
brew upgrade muffle
brew uninstall muffle
```

A scheduled workflow checks upstream releases, updates the formula checksum,
then audits, builds, tests, and pushes a formula update. The workflow can also
be started manually to retry a failed update. Source, issues, and security
reporting are maintained in the upstream repository.
