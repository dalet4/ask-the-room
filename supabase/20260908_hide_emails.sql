-- Keep the existing approved-row policy. Emails are for delivery only.
revoke select on public.demo_submissions from anon;
grant select (id, created_at, message, status, answer, answered_at)
  on public.demo_submissions to anon;
