#!/bin/bash
# ==============================================================================
# IMPERIAL COMMAND: TTS LORE AGGREGATOR
# ==============================================================================
# SECURITY: Hardened against command injection and unauthorized shell execution.

set -euo pipefail

TARGET_MD="GEMINI_BRAINROT.md"

# Ensure target manifest exists
if [[ ! -f "$TARGET_MD" ]]; then
    printf ">> [ERROR] Manifest %s not found. Aborting.\n" "$TARGET_MD" >&2
    exit 1
fi

printf ">> [SYSTEM] Extracting latest neural thought...\n"

# Grab the last line, strip out the timestamps and formatting for clean audio
LAST_THOUGHT=$(tail -n 1 "$TARGET_MD" | sed -e 's/.* - //')

# SECURITY: Defensive gate to prevent shell injection via malicious Markdown content.
# Reject strings containing shell metacharacters: \ ` $ ; & | "
if printf "%s" "$LAST_THOUGHT" | grep -qE '[\\`$;&|"]'; then
    printf ">> [SECURITY ALERT] Malicious neural thought detected. Execution halted.\n" >&2
    exit 1
fi

printf ">> [SPEAKING] \"%s\"\n" "$LAST_THOUGHT"

# Verify TTS engine availability
if ! command -v termux-tts-speak >/dev/null 2>&1; then
    printf ">> [NOTICE] termux-tts-speak not found. Simulating output.\n"
    printf "Sigma Protocol Update: %s\n" "$LAST_THOUGHT"
else
    # Pipe to Termux TTS
    termux-tts-speak "Sigma Protocol Update: $LAST_THOUGHT"
fi

printf ">> [SUCCESS] Vocalization complete.\n"
