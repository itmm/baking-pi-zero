#pragma once

	class Act_Led {
		public:
			Act_Led() {
				* (unsigned *) f_addr =
					f_val;
			};
			Act_Led &operator=(bool on) {
				unsigned *a = (unsigned *) on_addr;
				if (! on) { a += off_delta; }
				*a = on_val;
				return *this;
			}
		private:
			static constexpr unsigned base { 0x20200000 };
			static constexpr unsigned pin { 47 };

			static constexpr unsigned f_off { 4 * (pin / 10) };
			static constexpr unsigned f_val { 1 << ((pin % 10) * 3) };
			static constexpr unsigned f_addr { base + f_off };
			
			static constexpr unsigned on_off { 4 * (pin / 32) + 28 };
			static constexpr unsigned on_addr { base + on_off };
			static constexpr unsigned off_delta { (40 - 28)/sizeof(unsigned) };
			static constexpr unsigned on_val { 1 << (pin % 32) };

	};

