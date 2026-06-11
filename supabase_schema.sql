-- ============================================================
-- LeadWire - Supabase Database Schema (v2)
-- Run this in: Supabase Dashboard → SQL Editor → Run
-- ============================================================

-- Create leads table
CREATE TABLE IF NOT EXISTS public.leads (
  id                        BIGSERIAL    PRIMARY KEY,
  name                      TEXT         NOT NULL,
  location                  TEXT         DEFAULT '',
  region                    TEXT         DEFAULT 'thailand',
  industry                  TEXT         DEFAULT '',
  channel                   TEXT         DEFAULT '',
  products                  TEXT         DEFAULT '',
  contact_person            TEXT         DEFAULT '',
  email                     TEXT         DEFAULT '',
  phone                     TEXT         DEFAULT '',
  website                   TEXT         DEFAULT '',
  crm_synced                BOOLEAN      NOT NULL DEFAULT FALSE,
  lead_score                INTEGER      NOT NULL DEFAULT 0 CHECK (lead_score >= 0 AND lead_score <= 100),
  lead_level                TEXT         DEFAULT 'C (Standard)',
  lead_value                BIGINT       NOT NULL DEFAULT 0,
  company_size_points       INTEGER      DEFAULT 10,
  annual_value_points       INTEGER      DEFAULT 5,
  growth_potential_points   INTEGER      DEFAULT 10,
  strategic_importance_points INTEGER    DEFAULT 10,
  certifications            TEXT[]       DEFAULT '{}',
  notes                     TEXT         DEFAULT '',
  created_at                TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
  updated_at                TIMESTAMPTZ  NOT NULL DEFAULT NOW()
);

-- Auto-update updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS leads_updated_at ON public.leads;
CREATE TRIGGER leads_updated_at
  BEFORE UPDATE ON public.leads
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Enable Row Level Security
ALTER TABLE public.leads ENABLE ROW LEVEL SECURITY;

-- Policy: Allow all operations (no auth for now)
DROP POLICY IF EXISTS "allow_all_leads" ON public.leads;
CREATE POLICY "allow_all_leads"
  ON public.leads FOR ALL
  USING (true)
  WITH CHECK (true);

-- Enable Realtime
ALTER PUBLICATION supabase_realtime ADD TABLE public.leads;
