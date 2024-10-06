const hyprland = await Service.import("hyprland")
const notifications = await Service.import("notifications")
const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")
const bluetooth = await Service.import('bluetooth')
const network = await Service.import('network')

import brightness from './brightness.js'
import PanelBox from './panel.js'

const date = Variable("", {
  poll: [1000, 'date "+%H:%M"'],
})

function Wifi() {
  return Widget.Box({
    children: [
      Widget.Icon({
        icon: network.wifi.bind('icon_name'),
      }),
      Widget.Label({
        label: network.wifi.bind('ssid')
          .as(ssid => ssid || 'Unknown'),
      }),
    ],
  })
}

function Bluetooth() {
  return Widget.Box({
    children: [
      Widget.Icon({
	icon: bluetooth.bind('enabled').as(on =>
	  `bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
      }),
      Widget.Box({
	setup: self => self.hook(bluetooth, self => {
	  self.children = bluetooth.connected_devices
	    .map(({ icon_name, name }) => Widget.Box([
	      Widget.Icon(icon_name + '-symbolic'),
	      Widget.Label(name),
	    ]));

	  self.visible = bluetooth.connected_devices.length > 0;
	}, 'notify::connected-devices'),
      }),
    ],
  })
}

function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id")
  const workspaces = hyprland.bind("workspaces")
    .as(ws => ws.map(({ id }) => Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Label(`${id}`),
      class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
    })))

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  })
}

function Clock() {
  return Widget.Label({
    label: date.bind(),
  })
}

function Volume() { 
  return Widget.Button({
    on_clicked: () => audio.speaker.is_muted = !audio.speaker.is_muted,
    child: Widget.Icon().hook(audio.speaker, self => {
      const vol = audio.speaker.volume * 100;
      const icons = {
	101: "overamplified",
	67: "high",
	34: "medium",
      	1: "low",
      	0: "muted",
      };

      function getIcon() {
	const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
	  threshold => threshold <= audio.speaker.volume * 100)

	  return `audio-volume-${icons[icon]}-symbolic`
      };

      self.icon = getIcon();
      self.tooltip_text = `Volume ${Math.floor(vol)}%`;
    }),
  })
}

function PanelToggle() {
  return Widget.Button({
    on_clicked: () => App.toggleWindow('Panel'),
    child: Widget.Icon({
      icon: 'applications-system-symbolic',
    }),
  })
}

function BatteryLabel() {
  const icon = battery.bind('icon_name')

  return Widget.Box({
    visible: battery.bind("available"),
    children: [
      Widget.Icon({ icon }),
    ],
  })
}

function Brightness() {
 
  const icon = Widget.Icon({
    icon: 'display-brightness-symbolic',
    tooltip_text: brightness.bind('screen-value').as(v => ` ${Math.round(v * 1000) / 10}%`),
  })

  return Widget.Box({
    children: [
      icon,
    ],
  })
}

function SysTray() {
  const items = systemtray.bind("items")
    .as(items => items.map(item => Widget.Button({
      child: Widget.Icon({ icon: item.bind("icon") }),
      on_primary_click: (_, event) => item.activate(event),
      on_secondary_click: (_, event) => item.openMenu(event),
      tooltip_markup: item.bind("tooltip_markup"),
    })))

  return Widget.Box({
    children: items,
  })
}

function Left() {
  return Widget.Box({
    class_name: "left",
    spacing: 8,
    children: [
      Workspaces(),
    ],
  })
}

function Center() {
  return Widget.Box({
    class_name: "center",
    spacing: 8,
    children: [
      Clock(),
    ],
  })
}

function Right() {
  return Widget.Box({
    class_name: "right",
    hpack: "end",
    spacing: 8,
    children: [
      SysTray(),
      Wifi(),
      Bluetooth(),
      Brightness(),
      Volume(),
      BatteryLabel(), 
      PanelToggle(),
    ],
  })
}

function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`, // name has to be unique
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    margins: [5, 5, 0, 5],
    exclusivity: "exclusive",
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  })
}

function Panel() {
  return Widget.Window({
    name: "Panel",
    class_name: "panel",
    anchor: ["top", "right"],
    margins: [5, 5, 0, 0],
    visible: false,
    child: PanelBox(),
  })
}

App.config({
  style: "./style.css",
  windows: [
    Bar(0),
    Panel(),
  ],
})

export { }
