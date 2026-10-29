# see ./misc/msys/libcairo.sh

$venv = poetry env info --path
explorer.exe "$venv\Lib\site-packages\cairocffi\"

# copy cairo-static.dll as libcairo-2.dll
