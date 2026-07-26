//! Structural helpers for fleet ruleset JSON used by the docsite examples/tests.
//!
//! The rendered documentation is produced by **mdBook** (`book.toml`), not by
//! this crate. This library exists so CI can `cargo test` the machine-checkable
//! parts of the ruleset model without drifting into a second site generator.

use serde::Deserialize;
use serde_json::Value;
use std::fs;
use std::path::{Path, PathBuf};

/// Minimal ruleset shape we require every vendored JSON file to satisfy.
#[derive(Debug, Deserialize)]
pub struct Ruleset {
    pub name: String,
    pub target: String,
    pub enforcement: String,
    pub rules: Vec<Value>,
}

impl Ruleset {
    pub fn from_path(path: impl AsRef<Path>) -> Result<Self, String> {
        let path = path.as_ref();
        let text = fs::read_to_string(path)
            .map_err(|e| format!("read {}: {e}", path.display()))?;
        let rs: Ruleset = serde_json::from_str(&text)
            .map_err(|e| format!("parse {}: {e}", path.display()))?;
        if rs.rules.is_empty() {
            return Err(format!("{}: rules array is empty", path.display()));
        }
        if rs.name.is_empty() || rs.target.is_empty() || rs.enforcement.is_empty() {
            return Err(format!(
                "{}: name/target/enforcement must be non-empty",
                path.display()
            ));
        }
        Ok(rs)
    }
}

/// Resolve `src/vendor/rulesets` relative to the crate manifest.
pub fn vendor_rulesets_dir() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("src/vendor/rulesets")
}

/// Canonical two-ruleset names.
pub const CANONICAL_RULESETS: &[&str] = &[
    "trunk-default-gated",
    "trunk-integration-guarded",
];

/// Three-state conformance classification used in examples and docs.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ConformanceState {
    Conformant,
    DeviationRecorded,
    Drift,
}

impl ConformanceState {
    pub fn classify(matches_rule: bool, has_recorded_reason: bool) -> Self {
        if matches_rule {
            Self::Conformant
        } else if has_recorded_reason {
            Self::DeviationRecorded
        } else {
            Self::Drift
        }
    }

    pub fn is_failure(self) -> bool {
        matches!(self, Self::Drift)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn three_state_model() {
        assert_eq!(
            ConformanceState::classify(true, false),
            ConformanceState::Conformant
        );
        assert_eq!(
            ConformanceState::classify(false, true),
            ConformanceState::DeviationRecorded
        );
        assert_eq!(
            ConformanceState::classify(false, false),
            ConformanceState::Drift
        );
        assert!(ConformanceState::Drift.is_failure());
        assert!(!ConformanceState::Conformant.is_failure());
        assert!(!ConformanceState::DeviationRecorded.is_failure());
    }

    #[test]
    fn vendored_rulesets_parse_and_match_canonical_names() {
        let dir = vendor_rulesets_dir();
        if !dir.is_dir() {
            // Allow `cargo test` before vendor in pure unit contexts; CI always vendors first.
            eprintln!("skip: {} missing (run scripts/vendor-sources.sh)", dir.display());
            return;
        }
        for name in CANONICAL_RULESETS {
            let path = dir.join(format!("{name}.json"));
            let rs = Ruleset::from_path(&path).unwrap_or_else(|e| panic!("{e}"));
            assert_eq!(&rs.name, name);
            assert_eq!(rs.target, "branch");
            assert_eq!(rs.enforcement, "active");
        }
    }

    #[test]
    fn default_gated_has_status_checks_rule() {
        let path = vendor_rulesets_dir().join("trunk-default-gated.json");
        if !path.is_file() {
            eprintln!("skip: {}", path.display());
            return;
        }
        let rs = Ruleset::from_path(&path).unwrap();
        let has = rs.rules.iter().any(|r| r.get("type").and_then(|t| t.as_str()) == Some("required_status_checks"));
        assert!(has, "trunk-default-gated must declare required_status_checks");
    }
}
