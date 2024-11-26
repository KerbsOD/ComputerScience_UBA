{ h[$0]++ }
END {
	for (k in h)
		printf "%s %d\n", k, h[k]
}
