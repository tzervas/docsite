//! Print the build source pin if present (post-vendor).
use std::fs;
use std::path::PathBuf;
use std::process::ExitCode;

fn main() -> ExitCode {
    let pin = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("src/vendor/SOURCE-PIN.md");
    match fs::read_to_string(&pin) {
        Ok(text) => {
            print!("{text}");
            ExitCode::SUCCESS
        }
        Err(e) => {
            eprintln!(
                "no pin at {} ({e}); run scripts/vendor-sources.sh first",
                pin.display()
            );
            ExitCode::FAILURE
        }
    }
}
