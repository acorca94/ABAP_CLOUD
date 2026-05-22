
CLASS zcl_readme_06 DEFINITION PUBLIC FINAL CREATE PUBLIC.
*  --------------------------------------------------------------------
*  El Orden de Creación (De lo pequeño a lo grande)

*  En SAP, los objetos dependen unos de otros. Por eso, el orden correcto es "de abajo hacia arriba":

*  1. Elementos de Datos (Data Elements): Son los "ladrillos". Definen qué tipo de dato es cada campo (si es un número, un texto de 60 caracteres, una moneda, etc.). Se crean primero porque la tabla los necesita para existir.

*  2. Tabla de Base de Datos (Database Table): Es la "estructura del edificio". Aquí defines las columnas y les asignas los elementos de datos que creaste en el paso anterior.

*  3. Clase Global CRUD (Logic Class): Es el "sistema eléctrico y de fontanería". Aquí escribes el código que permite insertar, leer, modificar o borrar datos en la tabla. No se puede activar si la tabla no existe.

*  4. Clase de Prueba (Main/Test Class): Es el "usuario entrando a vivir". Es una clase con un método main que llama a la clase CRUD para probar que todo funciona y ver los resultados en la consola.
*  --------------------------------------------------------------------
ENDCLASS.



CLASS ZCL_README_06 IMPLEMENTATION.
ENDCLASS.
