# Prompt 3 — the room's feature request

Fires at **16:00**. Fresh agent session. This is the beat nobody can fake, and
the only prompt you finish writing on stage.

---

## Say this (out loud)

> Three of you have asked for features. I'm going to pick one and we're going to
> build it now.
>
> I'm pasting it in exactly as it was typed. I'm not tidying it up, I'm not
> rewriting it into a nice specification. Partly because that's the honest
> version, and partly because if I cleaned it up you'd all quite reasonably
> assume I'd planted it.

Read their words out. Paste. Then take questions from the floor while it runs.

---

## Send this

Paste the wrapper below, with **their text dropped in verbatim** — typos,
missing punctuation, swearing and all. Do not correct it.

```text
Someone in the audience just asked for this feature, in their own words:

"<PASTE THEIR SUBMISSION HERE EXACTLY AS TYPED>"

Add it to the display page at <PASTE THE DEPLOYED DISPLAY URL>. The source is a
single HTML file.

This is happening live in front of a room, so:
- Smallest change that honestly delivers what they asked for.
- Do not refactor anything that already works.
- Do not add anything they did not ask for.
- If their request is ambiguous, pick the most obvious reading and say in one
  line which reading you picked.
- If it cannot be done in this app at all, say so plainly in one sentence and
  suggest the nearest thing that can.

Then redeploy it.
```

---

## Choosing which one

Pick on these grounds, in order:

1. **Visible on the projector.** A colour change, a sort order, a counter, an
   emoji reaction. Not something that happens in the database where nobody can
   see it.
2. **One sentence to describe.** If you need two, it is too big for five minutes.
3. **Not the funniest one.** The funniest one is usually impossible. Read it out,
   get the laugh, then build a different one.

If all three requests are unbuildable, say so and build the best of a bad set
anyway — *"this one's a stretch, let's see how far it gets"* is a perfectly good
five minutes, and the room is on your side by this point.
