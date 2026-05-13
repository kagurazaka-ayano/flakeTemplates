# Templates

Some of my own flake templates.

## Use

```bash
nix flake init --template github:kagurazaka-ayano/flakeTemplates <template>
```

## Available

- `cmake-exe`: CMake executable project template.
- `cmake-lib`: CMake library project template.
- `rust`: Rust project template with `oxalica/rust-overlay` and direnv config.
- `rust-with-ci`: Rust project template with `oxalica/rust-overlay`, direnv config, and github ci.

See `flake.nix` for more detail
