moon run --target native src/funcref_qsort/ > snapshot.txt
moon run --target native src/funcref_qsort_without_stub/ >> snapshot.txt
moon run --target native src/funcref_qsort_closure/ >> snapshot.txt     
moon run --target native src/funcref_register_callback/ >> snapshot.txt
moon run --target native src/funcref_map_inplace/ >> snapshot.txt