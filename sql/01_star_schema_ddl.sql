-- ============================================================================
-- QuickBite: On-Demand Food Delivery Fleet Dispatch & Kitchen SLA Analytics
-- Star Schema DDL (PostgreSQL 16 Enterprise Spec)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS quickbite_dw;
SET search_path TO quickbite_dw, public;

-- Date Dimension
CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_name VARCHAR(12) NOT NULL,
    is_weekend BOOLEAN NOT NULL,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_riders (
    riders_key SERIAL PRIMARY KEY,
    riders_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_merchants (
    merchants_key SERIAL PRIMARY KEY,
    merchants_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_geozones (
    geozones_key SERIAL PRIMARY KEY,
    geozones_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_cuisine_types (
    cuisine_types_key SERIAL PRIMARY KEY,
    cuisine_types_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_delivery_orders (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_rider_telemetry (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_kitchen_prep_times (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_customer_complaints (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

