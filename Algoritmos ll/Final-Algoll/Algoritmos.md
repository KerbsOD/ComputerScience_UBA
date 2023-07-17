## BubbleSort
![[Pasted image 20230715220644.png]]
- Peor caso: $\mathcal{O}(n^{2})$
- Estable? Si

---
## SelectionSort
![[Pasted image 20230715221123.png]]

- Peor Caso: $\mathcal{O(n^2)}$
- Estable? No.
---
## InsertionSort
![[Pasted image 20230715223337.png]]
- Peor Caso: $\mathcal{O(n^2)}$
- Estable?: Si
- Inserta cada clave entre el inicio y su posicion actual. Hace un orden relativo al actual. 
---
## BucketSort
![[Pasted image 20230715223754.png]]
- Peor Caso: $\mathcal{O(n*m)}$ siendo m la cantidad de buckets. 
- Estable? Si, recorre en orden.
---
## CountingSort
![[Pasted image 20230715224407.png]]
![[Pasted image 20230715224419.png]]
- Peor Caso: $\mathcal{O(n+k)}$
- Estable? Si, si dos elementos son de la misma clase, se insertan en su orden relativo.
---
## RadixSort
![[Pasted image 20230715224715.png]]
- Peor caso: $\mathcal{O(n+k)}$ (con las cifras acotadas)
- Estable? Si, se basa en estabilidad pues se centra en ordenes relativos.
---
## MergeSort
![[Pasted image 20230715220611.png]]
- Pero caso: $\mathcal{O(nlogn)}$
- Estable? Si
---
## QuickSort
![[Pasted image 20230715233039.png]]
- Peor Caso: $\mathcal{O(n^2)}$
- Estable? No.
- in-place

---
## Heapify
[[Heapify]]

---
## Hashing
[[Hashing]]