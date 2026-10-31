-- ─── Look & Feel ────────────────────────────────────────────
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,
        -- Sem borda: as janelas se destacam pela sombra. A espessura é a
        -- mesma (zero) com e sem foco, então nada muda de tamanho
        border_size = 0,

        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 8,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        -- Sombra suave em volta das janelas, mais forte na que tem foco
        shadow = {
            enabled        = true,
            range          = 16,
            render_power   = 3,
            color          = 0x66000000,
            color_inactive = 0x33000000,
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