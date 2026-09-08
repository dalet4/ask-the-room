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

You need four accounts. All four have a free tier that covers this.

| What | What it does here | Cost to run this |
| --- | --- | --- |
| [n8n](https://n8n.io) | The automations | Free self-hosted, or from £20/mo cloud |
| [Supabase](https://supabase.com) | Stores the messages | Free tier is plenty |
| [OpenRouter](https://openrouter.ai) | Talks to Claude | Pennies. The whole talk cost under £1 |
| [Vercel](https://vercel.com) | Hosts the two web pages | Free |

### 1. Make the table

In Supabase, open the SQL editor and run `supabase/schema.sql` from this repo.
That creates the table and locks it down so the public page can only ever read
messages that have already been checked.

### 2. Import the automations

In n8n: **Workflows → Import from File**. Import both files in `n8n/`.

Open each one and point it at your own credentials — Supabase, OpenRouter and
Gmail. n8n will show you a warning on any node whose credential is missing, so
you are looking for the nodes with warnings on them.

Then activate **Room Intake**. Copy its webhook URL.

### 3. Put the pages up

`form/index.html` is the page people type into. Change the `ENDPOINT` line near
the bottom to your own webhook URL from the step above.

`display/index.html` is the page on the projector. It is not in this repo yet:
it was built live on the night by an agent, from the brief in
`prompts/2-display.md`, and it lands here afterwards. If you are reading this
before then, send that same brief to a coding agent of your own and you will get
your own version of it. Change the Supabase URL and key near the bottom to your
own.

Drag either folder onto [Vercel](https://vercel.com/new) and it is live. There is
no build step and nothing to install.

---

## The one part worth copying even if you build nothing else

**The bit that checks what people sent is not optional, and it is the one part
that was not built live on stage.**

An open text box on a projector in a public room, with your name above it, is the
thing that ends an evening badly. So the check runs before anything is stored,
and the page at the front is only ever allowed to read messages that have already
passed it. If the check itself fails, the message is held rather than shown.

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

## The prompts

`prompts/` has the briefs that were sent to the agents on the night, word for
word, with the bit said out loud before each one. That is the actual method, and
it is the part worth reading if you want to do this yourself rather than just run
it.

---

## Questions

Dale Taylor, [aigentic-ai.co.uk](https://aigentic-ai.co.uk).

If you get it running, I would genuinely like to know.
