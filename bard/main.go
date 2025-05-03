package main

import (
	"bard/src/battery"
	"bard/src/net"
	timedate "bard/src/time_date"
	"fmt"
	"os"
)

func main() {
	args := os.Args[1:]
	if len(args) == 0 {
		panic("expected a cli argument")
	}

	switch args[0] {
	case "battery":
		fmt.Print(battery.Get())

	case "time-date":
		fmt.Print(timedate.Get())

	case "net-wifi":
		fmt.Print(net.GetWifi())

	case "net-blu":
		fmt.Print(net.GetBluetooth())

	case "net-wifi-toggle":
		net.ToggleWifi()

	case "net-blu-toggle":
		net.ToggleBluetooth()
	}
}
