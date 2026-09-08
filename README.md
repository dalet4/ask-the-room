# Ask the room's agent

This is the thing you watched get built at n8n Leeds on 10 September. All of it.
The form you typed into, the screen at the front, and the automations behind
both.

You do not need to have understood any of it to get it running.

---

## What it actually does

Four things, in order:

1. You type something into a form on your phone.
2. It goes to n8n, which checks whether it is safe to put on a projector.
3. If it is, it gets saved. If it is not, it gets held back and nobody sees it.
4. Another automation picks up the saved ones, asks Claude to answer them, and
   the answer appears on the screen.

That is the whole thing. Everything else is detail.

---

## Getting it running

You need the four services below to run it. AI coding assistants and Gmail
for optional email delivery are separate.

| What | What it does here | Cost to run this |
| --- | --- | --- |
| [n8n](https://n8n.io/pricing/) | The automations | Cloud from €20/month billed annually; self-hosted software has separate hosting costs |
| [Supabase](https://supabase.com/pricing) | Stores the messages | $0 Free plan within its limits |
| [OpenRouter](https://openrouter.ai/anthropic/claude-sonnet-4.6) | Talks to Claude | Pay per use. Sonnet 4.6: $3/million input tokens, $15/million output tokens |
| [Vercel](https://vercel.com/pricing) | Hosts the two web pages | Hobby $0 for personal, non-commercial use; Pro from $20/month plus usage |

The prompts reproduce the stage briefs. Replace Dale's service URLs, workflow
IDs and credential names with your own before using them. The `demo-safe` tag
preserves the prepared fallback before any audience-requested changes.

Prices checked 8 September 2026. These are service prices, not a measured bill
for the talk. The moderator uses Haiku separately. Start with a small credit
balance and stop the answering schedule after testing: every 20 seconds means
about 129,600 scheduled executions in 30 days, even with no questions waiting.
It is intended to run during the demo, not all month on a small cloud plan.

### 1. Make the table

In Supabase, open the SQL editor and run `supabase/schema.sql` from this repo.
That creates the table and locks it down so the public page can only ever read
messages that have already been checked.

### 2. Import the automations

In n8n: **Workflows → Import from File**. Import the intake, answering and
optional email-delivery files in `n8n/`. The answering file is the prepared
fallback, named `answer-the-room-demo-safe.json`.

Open each one and point it at your own credentials — Supabase, OpenRouter and
Gmail. n8n will show you a warning on any node whose credential is missing, so
you are looking for the nodes with warnings on them.

Then activate **Room Intake**. Copy its webhook URL. Activate the answering
workflow only while trying the demo; turn it off afterwards. Keep only one
answering workflow active. Email delivery is manual and sends again if rerun.

### 3. Put the pages up

`form/index.html` is the page people type into. Change the `ENDPOINT` line near
the bottom to your own webhook URL from the step above.

`display/index.html` is the prepared fallback page on the projector. Change the
Supabase URL and publishable key near the bottom to your own. Use `?intake` to
show questions without answers. Never put a service-role key in either page.

Deploy each directory as a separate static Vercel project, for example with
`vercel --prod` from each directory after installing its CLI. There is no app
build step. Update links in the pages to point at your own deployments.

The answering workflow also contains a Supabase URL in its final HTTP step.
Change that URL to your own project and select your own Supabase credential.
This step writes each answer to its own row. Do not replace it with a batch
update whose filter resolves only the first row.

---

## The one part worth copying even if you build nothing else

**The bit that checks what people sent is not optional, and it is the one part
that was not built live on stage.**

An open text box on a projector in a public room, with your name above it, is the
thing that ends an evening badly. So the check runs before anything is stored,
and the page at the front is only ever allowed to read messages that have already
passed it. If the check itself fails, the message is held rather than shown.
The public key cannot read email addresses or moderation reasons. Public reads
must name the allowed columns explicitly rather than asking for every column.

This is a tested moderation layer, not a guarantee that nothing unsafe can ever
pass. Keep a moderator watching and a way to hide messages. Stop accepting
submissions and turn off the workflows after the event.

If you build something like this, do that bit first and do not improvise it.

---

## Where it goes wrong

Honest list, so you do not lose an evening to any of these:

- **The form works on your laptop but not on phones.** You deployed it but the
  page is still pointing at a webhook that only exists on your own machine.
- **Messages arrive but never appear on screen.** They are almost certainly
  sitting there as `pending`, which means the checking step errored. Look at the
  n8n execution log, not the page.
- **Nothing arrives at all.** The browser is blocking it. In the n8n webhook node,
  under Options, add **Allowed Origins** and put your page's address in it.

---

## Questions

Dale Taylor, [aigentic-ai.co.uk](https://aigentic-ai.co.uk).

If you get it running, I would genuinely like to know.
