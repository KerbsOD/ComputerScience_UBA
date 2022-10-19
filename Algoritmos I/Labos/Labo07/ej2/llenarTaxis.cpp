int llenarTaxis1(int g1, int g2, int g3) {
	int res = g3 + (g2 + 1) / 2 + (g1 + 3) / 4;
	return res;
}

int llenarTaxis2(int g1, int g2, int g3) {
	int res = g3;

	if (g1 <= g3) {
		g1 = 0;
	} else {
		g1 = g1 - g3;
	}

	return res + (g2 + 1) / 2 + (g1 + 3) / 4;
}

int llenarTaxis3(int g1, int g2, int g3) {
	int res = g3;

	if (g1 <= g3) {
		g1 = 0;
	} else {
		g1 = g1 - g3;
	}

	res = res + g2 / 2;
	if (g2 % 2 == 0) {
		if (g1 >= 2) {
			g1 = g1 - 2;
		} else {
			g1 = 0;
		}
	}

	return res + (g1 + 3) / 4;
}
