
rem Crear una carpeta donde se va a guardar el ejecutable de Timer Resolution
mkdir "C:\TimerResolution"

rem Mover el ejecutable a esa carpeta
copy TimerTool.exe "C:\TimerResolution\"

rem Crear un archivo en la ruta de ejecución automática para inicializar Timer Resolution con parámetros específicos
(
  echo start "" "C:\TimerResolution\TimerTool.exe" -t 0.5 -minimized
) > "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Timer Resolution Start.bat"

rem Mensaje de confirmación
echo Se ha configurado la ejecución automática de Timer Resolution con los parámetros especificados. Cada vez que su pc se prenda se inicializara en segundo plano
si quiere revertir eso borre la carpeta "Timer Resolution" en la siguiente ruta C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
