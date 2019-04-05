import tarfile
tar = tarfile.open("qc_error.tar.gz", "w:gz")
for name in ["*.txt"]:
	tar.add(name)
tar.close()
