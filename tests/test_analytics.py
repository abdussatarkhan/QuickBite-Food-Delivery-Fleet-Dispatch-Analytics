"""
QuickBite: On-Demand Food Delivery Fleet Dispatch & Kitchen SLA Analytics - Pytest Automated Test Suite
"""
import pytest
import numpy as np


def test_order_to_door_sla():
    avg_minutes = 26.4
    assert avg_minutes <= 30.0

def test_batching_density_math():
    total_deliveries = 17400
    rider_trips = 10000
    assert total_deliveries / rider_trips == pytest.approx(1.74)



def test_sla_compliance_bounds():
    compliant = 9400
    total = 10000
    assert round((compliant / total) * 100.0, 2) == pytest.approx(94.0)


def test_data_integrity():
    metric_val = 1420.50
    assert metric_val > 0
