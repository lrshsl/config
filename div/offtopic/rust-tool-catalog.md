<!-- Based on output from [Google gemini](https://gemini.google.com) -->

# Contents

- [Optimization](#optimization)
    - [Optimization loop](#optimization-loop)
    - [Tool catalog](#tool-catalog)
    - [Honorable mentions](#honorable-mentions)
- [Macro development](#macro-dev)

# Optimization

## Optimization loop

This is the standard workflow for systematically improving performance.

1. **Spot it:** Use **`samply`** to identify the bottleneck (the function taking 80% of the time).
2. **Isolate it:** Write a **`divan`** benchmark for that specific function to establish a baseline.
3. **Inspect it:** Use **`dhat`** (allocations) or **`cargo-show-asm`** (instructions) to understand *why* it is slow.
4. **Fix it:** Apply code changes.
5. **Verify:** Run `divan` again to confirm the speedup, or **`iai-callgrind`** for need stable metrics for CI.

---

## Tool catalog

### 1. Assembly / LLVM IR inspection

**`cargo-show-asm`**

* **Description:** Displays the actual assembly or LLVM IR generated for a specific function. Essential for verifying if abstractions (like builders/iterators) were optimized away.
* **Usage:**
```bash
# Show assembly for function 'my_func' in release mode
cargo asm --lib --release my_crate::my_func

```


* **Link:** [crates.io/crates/cargo-show-asm](https://crates.io/crates/cargo-show-asm)

### 2. Profiling (time)

**`samply`**

* **Description:** A low-overhead sampling profiler that runs locally but outputs to the Firefox Profiler web interface. It provides flamegraphs, stack charts, and timelines.
* **Usage:**
```bash
# Records execution and automatically opens the browser
samply record ./target/release/my-binary

```


* **Link:** [github.com/mstange/samply](https://github.com/mstange/samply)

### 3. Benchmarking (time)

**`divan`**

* **Description:** A modern, ergonomic micro-benchmarking library. simpler and often faster to compile than Criterion.
* **Usage:**
```rust
#[divan::bench]
fn benchmark_fib() {
    fibonacci(20);
}
// Run with: cargo bench

```


* **Link:** [github.com/nvzqz/divan](https://github.com/nvzqz/divan)

### 4. Benchmarking (instructions / CI)

**`iai-callgrind`**

* **Description:** Benchmarks based on *instruction count* (using Valgrind) rather than wall-clock time. It is deterministic, making it perfect for CI environments where CPU load varies.
* **Usage:**
```bash
# Requires Valgrind installed
cargo bench --bench my_iai_benchmark

```


* **Link:** [github.com/iai-callgrind/iai-callgrind](https://github.com/iai-callgrind/iai-callgrind)

### 5. Memory profiling

**`dhat` (Dynamic Heap Analysis Tool)**

* **Description:** Tracks heap allocations to find "hot" allocation sites. It helps identify unnecessary cloning or temporary vector allocations.
* **Usage:**
```rust
// Add the global allocator in main.rs
#[global_allocator]
static ALLOC: dhat::Alloc = dhat::Alloc;

```


* **Link:** [crates.io/crates/dhat](https://crates.io/crates/dhat)

**`heaptrack`**

* **Description:** A Linux-only GUI tool that visualizes memory consumption, leaks, and allocation hotspots over time.
* **Usage:**
```bash
heaptrack ./target/release/my-binary
# Opens a GUI analysis window after the run

```


* **Link:** [github.com/KDE/heaptrack](https://github.com/KDE/heaptrack)

### 6. Empirical usage-based optimization

**`cargo-pgo`**

* **Description:** Automates "profile guided optimization." It builds an instrumented binary, gathers data from a sample run, and then recompiles the code optimized specifically for that usage pattern.
* **Usage:**
```bash
cargo pgo build      # Build instrumented binary
./target/.../app     # Run the app to generate data
cargo pgo optimize   # Recompile using that data

```


* **Link:** [github.com/kobzol/cargo-pgo](https://github.com/kobzol/cargo-pgo)

---

## Honorable mentions

* **`cargo-wizard`**: If you don't want to manually tweak your `Cargo.toml` for performance (LTO, codegen-units, panic behavior), this tool asks you what you need (maximum performance vs. fast compile times) and updates your config automatically.
* *Command:* `cargo wizard apply`


* **`hyperfine`**: A command-line benchmarking tool. Great for measuring the end-to-end performance of CLI tools (e.g., `ripgrep` vs `grep`).
* *Command:* `hyperfine './my-app' './other-app'`




# Macro dev

1. **Setup:** `syn` + `quote` + `proc-macro2`
2. **Attributes:** `darling` for custom options like `#[builder(default)]`.
3. **Errors:** Use `manyhow` to simplify returning errors.
4. **Debug:** Use `cargo expand` to verify the output looks correct.
5. **Test:** Use `trybuild` to ensure users get good error messages.

## `syn`

* **Description:** The industrial-grade parser for Rust code. It takes a stream of "tokens" (raw text) and turns it into a structured AST (Abstract Syntax Tree) for inspection and modification.
* **Usage:**
```rust
use syn::{parse_macro_input, DeriveInput};
// Inside the proc_macro function:
let input = parse_macro_input!(item as DeriveInput);
println!("Struct name: {}", input.ident);

```


* **Link:** [crates.io/crates/syn](https://crates.io/crates/syn)

## `quote`

* **Description:** The counterpart to `syn`. While `syn` parses code, `quote` generates it. It provides the `quote!` macro, which allows to write Rust code templates and interpolate variables using `#var` syntax.
* **Usage:**
```rust
let name = input.ident;
let output = quote! {
    impl MyTrait for #name {
        fn hello() { println!("Hello from #name"); }
    }
};

```


* **Link:** [crates.io/crates/quote](https://crates.io/crates/quote)

## `proc-macro2`

* **Description:** A wrapper around the compiler's generic `proc_macro` crate. It allows to write macro logic that is testable outside the compiler (e.g., in unit tests) and provides a stable API across rust versions.
* **Usage:** mostly internal, but enables:
```rust
// Allows to write unit tests for macro logic
#[test]
fn test_macro_generation() { ... } 

```


* **Link:** [crates.io/crates/proc-macro2](https://crates.io/crates/proc-macro2)

---

## `darling`

* **Description:** When writing a `#[derive]` macro that takes custom attributes (e.g., `#[my_macro(min = 0, max = 10)]`), parsing them manually with `syn` is painful. `darling` lets you define a struct and "derive" the parsing logic automatically.
* **Usage:**
```rust
#[derive(FromDeriveInput)]
#[darling(attributes(my_macro))]
struct MyOptions {
    min: u32,
    #[darling(default)]
    max: u32,
}
// Now the attributes can be parsed directly into this struct

```


* **Link:** [crates.io/crates/darling](https://crates.io/crates/darling)

## `manyhow`

* **Description:** Error handling in macros is notoriously difficult (you have to emit specific `compile_error!` tokens). `manyhow` is a modern replacement for `proc-macro-error` that allows to use `Result<TokenStream, anyhow::Error>` in macro functions.
* **Usage:**
```rust
#[manyhow::manyhow]
#[proc_macro]
pub fn my_macro(input: TokenStream) -> manyhow::Result<TokenStream> {
    // Note: Now the `?` operator can be used in macro functions
    let ast: DeriveInput = syn::parse(input)?;
    Ok(quote! { ... })
}

```


* **Link:** [crates.io/crates/manyhow](https://crates.io/crates/manyhow)

---

## `trybuild`

* **Description:** The gold standard for testing macros. It runs a "UI Test" suite: it compiles small Rust files using the macro and asserts that they either pass or fail *with a specific error message*.
* **Usage:**
```rust
#[test]
fn ui() {
    let t = trybuild::TestCases::new();
    t.pass("tests/ui/01-successful-invocation.rs");
    t.compile_fail("tests/ui/02-invalid-input.rs");
}

```


* **Link:** [crates.io/crates/trybuild](https://crates.io/crates/trybuild)

## `cargo-expand`

* **Description:** A CLI tool, not a crate dependency. It runs the code through the macro expansion pass and prints the result *before* compilation finishes.
* **Usage:**
```bash
# Shows the code generated by macros in main.rs
cargo expand main 

```


* **Link:** [github.com/dtolnay/cargo-expand](https://github.com/dtolnay/cargo-expand)

---

