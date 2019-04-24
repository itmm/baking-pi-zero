#include "gpio.h"
#include "timer.h"

extern "C" int main() {
	Act_Led led;

	unsigned msg =
		0b11111111101010100010001000101010;

	bool v = true;
	for(;;) {
		unsigned m = msg;
		for (int i = 32; i; --i) {
			led = (bool) (m % 2);
			m >>= 1;
			wait(300000);
		}
	}
}
