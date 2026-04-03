import unittest
from processor import calculate_ohio_risk

class TestSecurity(unittest.TestCase):
    def test_calculate_ohio_risk_valid(self):
        # Normal operation within bounds
        self.assertEqual(calculate_ohio_risk(81), 72.9)

    def test_calculate_ohio_risk_invalid_type(self):
        # Input validation for non-numeric types
        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk("81")
        self.assertEqual(str(cm.exception), "Neural load must be numeric.")

    def test_calculate_ohio_risk_out_of_bounds_low(self):
        # Input validation for below-zero range
        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk(-1)
        self.assertEqual(str(cm.exception), "Neural load out of safety bounds (0-100).")

    def test_calculate_ohio_risk_out_of_bounds_high(self):
        # Input validation for over-100 range
        with self.assertRaises(ValueError) as cm:
            calculate_ohio_risk(101)
        self.assertEqual(str(cm.exception), "Neural load out of safety bounds (0-100).")

if __name__ == "__main__":
    unittest.main()
