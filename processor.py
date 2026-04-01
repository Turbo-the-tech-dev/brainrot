import json
import time
import random

DEFAULT_OUTPUT_FILE = 'telemetry.json'

def calculate_ohio_risk(load):
    """
    Calculates the Ohio Risk factor based on neural load.

    SECURITY PATTERN: Input validation is required to prevent
    calculation errors or potential DoS with extreme values.
    """
    if not isinstance(load, (int, float)):
        raise ValueError("Neural load must be numeric.")

    if not (0 <= load <= 100):
        raise ValueError("Neural load must be between 0 and 100.")

    # Logarithmic scaling for critical neural load
    return round((load ** 1.5) / 10, 2)

def generate_telemetry():
    status_options = ["RIZZ_STABLE", "FANUM_TAX_DETECTED", "OHIO_PEAKING", "SIGMA_ENFORCED"]
    
    telemetry = {
        "timestamp": int(time.time()),
        "neural_load": random.randint(70, 99),
        "status": random.choice(status_options),
        "velocity": "ABSOLUTE"
    }
    
    telemetry["risk_factor"] = calculate_ohio_risk(telemetry["neural_load"])
    return telemetry

def write_telemetry_to_file(data, filepath=DEFAULT_OUTPUT_FILE):
    """
    TELEMETRY/DATA INTEGRITY: Writing to telemetry.json by default to
    avoid overwriting legacy data in deadpan-brainrot.json.
    """
    with open(filepath, 'w') as f:
        json.dump(data, f, indent=2)

if __name__ == "__main__":
    data = generate_telemetry()
    print(f">> [SYSTEM] Telemetry calculated: {data['status']}")
    write_telemetry_to_file(data)
    print(f">> [SUCCESS] {DEFAULT_OUTPUT_FILE} updated for Terminal View.")
