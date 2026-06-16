-- IELTS-64 Supabase Schema
-- Run this in the Supabase SQL Editor (https://supabase.com/dashboard/project/_/sql/new)

-- 1. Members table
CREATE TABLE members (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  photo TEXT,
  emoji TEXT,
  featured BOOLEAN DEFAULT FALSE,
  funny_photos JSONB DEFAULT '[]'::jsonb,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security (optional but recommended)
ALTER TABLE members ENABLE ROW LEVEL SECURITY;

-- Allow all operations for now (public access with anon key)
CREATE POLICY "Public access" ON members FOR ALL USING (true);

-- 2. Stories table
CREATE TABLE stories (
  id SERIAL PRIMARY KEY,
  emoji TEXT DEFAULT '🍃',
  title TEXT NOT NULL,
  date TEXT,
  divider TEXT DEFAULT '✨ ✨ ✨',
  text TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE stories ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public access" ON stories FOR ALL USING (true);

-- 3. Board strokes — single row storing the full strokes array as JSON
CREATE TABLE board_strokes (
  id INTEGER PRIMARY KEY DEFAULT 1,
  strokes JSONB NOT NULL DEFAULT '[]'::jsonb,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE board_strokes ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public access" ON board_strokes FOR ALL USING (true);

-- Insert the initial board row so we can upsert
INSERT INTO board_strokes (id, strokes) VALUES (1, '[]'::jsonb)
ON CONFLICT (id) DO NOTHING;
