# Prompt 2 — the display page

Fires at **07:00**, while prompt 1 is still running. Second agent, second job.

The submission form already exists and is live. This agent builds the **screen**,
not the form.

---

## Say this (out loud, before you send it)

> Second one, completely different job. That one's building the plumbing, this
> one's building the thing you're all going to be looking at.
>
> Notice how much of this prompt is about the room rather than the software.
> Font size, contrast, how far away the back row is. If the thing you're
> building has to work in a physical space, describe the space. Most people
> forget that and then wonder why it looks fine on their laptop and terrible
> on the wall.

---

## Send this

```text
Build a single-page web app that displays audience submissions on a projector.

Data source — Supabase, read-only with the publishable key:
  URL:  https://ivnmtkdxduxjgztjlfzs.supabase.co
  key:  sb_publishable_OAyBkfyfj18XWhD4LWoRkg_bILEyBxm
  table: public.demo_submissions
  columns: id, created_at, message, status, answer, answered_at

Request exactly those columns, never select=*. Email and moderation reasons
are private and the public key cannot read them. Render messages and answers
as plain text using textContent, never innerHTML.

That key can only ever read rows that have already been approved, so you do not
need to filter on status yourself. Order by created_at descending. Poll every 3
seconds.

Each card shows the message, and underneath it the answer once one exists. A card
with no answer yet shows a quiet "thinking…" state rather than an empty space.

It is going on a projector at the front of a room about fifteen metres deep:
- Body text no smaller than 28px. Message text larger than that.
- Dark background, near-white text. Projectors wash out pale colours.
- Never more than 6 cards on screen at once. Newest at the top.
- No horizontal scrolling, no hover states, nothing that needs a mouse.
- New cards animate in gently. Nothing flashes, nothing bounces.

Brand it as Aigentic:
- Background #0b0f20. Body text #f8f7ff. Message text pure white #ffffff.
- Accent #00D4FF for links, labels and focus. Purple #9D4EDD only ever in a
  gradient with the cyan, never on its own. No pink, no orange, no text shadows.
- Montserrat 600 to 700 for the message text, Roboto for everything else,
  from Google Fonts, with Arial as the fallback.
- The logo is already at display/aigentic-logo.svg. Put it top left, 48px,
  next to the word AIGENTIC in Montserrat 700, uppercase, 0.08em letter
  spacing. Do not recolour or redraw it.

Save to display/index.html. Keep the prepared
fallback at the demo-safe tag's display/index.html
unchanged. The public form is https://ask-the-room-omega.vercel.app.
Include a link labelled "Get the workflow" to https://github.com/dalet4/ask-the-room.

One file, plain HTML with inline CSS and JavaScript. No build step, no framework,
no dependencies beyond a fetch to Supabase.

Do not build a submission form. One already exists and is live.
Deploy the display directory to Vercel as its own project, never over the form.
Return its public URL and check it loads without signing in.
```

---

## What "good" looks like

Big text, dark, calm, updates itself. If it ships with tiny text or a light
background, that is the one thing worth fixing live — it takes ten seconds to
say *"make the text twice the size and the background black"* and the room
watches you correct an agent, which is its own useful lesson.
