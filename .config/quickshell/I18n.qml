pragma Singleton

import Quickshell
import QtQuick

// Shell texts in the 10 languages. The language is chosen like lang.sh does:
// exact language, then the same language from another region, then en_US
Singleton {
    readonly property var languages: ({
        "en_US": {
            "search": "Search",
            "shutdown": "Shut down",
            "reboot": "Reboot",
            "lock": "Lock",
            "logout": "Log out",
            "clock": "ddd, MMM dd • hh:mm AP",
            "clockAlt": "hh:mm AP",
            "noIp": "No IP",
            "muted": "Muted",
            "volumeHint": "Scroll: adjust volume\nClick: mute/unmute",
            "brightnessHint": "Monitor brightness\nScroll: adjust\nLeft click: 100%\nRight click: 0%"
        },
        "pt_BR": {
            "search": "Buscar",
            "shutdown": "Desligar",
            "reboot": "Reiniciar",
            "lock": "Bloquear",
            "logout": "Sair",
            "clock": "ddd, dd MMM • HH:mm",
            "clockAlt": "HH:mm",
            "noIp": "sem IP",
            "muted": "Mudo",
            "volumeHint": "Rolar: ajustar volume\nClique: silenciar/reativar",
            "brightnessHint": "Brilho do monitor\nRolar: ajustar\nClique esquerdo: 100%\nClique direito: 0%"
        },
        "es_ES": {
            "search": "Buscar",
            "shutdown": "Apagar",
            "reboot": "Reiniciar",
            "lock": "Bloquear",
            "logout": "Cerrar sesión",
            "clock": "ddd, dd MMM • HH:mm",
            "clockAlt": "HH:mm",
            "noIp": "sin IP",
            "muted": "Silenciado",
            "volumeHint": "Desplazar: ajustar volumen\nClic: silenciar/activar",
            "brightnessHint": "Brillo del monitor\nDesplazar: ajustar\nClic izquierdo: 100%\nClic derecho: 0%"
        },
        "fr_FR": {
            "search": "Rechercher",
            "shutdown": "Éteindre",
            "reboot": "Redémarrer",
            "lock": "Verrouiller",
            "logout": "Se déconnecter",
            "clock": "ddd dd MMM • HH:mm",
            "clockAlt": "HH:mm",
            "noIp": "pas d'IP",
            "muted": "Muet",
            "volumeHint": "Défiler : régler le volume\nClic : couper/rétablir le son",
            "brightnessHint": "Luminosité de l'écran\nDéfiler : régler\nClic gauche : 100 %\nClic droit : 0 %"
        },
        "ru_RU": {
            "search": "Поиск",
            "shutdown": "Выключить",
            "reboot": "Перезагрузить",
            "lock": "Заблокировать",
            "logout": "Выйти",
            "clock": "ddd, dd MMM • HH:mm",
            "clockAlt": "HH:mm",
            "noIp": "нет IP",
            "muted": "Без звука",
            "volumeHint": "Прокрутка: громкость\nЩелчок: выкл./вкл. звук",
            "brightnessHint": "Яркость монитора\nПрокрутка: настроить\nЛевый щелчок: 100%\nПравый щелчок: 0%"
        },
        "id_ID": {
            "search": "Cari",
            "shutdown": "Matikan",
            "reboot": "Mulai ulang",
            "lock": "Kunci",
            "logout": "Keluar",
            "clock": "ddd, dd MMM • HH:mm",
            "clockAlt": "HH:mm",
            "noIp": "tanpa IP",
            "muted": "Senyap",
            "volumeHint": "Gulir: atur volume\nKlik: bisukan/bunyikan",
            "brightnessHint": "Kecerahan monitor\nGulir: atur\nKlik kiri: 100%\nKlik kanan: 0%"
        },
        "hi_IN": {
            "search": "खोजें",
            "shutdown": "बंद करें",
            "reboot": "पुनः आरंभ करें",
            "lock": "लॉक करें",
            "logout": "लॉग आउट करें",
            "clock": "ddd, dd MMM • hh:mm AP",
            "clockAlt": "hh:mm AP",
            "am": "पूर्वाह्न",
            "pm": "अपराह्न",
            "noIp": "कोई IP नहीं",
            "muted": "म्यूट",
            "volumeHint": "स्क्रॉल: आवाज़ बदलें\nक्लिक: म्यूट/अनम्यूट",
            "brightnessHint": "मॉनिटर की चमक\nस्क्रॉल: बदलें\nबायाँ क्लिक: 100%\nदायाँ क्लिक: 0%"
        },
        "bn_BD": {
            "search": "খুঁজুন",
            "shutdown": "বন্ধ করুন",
            "reboot": "পুনরায় চালু করুন",
            "lock": "লক করুন",
            "logout": "লগ আউট করুন",
            "clock": "ddd, dd MMM • hh:mm AP",
            "clockAlt": "hh:mm AP",
            "am": "পূর্বাহ্ণ",
            "pm": "অপরাহ্ণ",
            "noIp": "কোনো IP নেই",
            "muted": "নিঃশব্দ",
            "volumeHint": "স্ক্রল: ভলিউম ঠিক করুন\nক্লিক: নিঃশব্দ/শব্দ চালু",
            "brightnessHint": "মনিটরের উজ্জ্বলতা\nস্ক্রল: ঠিক করুন\nবাম ক্লিক: 100%\nডান ক্লিক: 0%"
        },
        "ar_SA": {
            "search": "بحث",
            "shutdown": "إيقاف التشغيل",
            "reboot": "إعادة التشغيل",
            "lock": "قفل",
            "logout": "تسجيل الخروج",
            "clock": "dddd، dd MMM • HH:mm",
            "clockAlt": "HH:mm",
            "noIp": "لا يوجد IP",
            "muted": "صامت",
            "volumeHint": "التمرير: ضبط مستوى الصوت\nالنقر: كتم/إلغاء الكتم",
            "brightnessHint": "سطوع الشاشة\nالتمرير: ضبط\nالنقر الأيسر: 100%\nالنقر الأيمن: 0%"
        },
        "zh_CN": {
            "search": "搜索",
            "shutdown": "关机",
            "reboot": "重启",
            "lock": "锁定",
            "logout": "注销",
            "clock": "MM月dd日 dddd • HH:mm",
            "clockAlt": "HH:mm",
            "noIp": "无 IP",
            "muted": "静音",
            "volumeHint": "滚动：调节音量\n点击：静音/取消静音",
            "brightnessHint": "显示器亮度\n滚动：调节\n左键单击：100%\n右键单击：0%"
        }
    })

    readonly property var t: pick(Qt.locale().name)

    // A date in a Qt format, with AM/PM in the language when Qt writes it
    // in English
    function format(date, pattern) {
        const text = date.toLocaleString(Qt.locale(), pattern);
        if (!t.am)
            return text;
        return text.replace(/\b(AM|PM)\b/, date.getHours() < 12 ? t.am : t.pm);
    }

    function pick(name) {
        if (languages[name])
            return languages[name];
        const language = name.split("_")[0];
        for (const code in languages) {
            if (code.split("_")[0] === language)
                return languages[code];
        }
        return languages["en_US"];
    }
}
