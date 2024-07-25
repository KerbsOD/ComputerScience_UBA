# Tests

Para correr los tests vamos a usar el framework Google Test.

Cada test tiene que ir en una función separada, y las funciones tienen que
definirse de la siguiente manera:

TEST(nombreDelConjunto, nombreDelTest) {
   // ...
   // aca va el código del test
}

Adentro de las funciones de test se deben usar las funciones ASSERT_*, 
que terminan el test con un error si no se cumple la condicion. Las 
funciones existentes son:

- ASSERT_EQ(x1, x2): (equal): x1 debe ser igual a x2
- ASSERT_NE(x1, x2): (not equal): x1 no debe ser igual a x2
- ASSERT_LT(x1, x2): (lower than): x1 debe ser menor a x2
- ASSERT_LE(x1, x2): (lower or equal than): x1 debe ser menor o igual a x2
- ASSERT_GT(x1, x2): (greater than): x1 debe ser mayor a x2
- ASSERT_GE(x1, x2): (lower or equal than): x1 debe ser mayor o igual a x2

Para números de punto flotante, se deben utilizar funciones específicas:

- ASSERT_FLOAT_EQ(x1, x2)
- ASSERT_DOUBLE_EQ(x1, x2)

Finalmente, para una condición binaria, se puede utilizar:

- ASSERT_TRUE(expr)
- ASSERT_FALSE(expr)
