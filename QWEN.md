# Brainrot Repository - Context Documentation

## Directory Overview

This is an experimental/themed repository called **"brainrot"** - a playful project built around internet culture memes and "brainrot" terminology (Gen Alpha/Gen Z slang like "rizz", "sigma", "Ohio", "Fanum Tax", etc.). The project appears to be a creative experiment combining:

1. **Autonomous repository mutation system** - Scripts that automatically edit and commit changes
2. **Payload data files** - JSON files containing themed content
3. **Infrastructure audit tooling** - Comprehensive repository health checking
4. **GitHub Actions automation** - Scheduled autonomous edits

## Key Files and Structure

### Core Configuration
- **`BRAINROT_CONFIG.yml`** - Main configuration file with themed settings (rizz_index, fanum_tax_rate, ohio_containment, etc.)
- **`absolute_velocity.json`** - Scenario definitions with priority levels and metrics

### Scripts
- **`audit.sh`** - Repository health & infrastructure audit script (30 checks for documentation, DX, security, architecture)
- **`auto_edit.sh`** - Autonomous mutation engine that edits markdown/config files and commits changes

### Data Files
- **`budgets.csv`** - Budget tracking data
- **`data/brainrot_payloads/`** - 50 themed payload JSON files with brainrot content, tags, and metadata
- **`data/deadpan/`** - 34+ "Deadpan" variant JSON files

### Documentation
- **`brainrot bitches.md`** - Experimental data logs with project notes
- **`CONTRIBUTORS`** - Contributor acknowledgments

### Directories
- **`.github/workflows/`** - GitHub Actions workflows (`pulse.yml` - hourly autonomous mutation job)
- **`brainrot/`** - Subdirectory with chat logs and project root markers
- **`brainrot_extracted/`** - Extracted content directory
- **`archives/`** - Archive storage (replit, web subdirectories)
- **`data/`** - Organized data files (brainrot_payloads/, deadpan/)
- **`media/`** - Media assets (grok subdirectory)
- **`notes/`** - Documentation notes including a QWEN.md file

## Usage

### Running the Audit Script
```bash
# Report mode (default)
./audit.sh

# Apply mode (creates GitHub issues)
./audit.sh --apply
```

### Autonomous Mutation Engine
```bash
# Run the auto-edit script manually
./auto_edit.sh
```

### GitHub Actions
The `pulse.yml` workflow runs:
- On push to `feature/pulse-meter` or `hardening/atomic-refactor-67` branches
- Hourly via cron schedule
- Executes `auto_edit.sh` and posts to system log

## Technical Notes

- The repository uses Git for version control
- GitHub CLI (`gh`) is required for full functionality
- The project has a humorous/themed approach to DevOps concepts
- `.gitignore` excludes editor backup files and common OS artifacts

## Related Files
- Session logs stored in `brainrot/logs.json`
