-- ─── Look & Feel ────────────────────────────────────────────
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,
        -- A espessura é a mesma com e sem foco (senão a janela muda de
        -- tamanho ao trocar o foco); sem foco, a borda só fica transparente
        border_size = 2,

        col = {
            active_border   = "rgb(d4d4d4)",
            inactive_border = "rgba(00000000)",
        },

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 4,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },

    -- Comportamento geral
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
        -- Se o Quickshell parar com a tela bloqueada, abri-lo de novo
        -- retoma a tela de bloqueio
        allow_session_lock_restore = true,
    },
})