## ¿Qué es la virtualización y los contenedores? ¿Cómo se implementan?

**Virtualizacion**: Permite ejecutar múltiples sistemas operativos (SO) en una única máquina física, creando entornos virtuales completamente independientes llamados máquinas virtuales. Cada VM tiene su propio sistema operativo, recursos de hardware virtualizados y puede ejecutar aplicaciones de manera aislada.
La virtualización se implementa mediante un hipervisor, que es un software que gestiona las máquinas virtuales. 
Aislamiento completo del sistema.

![[Pasted image 20241202025507.png]]

**Contenendores**: Los contenedores son una forma más ligera y eficiente de virtualización que, en lugar de virtualizar el hardware completo, aislan aplicaciones y sus dependencias dentro de un entorno autónomo, utilizando el sistema operativo del host. Los contenedores comparten el kernel del sistema operativo anfitrión, pero están completamente aislados entre sí.
Son mas rapidos de arrancar porque son procesos, no sistemas operativos.
Tienen menos sobrecarga que una vm.

![[Pasted image 20241202025517.png]]