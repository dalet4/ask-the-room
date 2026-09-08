# Prompt 1 — the answering workflow

Fires at **04:00**. Claude Code with the n8n MCP server connected.

---

## Say this (out loud, before you send it)

> Right. I'm going to describe what I want, not how to build it. Watch where I'm
> specific and where I'm deliberately not.
>
> I've told it the table, because that's a fact it can't guess. I've told it
> which model, because that's a cost decision and I don't want it choosing.
> I have not told it how many steps to use, what to call anything, or how to
> word the answers. That's the bit it's better at than me.
>
> And there's one line in here that says don't touch the guardrail. I'll come
> back to why that one matters.

Send it. Then look away from the screen.

---

## Send this

```text
Build me an n8n workflow called "Leeds — Answer the Room".

Every 20 seconds, find rows in the Supabase table public.demo_submissions where
status = 'approved' and answer is null. For each one, use OpenRouter with the
model anthropic/claude-sonnet-4.6 to write a genuinely useful answer to what the
person asked, then write that answer back onto the same row in the answer column
and set answered_at to now.

Constraints:
- Answers are for a projector in a room of about forty people, so keep them
  under 50 words, plain English, no bullet points, no markdown.
- It is being asked questions about automation, n8n, AI agents and how this demo
  works. If a question is not about any of that, answer it anyway, briefly and
  with some humour.
- Never answer more than 5 rows in one run.

Use the existing credentials. Do not create new ones:
- Supabase: "Aigentic Supabase (service role)"
- OpenRouter: "OpenRouter account"

There is already an active workflow called "Leeds — Room Intake (guardrail)"
(id 2xPcgnwdBMuo0oVh) that receives submissions and moderates them before they
are stored. Do not modify it, do not copy from it, do not touch the moderation
step in any way. Your workflow only reads rows that are already approved.

Deploy it to my n8n instance and activate it.
```

---

## What "good" looks like when it lands

A canvas with roughly: schedule trigger → Supabase read → loop → OpenRouter →
Supabase update. Five or six nodes. If it comes back with fifteen, that is scope
creep and you cut to `demo-safe`.

**Do not read the nodes aloud.** Trace it with your finger, four sentences, no
jargon: *"this wakes up every twenty seconds… this fetches the ones nobody has
answered yet… this asks Claude… this puts the answer back."*
