#!/bin/bash
# Mock termux-tts-speak
mkdir -p bin
echo '#!/bin/bash' > bin/termux-tts-speak
echo "MOCK TTS: \$@" >> tts_output.log
chmod +x bin/termux-tts-speak
export PATH="$PWD/bin:$PATH"

TARGET_MD="GEMINI_BRAINROT.md"
cp "$TARGET_MD" "${TARGET_MD}.bak"

test_thought() {
    local thought="$1"
    local expected_status="$2"
    echo "Testing thought: $thought"
    echo "2026-03-10 - $thought" >> "$TARGET_MD"
    ./speak.sh > /dev/null 2>&1
    local status=$?
    if [ $status -eq $expected_status ]; then
        echo "  [PASS] Status $status as expected."
    else
        echo "  [FAIL] Expected status $expected_status, got $status."
    fi
    # Restore file for next test
    cp "${TARGET_MD}.bak" "$TARGET_MD"
}

echo "Running speak.sh security tests..."
test_thought "Normal thought" 0
test_thought "Thought with; semicolon" 1
test_thought "Thought with \`backticks\`" 1
test_thought "Thought with \$(command substitution)" 1
test_thought "Thought with | pipe" 1
test_thought "Thought with & background" 1
test_thought "Thought with \" quotes" 1
test_thought "Thought with \\ backslash" 1

# Cleanup
rm -rf bin tts_output.log "${TARGET_MD}.bak"
