int puntaje(int b) {
	int res;
	if (b < 10) {
		res = 2 * b;
	} else {
		res = b;
	}
	if (b % 3 == 0) {
		res = res + 10;
	} else {
		res = res - 10;
	}
	return res;
}
