## 2026-03-10 - Telemetry Schema Regression
**Vulnerability:** Unexpected overwrite of `deadpan-brainrot.json` with a new, incompatible schema.
**Learning:** Initial security enhancement in `processor.py` unintentionally introduced a breaking change by reusing an existing data file path for new telemetry output, causing a schema mismatch for any downstream consumers of the original file.
**Prevention:** Use dedicated output files for new metrics/telemetry rather than overwriting existing domain-specific data files. Always verify the original contents and purpose of a file before modifying its write logic.
