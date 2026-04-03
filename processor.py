import json
import time
import random

def calculate_ohio_risk(load):
    # SECURITY GATE: Ensure load is numeric and within safety parameters (0-100)
    if not isinstance(load, (int, float)):
        raise ValueError("Neural load must be numeric.")
    if not (0 <= load <= 100):
        raise ValueError("Neural load out of safety bounds (0-100).")

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

def write_telemetry_to_file(data, filename):
    # SECURITY PATTERN: Decouple generation from persistence for auditability
    with open(filename, 'w') as f:
        json.dump(data, f, indent=2)

if __name__ == "__main__":
    data = generate_telemetry()
    print(f">> [SYSTEM] Telemetry calculated: {data['status']}")

    # SECURITY PATTERN: Use decoupled writer for auditability
    write_telemetry_to_file(data, 'deadpan-brainrot.json')

    print(">> [SUCCESS] deadpan-brainrot.json updated for Terminal View.")
