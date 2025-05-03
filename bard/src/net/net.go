package net

import (
	"github.com/godbus/dbus/v5"
)

const (
	NET_WIFI_ENABLE_ICON    = "󰤯"
	NET_WIFI_CONNECTED_ICON = "󰤨"
	NET_WIFI_DISABLE_ICON   = "󰤮"

	NET_BLUETOOTH_ENABLE_ICON  = "󰂯"
	NET_BLUETOOTH_DISABLE_ICON = "󰂲"

	NETWORK_MANAGER_IFACE = "org.freedesktop.NetworkManager"
)

func getWifiStatus() (enabled bool, connected bool) {
	conn, err := dbus.SystemBus()
	if err != nil {
		panic(err)
	}

	nm := conn.Object(NETWORK_MANAGER_IFACE, "/org/freedesktop/NetworkManager")
	var devices []dbus.ObjectPath
	err = nm.Call(NETWORK_MANAGER_IFACE+".GetDevices", 0).Store(&devices)
	if err != nil {
		panic(err.Error())
	}

	wifi, _ := nm.GetProperty("org.freedesktop.NetworkManager.WirelessEnabled")
	enabled = wifi.Value().(bool)

	for _, devPath := range devices {
		dev := conn.Object(NETWORK_MANAGER_IFACE, devPath)

		var devType uint32
		if err := dev.Call(
			"org.freedesktop.DBus.Properties.Get",
			0,
			"org.freedesktop.NetworkManager.Device",
			"DeviceType",
		).Store(&devType); err != nil || devType != 2 {
			continue
		}

		var state dbus.Variant
		if err = dev.Call(
			"org.freedesktop.DBus.Properties.Get",
			0,
			"org.freedesktop.NetworkManager.Device",
			"State",
		).Store(&state); err != nil {
			continue
		}

		if state.Value().(uint32) == 100 {
			connected = true
			return
		} else {
			connected = false
		}
	}

	return
}

func getBluetoothStatus() bool {
	conn, _ := dbus.SystemBus()
	obj := conn.Object("org.bluez", "/org/bluez/hci0")
	obj = conn.Object("org.bluez", "/org/bluez/hci0")
	ablu, _ := obj.GetProperty("org.bluez.Adapter1.Powered")
	return ablu.Value().(bool)
}

func GetBluetooth() string {
	res := ""
	bluetoothEnabled := getBluetoothStatus()

	if bluetoothEnabled {
		res += NET_BLUETOOTH_ENABLE_ICON
	} else {
		res += NET_BLUETOOTH_DISABLE_ICON
	}

	return res
}

func GetWifi() string {
	res := ""
	wifiEnabled, wifiConnected := getWifiStatus()

	if wifiEnabled {
		if wifiConnected {
			res += NET_WIFI_CONNECTED_ICON
		} else {
			res += NET_WIFI_ENABLE_ICON
		}
	} else {
		res += NET_WIFI_DISABLE_ICON
	}

	return res
}

func ToggleWifi() {
	conn, _ := dbus.SystemBus()
	enabled, _ := getWifiStatus()

	nm := conn.Object(NETWORK_MANAGER_IFACE, "/org/freedesktop/NetworkManager")
	if err := nm.Call(
		"org.freedesktop.DBus.Properties.Set",
		0,
		"org.freedesktop.NetworkManager",
		"WirelessEnabled",
		dbus.MakeVariant(!enabled),
	); err.Err != nil {
		panic(err.Err.Error())
	}
}

func ToggleBluetooth() {
	conn, _ := dbus.SystemBus()
	enabled := getBluetoothStatus()

	adapterPath := dbus.ObjectPath("/org/bluez/hci0")
	adapter := conn.Object("org.bluez", adapterPath)

	if err := adapter.Call("org.freedesktop.DBus.Properties.Set", 0,
		"org.bluez.Adapter1", "Powered", dbus.MakeVariant(!enabled)); err.Err != nil {
		panic(err.Err.Error())
	}
}
