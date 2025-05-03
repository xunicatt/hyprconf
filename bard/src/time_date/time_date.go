package timedate

import "time"

func Get() string {
	time := time.Now()
	return time.Format("02 Jan 2006 03:04 PM")
}
