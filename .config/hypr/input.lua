hl.config({
    input = {
        -- Teclado ABNT2 (Brasil)
        kb_layout  = "br",
        kb_variant = "abnt2",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        -- Foco segue o mouse (1 = ao clicar)
        follow_mouse = 1,

        -- Sensibilidade do mouse: -1.0 a 1.0 (0 = padrão)
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Gestos: 3 dedos horizontal = trocar workspace
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})