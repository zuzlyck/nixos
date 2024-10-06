const audio = await Service.import("audio")
const battery = await Service.import("battery")
import brightness from './brightness.js'

function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => audio.speaker.volume = value,
        setup: self => self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0
        }),
    })

    return Widget.Box({
	spacing: 8,
        css: "min-width: 180px",
        children: [icon, slider],
    })
}

function Brightness() {
    const icon = Widget.Icon({
        icon: 'display-brightness-symbolic',
    })

    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
	min: 0.01,
        on_change: ({ value }) => brightness.screen_value = value,
        value: brightness.bind('screen-value'),
    })

    return Widget.Box({
	spacing: 8,
        css: "min-width: 180px",
        children: [icon, slider],
    })
}

function Power() {
  return Widget.Box({
    class_name: "fancy",
    child: Widget.Button({
      hexpand: true,
      on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
      child: Widget.Icon({
    	class_name: "powerbutton",
	icon: 'system-shutdown-symbolic',
      }),
    }),
  })
}

function Logout() {
  return Widget.Box({
    class_name: "fancy",
    child: Widget.Button({
      hexpand: true,
      on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
      child: Widget.Icon('system-log-out-symbolic'),
    }),
  })
}

function ControlBox() {
  return Widget.Box({
    hpack: "end",
    children: [
      Logout(),
      Power(),
    ],
  })
}

function Battery() {
    const icon = battery.bind('icon_name')

    return Widget.Box({
        class_name: "fancy",
	hpack: "start",
        visible: battery.bind("available"),
        children: [
            Widget.Icon({ icon }),
            Widget.Label({
	      label: battery.bind("percent").as(p => ` ${p}%`)
	    }),
        ],
    })
}


function Top() {
  return Widget.CenterBox({
    class_name: "normal",
    spacing: 0,
    start_widget: Battery(),
    end_widget: ControlBox(),
  })
}

function Middle() {
  return Widget.Box({
    class_name: "fancy",
    spacing: 8,
    vertical: true,
    children: [
      Volume(),
      Brightness(),
    ],
  })
}

function Bottom() {
  return Widget.CenterBox({
    class_name: "normal",
    spacing: 0,
    start_widget: Widget.Label('widget'),
    end_widget: Widget.Label('widget'),
  })
}

export default function PanelBox() {
  return Widget.CenterBox({
    class_name: "panelbox",
    vertical: true,
    start_widget: Top(),
    center_widget: Middle(),
    end_widget: Bottom(),
  })
}
