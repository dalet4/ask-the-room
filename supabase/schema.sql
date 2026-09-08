-- Ask the room's agent — the whole database.
-- Run this in the Supabase SQL editor before importing the n8n workflows.

create table public.demo_submissions (
  id          bigint generated always as identity primary key,
  created_at  timestamptz not null default now(),
  message     text not null,
  email       text,
  status      text not null default 'pending'
              check (status in ('pending', 'approved', 'blocked')),
  block_reason text,
  answer      text,
  answered_at timestamptz
);

alter table public.demo_submissions enable row level security;

-- This is the part that matters.
--
-- The page on the projector reads with the publishable key, which means it is
-- the anon role, which means this policy is the only thing it can ever see:
-- messages that have already passed the check. A 'pending' or 'blocked' row is
-- invisible to it even if the page asks for everything.
create policy demo_submissions_read_approved
  on public.demo_submissions
  for select
  to anon
  using (status = 'approved');

-- SELECT and nothing else. Rows only ever arrive from n8n using the service
-- role, after moderation. Nothing can write to this table from a browser.
grant select on public.demo_submissions to anon;
