

# LAB 1

1. **Analice el flujo de información en el camino de datos y los estados en el autómata de control en los cálculos mcd(21, 12) y mcd(0, 8). Una forma de representar los cálculos es mediante una tabla (Figura 5). Los acrónimos mxa y mxb indican las salidas de los multiplexores ubicados en las entradas del módulo sub (Figura 2). El multiplexor mxa es el ubicado en la parte superior de la figura., en la página 4.**


    |  ciclo |  estado |  ra |  rb | menor  |  mxa | mxb  |  sub | cero  |
    |:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
    |  1 | ESP  |  X | X  |  X | X  | X  | X  | X  |
    | 2  | CALC  | 21  | 12  | 0  | 21  | 12  | 9  | 0  |
    |  3 | CALC  |  9 | 12  | 1  | 12  | 9  |  3 |  0 |
    |  4 | CALC  |  3 | 9  |  1 | 9  | 3  |  6 |0   |
    |  5 | CALC  | 6  |  3 |  0 |  6 | 3  |  3 | 0  |
    |  6 |  CALC |  3 |  3 |  0 | 3  |  3 |   0|  0 |
    |  7 |  CALC | 0  |  3 |  1 |  3 |  3 |  3 |   1|
    |  8 | HECHO  |  3 |  0 |  0 | 3  |  0 |  3 |   1|
    _Tabla 1: Evolución de señales durante el cálculo de mcd(21, 12)._


    |  ciclo |  estado |  ra |  rb | menor  |  mxa | mxb  |  sub | cero  |
    |:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
    |  1 | ESP  |  X | X  |  X | X  | X  | X  | X  |
    | 2  | CALC  | 0  | 8  | 1  | 8  | 0  | 8  | 1 |
    |  3 | HECHO  |  8 | 0  | 0 | 8  | 0  |  8|  1 |