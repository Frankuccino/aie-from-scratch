#!/usr/bin/env bash

set -u

echo "======================================"
echo " AI ENGINEERING TOOLCHAIN TESTS"
echo "======================================"

failures=0

# --------------------------------------
# PYTHON
# --------------------------------------

echo ""
echo "========== PYTHON =========="

if command -v python3 >/dev/null 2>&1; then
    if python3 -c 'print("Python works")'; then
        echo "Python: PASS"
    else
        echo "Python: FAIL"
        failures=$((failures + 1))
    fi
else
    echo "Python: FAIL — python3 not found"
    failures=$((failures + 1))
fi

# --------------------------------------
# NODE.JS
# --------------------------------------

echo ""
echo "========== NODE.JS =========="

if command -v node >/dev/null 2>&1; then
    if node -e 'console.log("Node.js works")'; then
        echo "Node.js: PASS"
    else
        echo "Node.js: FAIL"
        failures=$((failures + 1))
    fi
else
    echo "Node.js: FAIL — node not found"
    failures=$((failures + 1))
fi

# --------------------------------------
# RUST
# --------------------------------------

echo ""
echo "========== RUST =========="

if command -v rustc >/dev/null 2>&1; then
    rust_binary="$(mktemp /tmp/ai-engineering-rust-test.XXXXXX)"

    if rustc -o "$rust_binary" - <<'RUST'
fn main() {
    println!("Rust works");
}
RUST
    then
        if "$rust_binary"; then
            echo "Rust: PASS"
        else
            echo "Rust: FAIL — compiled program could not execute"
            failures=$((failures + 1))
        fi
    else
        echo "Rust: FAIL — compilation unsuccessful"
        failures=$((failures + 1))
    fi

    rm -f "$rust_binary"
else
    echo "Rust: FAIL — rustc not found"
    failures=$((failures + 1))
fi

# --------------------------------------
# SUMMARY
# --------------------------------------

echo ""
echo "======================================"
echo " TEST SUMMARY"
echo "======================================"

if [ "$failures" -eq 0 ]; then
    echo "RESULT: ALL TESTS PASSED"
    echo "Python, Node.js, and Rust execute successfully."
else
    echo "RESULT: $failures TEST(S) FAILED"
    echo "Review the output above and troubleshoot."
    exit 1
fi

echo "======================================"
