#!/usr/bin/env bash
echo
echo "** Compilando"

make tester
if [ $? -ne 0 ]; then
  echo "  ** Error de compilacion"
  exit 1
fi

echo
echo "** Corriendo Valgrind"

command -v valgrind > /dev/null
if [ $? -ne 0 ]; then
  echo "ERROR: No se encuentra valgrind."
  exit 1
fi

valgrind --show-reachable=yes --leak-check=full --error-exitcode=99 ./tester
tester_result=$?

if [ $tester_result -eq 99 ]; then
  echo "** Error de memoria"
  exit 1
elif [ $tester_result -ne 0 ]; then
  echo "** Error durante la ejecución"
else
  echo "** Todos los tests pasan"
fi
echo

