# A odin wrapper for the [termbox2](https://github.com/termbox/termbox2/)

## Simple example
1. Clone this repo any where you like (preferably into (odin repo location)/shared) and import it
2. Install termbox2
```
git clone https://github.com/termbox/termbox2/
cd termbox2
sudo make install_lib
sudo ldconfig
```
3. main.odin:
```odin
package main

import tb2 "shared:odin-tb2"

main :: proc() {
	tb2.init();defer tb2.shutdown()

	tb2.printf(0, 0, .Red, .Default, "width=%d height=%d", tb2.width(), tb2.height())
	tb2.present()

	ev: tb2.Event
	tb2.poll_event(&ev)
}
```
then just `odin run main.odin -file`
