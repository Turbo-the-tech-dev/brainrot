# ==============================================================================
# IMPERIAL COMMAND: MASTER CONTROL MAKEFILE
# ==============================================================================

.PHONY: help dashboard mutate pulse status

help:
	 @echo ">> AVAILABLE PROTOCOLS:"
	 @echo "  make dashboard  - Launch the Live Sigma TUI (curses)"
	 @echo "  make mutate     - Trigger a manual Autonomous Edit Cycle"
	 @echo "  make pulse      - Force update the deadpan-brainrot.json telemetry"
	 @echo "  make status     - View current git status and recent machine thoughts"

dashboard:
	 @echo ">> Launching Sigma TUI..."
	 @python3 sigma_dash.py

mutate:
	 @echo ">> Forcing Autonomous Mutation..."
	 @./auto_edit.sh

pulse:
	 @echo ">> Calculating new Ohio Risk factors..."
	 @python3 processor.py

status:
	 @echo ">> SYSTEM STATUS & RECENT THOUGHTS:"
	 @git status -s
	 @echo "---------------------------------------------------"
	 @tail -n 5 GEMINI_BRAINROT.md
	 @echo "---------------------------------------------------"

speak:
	@echo ">> Activating Lore Aggregator (TTS)..."
	@./speak.sh
