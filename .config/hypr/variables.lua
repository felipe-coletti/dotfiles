-- ─── Programas ───────────────────────────────────────────────
terminal    = "foot"
fileManager = "thunar"
menu        = "wofi --show drun"

-- ─── Variáveis de ambiente ──────────────────────────────────
hl.env("XCURSOR_SIZE",    "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- ─── Layouts ────────────────────────────────────────────────
hl.config({ dwindle  = { preserve_split = true } })
hl.config({ master   = { new_status = "master" } })
hl.config({ scrolling = { fullscreen_on_one_column = true } })