package battery

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

const (
	BATTERY_CAPACITY_FILE_PATH = "/sys/class/power_supply/macsmc-battery/capacity"
	BATTERY_STATUS_FILE_PATH   = "/sys/class/power_supply/macsmc-battery/status"
	BATTERY_CHARGING_ICON      = ""
)

func getBatteryCapIcon(cap uint8, status string) string {
	var icons = [...]string{"󰂎", "󰁺", "󰁻", "󰁼", "󰁽", "󰁾", "󰁿", "󰂀", "󰂁", "󰂂", "󰁹", "󰂄"}
	if status == "Charging" {
		return icons[len(icons)-1]
	}

	return icons[int(cap/10)]
}

func Get() string {
	bcap, err := os.ReadFile(BATTERY_CAPACITY_FILE_PATH)
	if err != nil {
		panic(err.Error())
	}

	cap := strings.TrimSpace(string(bcap))

	bstatus, err := os.ReadFile(BATTERY_STATUS_FILE_PATH)
	if err != nil {
		panic(err.Error())
	}

	status := strings.TrimSpace(string(bstatus))
	icap, _ := strconv.ParseUint(cap, 10, 8)

	return fmt.Sprintf(
		"%s%% %s",
		cap,
		getBatteryCapIcon(uint8(icap), status),
	)
}
